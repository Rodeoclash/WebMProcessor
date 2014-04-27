# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140408105339) do

  create_table "encoding_jobs", force: true do |t|
    t.string   "uuid",                                    null: false
    t.string   "video_codec"
    t.integer  "frame_rate"
    t.string   "resolution"
    t.integer  "video_bitrate"
    t.integer  "video_max_bitrate"
    t.integer  "video_min_bitrate"
    t.string   "audio_codec"
    t.integer  "audio_bitrate"
    t.integer  "audio_sample_rate"
    t.integer  "audio_channels"
    t.integer  "buffer_size"
    t.integer  "video_bitrate_tolerance"
    t.integer  "threads"
    t.integer  "duration"
    t.integer  "keyframe_interval"
    t.integer  "seek_time"
    t.string   "x264_vprofile"
    t.string   "x264_preset"
    t.string   "custom"
    t.text     "s3_response"
    t.boolean  "start_encoding",          default: false
    t.string   "queue_job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "movie"
  end

  add_index "encoding_jobs", ["queue_job_id"], name: "index_encoding_jobs_on_queue_job_id", unique: true, using: :btree
  add_index "encoding_jobs", ["uuid"], name: "index_encoding_jobs_on_uuid", unique: true, using: :btree

end
