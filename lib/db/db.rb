require_relative '../libkyotocabinet_ffi'

module KyotoCabinet

  # in-memory (or prototype) database types
  MEMORY_HASH       = :-
  MEMORY_TREE       = :+
  MEMORY_STASH      = :':'
  MEMORY_CACHE_HASH = :*
  MEMORY_CACHE_TREE = :%

  # on-disk database types
  FILE_HASH         = :".kch"
  FILE_TREE         = :".kct"
  FILE_PLAIN_TEXT   = :".kcx"
  DIR_HASH          = :".kcd"
  DIR_TREE          = :".kcf"

  module Db

    def new
      @kc_db_pointer = LibKyotoCabinet::kcdbnew
    end

    def last_error_code
      LibKyotoCabinet::kcdbecode(@kc_db_pointer)
    end

    def last_error_message
      LibKyotoCabinet::kcdbemsg(@kc_db_pointer)
    end

    def last_error
      SystemCallError.new(last_error_message, last_error_code)
    end

    def open(path, *options)
      mode = (options & LibKyotoCabinet::MODES.keys).map { |k|
        LibKyotoCabinet::MODES[k]
      }.reduce(0, :|)
      bool_return(LibKyotoCabinet::kcdbopen(@kc_db_pointer, path.to_s, mode))
    end

    def open!(path, *options)
      fail last_error if not open(path, *options)
    end

    def size
      LibKyotoCabinet::kcdbcount(@kc_db_pointer)
    end

    def get(key)
      key_string = key.to_s
      value_size_ptr = LibKyotoCabinet::FFI::MemoryPointer.new :pointer
      LibKyotoCabinet::kcdbget(@kc_db_pointer, key_string, key_string.length, value_size_ptr)
    end

    def set(key, value)
      key_string = key.to_s
      value_string = value.to_s
      bool_return(LibKyotoCabinet::kcdbset(@kc_db_pointer, key_string, key_string.length, value_string, value_string.length))
    end

    def set!(key, value)
      fail last_error if not set(key, value)
    end

    def clear
      bool_return(LibKyotoCabinet::kcdbclear(@kc_db_pointer))
    end

    def clear!
      fail last_error if not clear
    end

    def close
      bool_return(LibKyotoCabinet::kcdbclose(@kc_db_pointer))
    end

    def close!
      fail last_error if not close
    end

    private

    def bool_return(int_value)
      int_value != 0
    end
  end
end
