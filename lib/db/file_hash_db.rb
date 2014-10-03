module KyotoCabinet
  module Db
    class FileHash < PolymorphicDb
      attr_reader :file_path

      def initialize(file_path, *options)
        fail ArgumentError.new('file_path must be set') unless file_path

        if not file_path.end_with? KyotoCabinet::FILE_HASH.to_s
          file_path << KyotoCabinet::FILE_HASH.to_s
        end

        @file_path = file_path

        self.new
        self.open!(@file_path, *options)
      end
    end
  end
end
