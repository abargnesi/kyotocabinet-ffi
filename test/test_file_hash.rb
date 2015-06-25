require 'rubygems'
require 'bundler'
Bundler.setup

require "minitest/autorun"
require 'kyotocabinet_ffi'
require 'tempfile'

class FileHashTest < Minitest::Test

  def test_paths
    file = Tempfile.new(['db', '.kch'])
    begin
      db = KyotoCabinet::Db::FileHash.new file.path, :writer, :create
      assert db.file_path.end_with? '.kch'

      close_result = db.close
      assert close_result, "close error: #{db.last_error_message} (#{db.last_error_code})"
    ensure
      file.close(true)
      file.unlink
    end
  end

  def test_full
    file = Tempfile.new(['db', '.kch'])
    begin
      db = KyotoCabinet::Db::FileHash.new file.path, :writer, :create
      assert_equal 0, db.last_error_code

      start = "A"
      100.times do |key|
        set_result = (db[key] = start)
        assert set_result, "set error: #{db.last_error_message} (#{db.last_error_code})"
        assert_equal start, db[key]
        start.next
      end

      assert !db.empty?
      assert_equal 100, db.size

      clear_result = db.clear
      assert clear_result, "clear error: #{db.last_error_message} (#{db.last_error_code})"
      assert db.empty?
      assert_equal 0, db.size

      close_result = db.close
      assert close_result, "close error: #{db.last_error_message} (#{db.last_error_code})"
    ensure
      file.close(true)
      file.unlink
    end
  end
end
# vim: ts=2 sts=2 sw=2
