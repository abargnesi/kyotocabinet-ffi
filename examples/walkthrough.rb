require 'rubygems'
require 'bundler'
Bundler.setup

require 'kyotocabinet'

# Create an in-memory database.
db = KyotoCabinet::Db::MemoryHash.new :writer, :create

# Set some records in the database.
start = "A"
100.times do |key|
  db[key] = start
  start.next
end

# What is the database size?
db.size

# Is the database empty?
db.empty?

# Get some records from the database.
db['A']
db[:Z]

# Clear the database.
db.clear

# Close the database.
db.close

# vim: ts=2 sts=2 sw=2
