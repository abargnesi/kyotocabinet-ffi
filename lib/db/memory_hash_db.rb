module KyotoCabinet
  module Db
    class MemoryHash < PolymorphicDb
      def initialize(*options)
        self.new
        self.open!(KyotoCabinet::MEMORY_HASH, *options)
      end
    end
  end
end
