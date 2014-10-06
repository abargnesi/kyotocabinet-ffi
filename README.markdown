[![Build
Status](https://travis-ci.org/abargnesi/kyotocabinet-ffi.svg?branch=master)](https://travis-ci.org/abargnesi/kyotocabinet-ffi)

kyotocabinet-ffi
================

A FFI wrapper to the [Kyoto Cabinet](http://fallabs.com/kyotocabinet/)'s [C interface](http://fallabs.com/kyotocabinet/api/kclangc_8h.html).

Currently it provides the PolymorphicDb with MemoryHash and FileHash subclasses.

requirements
------------

- Works on MRI (*>= 1.9.2*), JRuby (*1.9 mode*), and Rubinius.
- No runtime dependencies (except ffi gem on MRI).

design
------

- Supports polymorphic database with type-specific database classes for readability.
- Database classes can be treated like a ruby Hash.
- Common database calls (e.g. open, get, etc.) are provided in KyotoCabinet::Db.
- Methods ending with ``!`` can raise exceptions.
- Implemented using [FFI](https://github.com/ffi/ffi) to support MRI,
  JRuby, and Rubinius.

usage
-----

```ruby
require 'kyotocabinet'

# polymorphic database (e.g. determined by file_path)
db = KyotoCabinet::Db::PolymorphicDb.new(KyotoCabinet::MEMORY_CACHE_TREE, :reader, :writer, :create)

# in-memory hash
db = KyotoCabinet::Db::MemoryHash.new(:reader, :writer, :create)

# on-disk hash
db = KyotoCabinet::Db::FileHash.new("db", :reader, :writer, :create)

begin
  # set key/value record; create is needed
  db['KyotoCabinet'] = 'FFI'
  
  # get value for key
  db['KyotoCabinet']
  # => FFI

  # record count
  db.size
  # => 1

  # clear all records
  db.clear
ensure
  # close database; raise SystemCallError on failure
  db.close! if db
end
```

license
-------

[MIT](http://opensource.org/licenses/MIT)
