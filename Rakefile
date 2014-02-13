 
desc 'create new post. args: title, category'
# rake new title="New post title goes here" category="category"
task :new do
require 'rubygems'
title = ENV["title"] || "New Title"
category = ENV["category"] || "other"
slug = title.gsub(' ','-').downcase
 
TARGET_DIR = "_posts"

filename = "#{Time.new.strftime('%Y-%m-%d')}-#{slug}.markdown"
image_dir ="_images/#{Time.new.strftime('%Y-%m')}-#{slug}"
path = File.join(TARGET_DIR, filename)
post = <<-HTML
---
layout: post
title: TITLE
date: DATE
categories: CATEGORY
---

HTML
post.gsub!('TITLE', title).gsub!('DATE', Time.new.to_s).gsub!('CATEGORY', category)
File.open(path, 'w') do |file|
file.puts post
end
puts "new post generated in #{path}"
system "mkdir #{image_dir}"
system "gedit #{path}"
end

task :s3sync do
  system "s3cmd sync _images/ s3://pedaldp/images/ -P"
end
