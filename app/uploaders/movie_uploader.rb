# encoding: utf-8

class MovieUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader
  include CarrierwaveProcessers::WebmTranscode
  include CarrierwaveProcessers::VideoScreenshot

  # Create different versions of your uploaded files:
  version :transcoded do
    process :webm_transcode
    def full_filename(file)
      super.chomp(File.extname(file)) + '.webm'
    end
  end

  # Create different versions of your uploaded files:
  version :screenshot do
    process :video_screenshot
    def full_filename(file)
      super.chomp(File.extname(file)) + '.jpg'
    end
  end

end