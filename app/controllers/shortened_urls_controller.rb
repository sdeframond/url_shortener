class ShortenedUrlsController < ApplicationController

  def show
    @fancy_url = fancy_url(ShortenedUrl.where(url_hash: params[:id]).first!)
  end

  def new
    @shortened_url = ShortenedUrl.new
  end

  def create
    @shortened_url = ShortenedUrl.find_or_create(shortened_url_params)
    if @shortened_url.valid?
      redirect_to @shortened_url
    else
      render 'new'
    end
  end

  def redirect
    @url = ShortenedUrl.where(url_hash: params[:url_hash]).first!
    session.update({}) unless session.id
    @url.track_redirection!(session.id, env)
    redirect_to @url.full_url
  end

  private

  def shortened_url_params
    params.require(:shortened_url).permit(:full_url)
  end
end
