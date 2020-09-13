class VideosController < ApplicationController
  before_action :check_authentication, only: [:new, :create]

  def new
    @video = Video.new
  end

  def index
    @videos = Video.order("created_at DESC")
  end

  def create
    @video = Video.new(video_params)
    @video.user = current_user
    begin
      if @video.save
        flash[:success] = "Share movie successfully"
        redirect_to root_url
      else
        flash.now[:alert] = "Youtube video URL is invalid"
        render :new
      end
    rescue
      flash.now[:alert] = "Youtube video is not found"
      render :new
    end
  end

  private
  def video_params
    params.require(:video).permit(:link)
  end
end
