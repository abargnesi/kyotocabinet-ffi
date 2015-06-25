require 'rubygems'
require 'bundler'
Bundler.setup

require "minitest/autorun"
require "minitest/unit"
require 'kyotocabinet_ffi'

class MemoryHashTest < Minitest::Test

  def test_full
    db = KyotoCabinet::Db::MemoryHash.new :writer, :create
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
  end
end
# vim: ts=2 sts=2 sw=2
