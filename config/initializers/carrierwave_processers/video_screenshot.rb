module CarrierwaveProcessers
	module VideoScreenshot
		def video_screenshot

			begin

				model.firebase_progress.update({
					progress_percentage: 0,
					status: "Preparing to take screenshot",
					ready_for_download: false,
					error_with_transcoding: false
				})

				movie = FFMPEG::Movie.new(current_path)

				with_temp_filepath do |temp_path|
					screenshot_file = "#{temp_path}.jpg"

					model.firebase_progress.update({
						progress_percentage: 0,
						status: "Creating screenshot of video",
						ready_for_download: false,
						error_with_transcoding: false
					})

					# get the screenshot
					movie.screenshot(screenshot_file, model.screenshot_options)

					# move screenshot file into place of the original
					FileUtils.mv(screenshot_file, current_path)

					model.firebase_progress.update({
						progress_percentage: 100,
						status: "Saving data...",
						ready_for_download: false,
						error_with_transcoding: false
					})

					current_path
				end

			rescue Exception => e
				model.firebase_progress.update({
					progress_percentage: 100,
					status: "There was a problem taking a screenshot your video",
					ready_for_download: false,
					error_with_transcoding: true
				})
				raise e
			end
		end

		def with_temp_filepath basename = 'screenshot'
			tmpfile = Tempfile.new basename
			tmpfile.close
			yield tmpfile.path
		ensure
			tmpfile.unlink
		end

	end
end