class AddConditionalCheckToEncodingProcess < ActiveRecord::Migration
  def change
  	add_column :encoding_jobs, :start_encoding, :boolean, default: false
  end
end
