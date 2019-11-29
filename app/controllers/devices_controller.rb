class DevicesController < ApplicationController
	def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
    #response = HTTParty.get("http://localhost:3000/api/devices/schedule?device_internal_name=#{@device.internal_name}")
    video_info = '/home/alexandr/Загрузки/Mt_Baker.mp4', 'Mt_Baker.mp4'
    media = Media.create
    media.video.attach(io: File.open(video_info[0]), filename: video_info[1])
    @video_url = Rails.application.routes.url_helpers.rails_blob_url(media.video)
    media.save
  end

  def new
    
  end

  def create
    @device = Device.new
    @device.name = params[:name]
    @device.internal_name = params[:internal_name]
    @device.save
    redirect_to root_path
  end
end
