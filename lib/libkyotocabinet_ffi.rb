# @api private
# FFI bindings
module LibKyotoCabinet

  class << self

    def mri?
      defined?(RUBY_DESCRIPTION) && (/^ruby/ =~ RUBY_DESCRIPTION)
    end

    def jruby?
      defined?(RUBY_PLATFORM) && ("java" == RUBY_PLATFORM)
    end

    def rubinius?
      defined?(RUBY_ENGINE) && ("rbx" == RUBY_ENGINE)
    end

    # @api_private
    # Determine FFI constant for this ruby engine.
    def find_ffi
      if defined?(RUBY_ENGINE) && RUBY_ENGINE == "rbx"
        if const_defined? "::Rubinius::FFI"
          ::Rubinius::FFI
        elsif const_defined? "::FFI"
          ::FFI
        else
          require "ffi"
          ::FFI
        end
      else # mri, jruby, etc
        require "ffi"
        ::FFI
      end
    end

    # @api_private
    # Extend with the correct ffi implementation.
    def load_ffi
      ffi_module = LibKyotoCabinet::find_ffi
      extend ffi_module::Library
      ffi_module
    end

    # @api_private
    # Loads the libkyotocabinet shared library.
    def load_libkyotocabinet
      ffi_module = find_ffi
      extend ffi_module::Library

      begin
        ffi_lib "kyotocabinet"
      rescue LoadError
        begin
          ffi_lib "libkyotocabinet.so"
        ensure
          ffi_lib "libkyotocabinet.so.16"
        end
      end
    end
  end

  # Constant holding the FFI module for this ruby engine.
  FFI = LibKyotoCabinet::load_ffi
  LibKyotoCabinet::load_libkyotocabinet

  # mode options
  MODES = {
    :reader            => (1 << 0),
    :writer            => (1 << 1),
    :create            => (1 << 2),
    :truncate          => (1 << 3),
    :auto_transaction  => (1 << 4),
    :auto_synchronize  => (1 << 5),
    :no_file_locking   => (1 << 6),
    :non_blocking_lock => (1 << 7),
    :no_file_repair    => (1 << 8)
  }

  attach_function :kcdbecode,   [:pointer],                                     :int32
  attach_function :kcdbemsg,    [:pointer],                                     :string
  attach_function :kcdbnew,     [],                                             :pointer
  attach_function :kcdbopen,    [:pointer, :string, :uint32],                   :int32
  attach_function :kcdbcount,   [:pointer],                                     :int64
  attach_function :kcdbset,     [:pointer, :string, :size_t, :string, :size_t], :int32
  attach_function :kcdbadd,     [:pointer, :string, :size_t, :string, :size_t], :int32
  attach_function :kcdbget,     [:pointer, :string, :size_t, :pointer],         :string
  attach_function :kcdbclear,   [:pointer],                                     :int32
  attach_function :kcdbclose,   [:pointer],                                     :int32
  attach_function :kcdbdel,     [:pointer],                                     :void
end
