# encoding: utf-8

class MovieUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader

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
    begin
      puts "--- performing encoding"

      firebase_progress = FirebaseProgress.new(uuid: model.uuid)
      firebase_progress.started

      #movie = FFMPEG::Movie.new(current_path)

      #movie.transcode("#{Rails.root}/tmp/movie.webm", model.encoding_options) {|progress|
      #  firebase_progress.updated(progress)
      #}

    ensure
      firebase_progress.finished
    end
  end

  protected

    def ready_for_encoding?(file)
      model.ready_for_encoding?
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