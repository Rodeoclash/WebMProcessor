class NotificationMailer < ActionMailer::Base
  default from: ENV['EMAILS_FROM']
  helper :EncodingJobs

  def starting_transcode(encoding_job_id)
    @encoding_job = EncodingJob.find(encoding_job_id)
    unless @encoding_job.notification_email_address.blank?
      mail(:to => @encoding_job.notification_email_address, :subject => "Transcode Starting")
    end
  end

  def finished_transcode(encoding_job_id)
    @encoding_job = EncodingJob.find(encoding_job_id)
    unless @encoding_job.notification_email_address.blank?
      mail(:to => @encoding_job.notification_email_address, :subject => "Transcode Finished")
    end
  end

end
