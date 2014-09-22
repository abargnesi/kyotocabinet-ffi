module KyotoCabinet
  module Db
    class MemoryHash < PolymorphicDb
      def initialize(*options)
        @kc_db_pointer = LibKyotoCabinet::kcdbnew
        self.open!(KyotoCabinet::MEMORY_HASH, *options)
      end
    end
  end
end
