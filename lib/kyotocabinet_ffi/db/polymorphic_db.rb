require 'pathname'
require 'fileutils'

module KyotoCabinet
  module Db
    class PolymorphicDb
      include Db

      def initialize(path, options = {})
        path_s = path.to_s
        db_options = options.delete(:db_options) || []
        unless KyotoCabinet::match_filedb_type? (path_s) or
               KyotoCabinet::match_memorydb_type? (path_s)
          msg = %Q{
            The path value \"#{path || '(nil)'}\" does not match one of the memory
            db types #{KyotoCabinet::MEMORY_DB_TYPE.map(&:to_s).join(', ')} or
            one of the file db types #{KyotoCabinet::FILE_DB_TYPE.map(&:to_s).join(', ')}.
          }.gsub(%r{^\s+}, ' ').gsub(%r{\n}, '')
          fail ArgumentError.new(msg)
        end

        self.new
        self.open!(path, *db_options)
      end

      def self.tmp_filedb(type, options = {})
        prefix = options[:prefix]
        path = make_temp(type, prefix)

        self.new(path, {
          :db_options => [:create, :reader, :writer]
        })
      end

      def [](key)
        self.get(key)
      end

      def []=(key, value)
        self.set(key, value)
      end

      def empty?
        self.size <= 0
      end

      def clear
        super
      end

      private

      def self.make_temp(ext, prefix)
          unless KyotoCabinet::match_filedb_type?(ext)
            msg = %Q{
              The ext value \"#{ext || '(nil)'}\" does not match one of the file
              db types #{KyotoCabinet::FILE_DB_TYPE.map(&:to_s).join(', ')}.
            }.gsub(%r{^\s+}, ' ').gsub(%r{\n}, '')
            msg = "The extension \"#{ext || '(nil)'}\" does not match one of #{KyotoCabinet::FILE_DB_TYPE}"
            fail ArgumentError.new(msg)
          end

          epoch_millis = (Time.now.to_f * 1000).to_i
          prefix = prefix || DEFAULT_TEMP_PREFIX
          (Pathname(Dir.tmpdir) + "#{prefix}-#{epoch_millis}#{ext}").to_s
      end
    end
  end
end
