CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  config.use_action_status = true
  config.min_file_size = ENV['MIN_FILESIZE']
  config.max_file_size = ENV['MAX_FILESIZE']
end