class AddMovieToEncodingJobs < ActiveRecord::Migration
  def change
    add_column :encoding_jobs, :movie, :string
  end
end
