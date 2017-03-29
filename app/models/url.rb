class Url < ActiveRecord::Base
  validates_presence_of :original_url, :strink, :visits
  validates_uniqueness_of :original_url, :strink
  validate :strink_has_chars
  validates_format_of :original_url, with: /\Ahttps?:\/\/\w+\.\w{2,}/, message: "must begin with 'http://' or 'https://', or at least end with '.so/.me/.thi/.ng/.li/.ke/.th/.is'"
  validates_format_of :strink, with: /[BFPRV]{8}/i, message: "must contain some combination of 8 of these characters: B F P R V (case-insensitive)"
  after_initialize :set_defaults

  def prepare!
    self.elaborate_original_url
    self.sharten!
  end

  def sharten!
    possible_strink = get_random_strink
    while Url.strink_taken?(possible_strink)
      possible_strink = get_random_strink
    end
    self.strink = possible_strink
    self
  end

  def shartened_url
    "http://shart.lol/#{strink}rRT"
  end
  
  def elaborate_original_url
    unless /https?:\/\/\w+\.\w{2,}/ =~ self.original_url
      self.original_url = "http://#{self.original_url}"
    end
    return self.original_url
  end

  private
  def set_defaults
    self.visits = 0 if self.visits.nil?
    self.strink = "" if self.strink.nil?
  end


  def get_random_strink
    shars = %w(B b F f P p R r V v)
    (0...8).map{ shars[rand(shars.length)] }.join
  end

  def self.strink_taken?(possible_strink)
    Url.all.map(&:strink).include?(possible_strink)
  end

  def strink_has_chars
    errors.add(:strink, "must have at least one character") unless self.strink.length > 0
  end
end
