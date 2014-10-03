module KyotoCabinet
  module Db
    class PolymorphicDb
      include Db

      def initialize(path, options = {})
        self.new
        self.open!(path, options)
      end

      def [](key)
        self.get(key)
      end

      def []=(key, value)
        self.set(key, value)
      end

      def clear
        super
      end
    end
  end
end
