# @api private
# FFI bindings
module LibKyotoCabinet

  class << self
    # @api_private
    # Determine FFI constant for this ruby engine.
    def find_ffi
      require "ffi"
      ::FFI
    end

    # @api_private
    # Loads the libkyotocabinet shared library.
    def load_libkyotocabinet
      ffi_module = find_ffi
      extend ffi_module::Library

      begin
        ffi_lib "kyotocabinet"
      rescue LoadError
        ffi_lib "libkyotocabinet.so"
      end
    end
  end

  # Constant holding the FFI module for this ruby engine.
  FFI = LibKyotoCabinet::find_ffi
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
