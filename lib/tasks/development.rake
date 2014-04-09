namespace :development do

  desc "Test encoding a movie"
  task test_encode: :environment do
  	encoding_job = EncodingJob.new
  	encoding_job.movie = File.open("#{Rails.root}/tmp/sample_videos/trailer_480p.mov")
  	encoding_job.save!
  end

end