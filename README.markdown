kyotocabinet-ffi
================

A FFI wrapper to the [Kyoto Cabinet](http://fallabs.com/kyotocabinet/)'s [C interface](http://fallabs.com/kyotocabinet/api/kclangc_8h.html).

Currently it provides the PolymorphicDb with MemoryHash and FileHash subclasses.

design
------

- Supports polymorphic database with type-specific database classes for readability.
- Database classes can be treated like a ruby hash.
- Common database calls (e.g. open, get, etc.) are provided in KyotoCabinet::Db.
- Methods ending with ``!`` can raise exceptions.

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