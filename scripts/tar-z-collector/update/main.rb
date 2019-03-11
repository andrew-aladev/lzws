#!/usr/bin/env ruby

require_relative "../common/format"
require_relative "../common/list"
require_relative "archives"
require_relative "search"
require_relative "stats"

valid_page_urls_path   = ARGV[0]
invalid_page_urls_path = ARGV[1]
archive_urls_path      = ARGV[2]

valid_page_urls   = read_list :path => valid_page_urls_path
invalid_page_urls = read_list :path => invalid_page_urls_path
archive_urls      = read_list :path => archive_urls_path

search_urls = get_search_urls
page_urls   = get_page_urls :search_urls => search_urls

page_urls -= valid_page_urls + invalid_page_urls

text = colorize_length :length => page_urls.length
STDERR.puts "-- processing #{text} page urls"

new_valid_page_urls, new_invalid_page_urls, new_archive_urls = get_archive_urls :page_urls => page_urls

valid_page_urls   = (valid_page_urls + new_valid_page_urls).sort.uniq
invalid_page_urls = (invalid_page_urls + new_invalid_page_urls).sort.uniq
archive_urls      = (archive_urls + new_archive_urls).sort.uniq

write_list :path => valid_page_urls_path,   :list => valid_page_urls
write_list :path => invalid_page_urls_path, :list => invalid_page_urls
write_list :path => archive_urls_path,      :list => archive_urls
