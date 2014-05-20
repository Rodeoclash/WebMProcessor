class AddEmailNotificationOnComplete < ActiveRecord::Migration
  def change
  	add_column :encoding_jobs, :notification_email_address, :string
  end
end
