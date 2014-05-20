class NotificationMailer < ActionMailer::Base
  default from: ENV['EMAILS_FROM']

  helper do
    def encoding_job_show_url(encoding_job)
      "http://<%= ENV['SITE_DOMAIN'] %>/#/encoding_job/<%= encoding_job.uuid %>/show"
    end
  end

  def starting_transcode(encoding_job_id)
    @encoding_job = EncodingJob.find(encoding_job_id)
    mail(:to => @encoding_job.notification_email_address, :subject => "Transcode Starting")
  end

  def finished_transcode(encoding_job_id)
    @encoding_job = EncodingJob.find(encoding_job_id)
    mail(:to => @encoding_job.notification_email_address, :subject => "Transcode Finished")
  end

end
