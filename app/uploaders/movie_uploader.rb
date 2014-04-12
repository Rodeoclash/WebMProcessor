# encoding: utf-8

class MovieUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Create different versions of your uploaded files:
  version :converted do
    process :perform_encode
  end

  def perform_encode
    options = {
      video_codec: "libvpx",
      frame_rate: model.frame_rate,
      resolution: model.resolution,
      video_bitrate: model.video_bitrate,
      video_bitrate_tolerance: model.video_bitrate_tolerance,
      video_max_bitrate: model.video_max_bitrate,
      video_min_bitrate: model.video_max_bitrate,
      keyframe_interval: model.keyframe_interval,
      buffer_size: model.buffer_size,
      threads: model.threads,
      duration: model.duration,
      seek_time: model.seek_time,
      custom: model.custom,
      audio_codec: "libvorbis",
      audio_bitrate: 32,
      audio_sample_rate: 22050,
      audio_channels: 1
    }

    begin
      firebase_progress = FirebaseProgress.new(uuid: model.uuid)
      firebase_progress.started

      movie = FFMPEG::Movie.new(current_path)

      movie.transcode("#{Rails.root}/tmp/movie.webm", options) {|progress|
        firebase_progress.updated(progress)
      }
    ensure
      firebase_progress.finished
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end