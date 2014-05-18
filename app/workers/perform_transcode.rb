class PerformTranscode
  include Sidekiq::Worker

  def perform(encoding_job_id)

    # hacky, ensure that the item is in the database
    sleep 2

    encoding_job = EncodingJob.find(encoding_job_id)

    encoding_job.firebase_progress.update({
      progress_percentage: 0,
      status: "Preparing your video for processing...",
      ready_for_download: false,
      error_with_transcoding: false
    })

    # download the file from S3 and kick of the processing of it
    encoding_job.remote_movie_url = encoding_job.movie.direct_fog_url + Hash.from_xml(encoding_job.s3_response)["PostResponse"]["Key"]
    encoding_job.save

    encoding_job.firebase_progress.update({
      progress_percentage: 100,
      status: "Your video is ready to be downloaded!",
      ready_for_download: true,
      error_with_transcoding: false
    })

  end

end