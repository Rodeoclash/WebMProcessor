class AddConditionalChecksToEncodingProcess < ActiveRecord::Migration
  def change
  	add_column :encoding_jobs, :start_encoding, :boolean, default: false
  	add_column :encoding_jobs, :movie_uploaded_to_s3, :boolean, default: false
  end
end