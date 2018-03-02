class UrlsController < ApplicationController

  def new
    @url = Url.new
  end

  def create
    if existing_url = Url.existing_url_for(url_params[:original_url])
      return render partial: "url", locals: {url: existing_url}
    end

    @url = Url.new(url_params).prepare!
    if @url.save
      if request.xhr?
        render partial: "url", locals: {url: @url}
      else
        redirect_to @url, notice: "#{@url.strink}!!! You've totally shartened it!"
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
    @url = Url.find(params[:id])
  end

  def redirect
    p "&" * 80
    strink = params[:strink]
    url = Url.find_by(strink: strink)
    if url.nil?
      redirect_to root_path
    else
      url.visits += 1
      url.save
      redirect_to url.original_url
    end
  end

  private
  
  def url_params
    params.require(:url).permit(:original_url)
  end

end
