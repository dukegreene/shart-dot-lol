describe "url creation", :type => :feature do
  before :each do
    Url.create(original_url: "example.com")
  end

  it "creates a url" do
    visit '/'
    within("#shartener-form") do
      fill_in "url[original_url]", with: 'example.com'
    end
    click_button "shartener-button"
    expect(page).to have_content '!!!'
  end
end