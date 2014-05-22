module EncodingJobsHelper

	def encoding_job_show_url(encoding_job)
		"http://#{ENV['SITE_DOMAIN']}/#/encoding_job/#{encoding_job.uuid}/show"
	end

end