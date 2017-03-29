class UrlsController < ApplicationController

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params).prepare!
    if @url.save
      if request.xhr?
        render partial: "url", locals: {url: @url}
      else
        redirect_to @url, notice: "#{@url.strink}rRT!!! You've totally shartened it!"
      end
    else
      @errors = @url.errors.full_messages
      if request.xhr?
        render partial: "errors", status: 422, locals: {errors: @errors}
      else
        render action: "new"
      end
    end
  end

  def show
    @Url = Url.find(params[:id])
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
  end
end
