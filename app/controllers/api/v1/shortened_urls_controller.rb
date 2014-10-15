class Api::V1::ShortenedUrlsController < Api::V1::ApplicationController
  def show
    url = ShortenedUrl.find_by_url_hash!(params[:id])
    respond_with url
  end

  def create
    url = ShortenedUrl.new(shortened_url_params)
    if url.save
      respond_with url, location: api_v1_shortened_url_url(url)
    else
      respond_with url
    end
  end

  private

  def shortened_url_params
    params.require(:shortened_url).permit(:full_url)
  end
end