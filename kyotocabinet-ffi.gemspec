require './lib/kyotocabinet_ffi/version'

Gem::Specification.new do |spec|
  spec.name                     = 'kyotocabinet-ffi'
  spec.version                  = KyotoCabinet::VERSION
  spec.summary                  = %q{FFI wrapper to Kyoto Cabinet's C API.}
  spec.description              = %q{Kyoto Cabinet provided DBM interface to efficient
                                     key value stores both in-memory and on-disk. This gem
                                     wraps Kyoto Cabinet's C API using FFI (foregin function interface)
                                     to support MRI, JRuby, and Rubinius.}.
                                     gsub(%r{^\s+}, ' ').gsub(%r{\n}, '')
  spec.license                  = 'MIT'
  spec.authors                  = ['Anthony Bargnesi']
  spec.email                    = %q{abargnesi@gmail.com}
  spec.files                    = Dir.glob('lib/**/*.rb') << 'LICENSE'
  spec.homepage                 = 'https://github.com/abargnesi/kyotocabinet-ffi'
  spec.require_paths            = ['lib']

  spec.add_dependency             'ffi',  '~> 1.9'
  spec.add_development_dependency 'minitest', '~> 5.4'
  spec.add_development_dependency 'rake', '~> 10.4'
end
# vim: ts=2 sw=2:
# encoding: utf-8
