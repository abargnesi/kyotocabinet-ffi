module KyotoCabinet
  module Db
    class PolymorphicDb
      include Db

      def initialize(path, options = {})
        @kc_db_pointer = LibKyotoCabinet::kcdbnew
        self.open!(path, options)
      end

      def [](key)
        self.get(key)
      end

      def []=(key, value)
        self.set(key, value)
      end
    end
  end
end
