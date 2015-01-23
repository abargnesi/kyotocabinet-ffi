module KyotoCabinet
  module Db

    # deprecated - use PolymorphicDb directly
    class MemoryHash < PolymorphicDb
      def initialize(*options)
        self.new
        self.open!(KyotoCabinet::MEMORY_HASH, *options)
      end
    end
  end
end
