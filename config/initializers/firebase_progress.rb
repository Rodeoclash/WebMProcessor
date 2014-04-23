require "#{Rails.root}/config/initializers/firebase_progress.rb"

class FirebaseProgress

	def initialize(options)
		@uuid = options[:uuid]
		@client = Firebase::Client.new(ENV['FIREBASE_URI'])
	end

	def update(details)
		#Rails.logger.debug "Status: #{details[:status]}, Progress: #{details[:progress_percentage]}, Download ready: #{details[:ready_for_download]}, Had error: #{details[:error_with_transcoding]}"
		#puts "Status: #{details[:status]}, Progress: #{details[:progress_percentage]}"
		@client.set(@uuid, {
			:progress_percentage => details[:progress_percentage],
			:status => details[:status],
			:ready_for_download => details[:ready_for_download],
			:error_with_transcoding => details[:error_with_transcoding]
		})
	end

	# removes the data from the firebase endpoint
	def remove
		@client.delete(@uuid)
	end

end