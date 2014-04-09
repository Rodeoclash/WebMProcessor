class FirebaseProgress

	URI = "https://webmprocessor.firebaseio.com".freeze
	KEY = "XNOZwXBLv3mficZE1IMYog3WUCHBJhhIeLsHHwEy".freeze

	def initialize(options)
		@uuid = options[:uuid]
		@client = Firebase::Client.new(URI)
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