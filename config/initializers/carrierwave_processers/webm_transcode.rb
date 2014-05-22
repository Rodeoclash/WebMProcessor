module CarrierwaveProcessers
	module WebmTranscode
		def webm_transcode

			begin

				model.firebase_progress.update({
				progress_percentage: 0,
				status: "Starting transcoding of movie",
				ready_for_download: false,
				error_with_transcoding: false
				})

				movie = FFMPEG::Movie.new(current_path)

				with_temp_filepath do |temp_path|
					transcoded_file = "#{temp_path}.webm"

					# perform the transcode into the temporary files location
					movie.transcode(transcoded_file, model.encoding_options) {|progress|
						model.firebase_progress.update({
							progress_percentage: progress.to_i * 100,
							status: "Transcoding video to WebM",
							ready_for_download: false,
							error_with_transcoding: false
						})
					}

					# move transcoded file into place of the original
					FileUtils.mv(transcoded_file, current_path)

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
					status: "There was a problem transcoding your video",
					ready_for_download: false,
					error_with_transcoding: true
				})
				raise e
			end
		end

		def with_temp_filepath basename = 'video'
			tmpfile = Tempfile.new basename
			tmpfile.close
			yield tmpfile.path
		ensure
			tmpfile.unlink
		end

	end
end