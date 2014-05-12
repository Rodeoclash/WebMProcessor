class CreateEncodingJobs < ActiveRecord::Migration

  def change
    create_table :encoding_jobs do |t|
      t.string :uuid, :null => false
      t.string :video_codec
      t.integer :frame_rate
      t.string :resolution
      t.integer :video_bitrate
      t.string :audio_codec
      t.integer :audio_bitrate
      t.integer :audio_sample_rate
      t.integer :audio_channels
      t.integer :video_bitrate_tolerance
      t.integer :threads
      t.integer :duration
      t.integer :keyframe_interval
      t.integer :seek_time
      t.string :x264_vprofile
      t.string :x264_preset
      t.string :custom
      t.text :s3_response
      t.boolean :start_encoding, :default => false
      t.string :queue_job_id
      t.timestamps
    end

    add_index :encoding_jobs, :uuid, :unique => true
    add_index :encoding_jobs, :queue_job_id, :unique => true
  end

end