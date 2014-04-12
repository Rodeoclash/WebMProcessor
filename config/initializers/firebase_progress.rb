class FirebaseProgress

	#ENV['FIREBASE_KEY']

	def initialize(options)
		@uuid = options[:uuid]
		@client = Firebase::Client.new(ENV['FIREBASE_URI'])
	end

	def started
		payload = {
			:progress => 0.0,
			:status => "Enqueued"
		}
		@client.set(@uuid, payload)
	end

	def updated(progress_percentage)
		payload = {
			:progress => progress_percentage,
			:status => "Encoding movie..."
		}
		@client.set(@uuid, payload)
	end

	def finished
		payload = {
			:progress => 1.0,
			:status => "Finished"
		}
		@client.set(@uuid, payload)
		sleep 2
		@client.delete(@uuid)
	end

end