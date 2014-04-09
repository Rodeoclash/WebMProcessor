require 'carrierwave/orm/activerecord'

class EncodingJob < ActiveRecord::Base
	mount_uploader :movie, MovieUploader

	validates :video_bitrate, :numericality => { :greater_than_or_equal_to => 100, :less_than_or_equal_to => 1500 }
	validates :video_bitrate_tolerance, :numericality => { :greater_than_or_equal_to => 100, :less_than_or_equal_to => 1500 }
	validates :video_max_bitrate, :numericality => { :less_than_or_equal_to => 1500 }
	validates :video_min_bitrate, :numericality => { :greater_than_or_equal_to => 100 }
	validates :buffer_size, :numericality => { :greater_than_or_equal_to => 100, :less_than_or_equal_to => 1500 }
	validates :duration, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10 }
	validates :keyframe_interval, :numericality => { :greater_than_or_equal_to => 100, :less_than_or_equal_to => 500 }

	default_value_for :video_codec, "libvpx"
	default_value_for :frame_rate, 30
	default_value_for :resolution, "640x480"
	default_value_for :video_bitrate, 750
	default_value_for :video_bitrate_tolerance, 100
	default_value_for :video_max_bitrate, 1500
	default_value_for :video_min_bitrate, 100
	default_value_for :audio_codec, "aac"
	default_value_for :audio_bitrate, 32
	default_value_for :audio_sample_rate, 22050
	default_value_for :audio_channels, 1
	default_value_for :keyframe_interval, 250
	default_value_for :buffer_size, 1500
	default_value_for :threads, 1
	default_value_for :duration, 10
	default_value_for :seek_time, 0
	default_value_for :custom, "-an"

	after_initialize :generate_uuid

	def encoding_progress(amount)
		puts "Encoded: #{amount}"
	end

	private

		def generate_uuid
			self.uuid = SecureRandom.uuid unless self.uuid?
		end

end