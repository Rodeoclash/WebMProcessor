class Api::V1::SettingsController < ApplicationController
	respond_to :json

	def index
		@settings = {
			MIN_FRAME_RATE: ENV['MIN_FRAME_RATE'],
			MAX_FRAME_RATE: ENV['MAX_FRAME_RATE'],
			MIN_BIT_RATE: ENV['MIN_BIT_RATE'],
			MAX_BIT_RATE: ENV['MAX_BIT_RATE'],
			MIN_BUFFER_SIZE: ENV['MIN_BUFFER_SIZE'],
			MAX_BUFFER_SIZE: ENV['MAX_BUFFER_SIZE'],
			MIN_BIT_RATE_TOLERANCE: ENV['MIN_BIT_RATE_TOLERANCE'],
			MAX_BIT_RATE_TOLERANCE: ENV['MAX_BIT_RATE_TOLERANCE'],
			MIN_KEYFRAME_INTERVAL: ENV['MIN_KEYFRAME_INTERVAL'],
			MAX_KEYFRAME_INTERVAL: ENV['MAX_KEYFRAME_INTERVAL'],
			MIN_DURATION: ENV['MIN_DURATION'],
			MAX_DURATION: ENV['MAX_DURATION'],
			FIREBASE_URI: ENV['FIREBASE_URI'],
			AWS_BUCKET: ENV['AWS_BUCKET'],
			MIN_FILESIZE: ENV['MIN_FILESIZE'],
			MAX_FILESIZE: ENV['MAX_FILESIZE'],
			RESOLUTIONS: [
				{
					name: "720p (960x720/16:9)",
					value: "960x720"
				},
				{
					name: "1080p (1920x1080/16:9)",
					value: "1920x1080"
				},
				{
					name: "QVGA (320x240/4:3)",
					value: "320x240"
				},
				{
					name: "VGA (640x480/4:3)",
					value: "640x480"
				},
				{
					name: "SVGA (1280x1024/4:3)",
					value: "1280x1024"
				}
			]
		}

		respond_with @settings
	end

end