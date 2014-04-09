class CreateEncodingJobs < ActiveRecord::Migration

  def change
    create_table :encoding_jobs do |t|
      t.string :uuid
      t.string :video_codec
      t.integer :frame_rate
      t.string :resolution
      t.integer :video_bitrate
      t.integer :video_max_bitrate
      t.integer :video_min_bitrate
      t.string :audio_codec
      t.integer :audio_bitrate
      t.integer :audio_sample_rate
      t.integer :audio_channels
      t.integer :buffer_size
      t.integer :video_bitrate_tolerance
      t.integer :threads
      t.integer :duration
      t.integer :keyframe_interval
      t.integer :seek_time
      t.string :x264_vprofile
      t.string :x264_preset
      t.string :custom
      t.timestamps
    end

    add_index :encoding_jobs, :uuid, :unique => true
  end

end
