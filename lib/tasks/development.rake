namespace :development do

  desc "Test encoding a movie"
  task test_encode: :environment do
  	encoding_job = EncodingJob.last
  	encoding_job.queue_job_id = nil
  	encoding_job.save!
  end

end