	class FirebaseProgress

		def initialize(options)
			@uuid = options[:uuid]

			puts "---- loaded gems"
			puts Gem.loaded_specs.keys
			puts "----------------"

			@client = ::Firebase::Client.new(ENV['FIREBASE_URI'])
		end

		def update(details)
			@client.set(@uuid, {
				:progress_percentage => details[:progress_percentage],
				:status => details[:status],
				:ready_for_download => details[:ready_for_download],
				:error_with_transcoding => details[:error_with_transcoding]
			})
		end

		def remove
			@client.delete(@uuid)
		end

	end