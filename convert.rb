#!/usr/bin/env ruby

require 'fileutils'

Dir["/Users/jread/Developer/blog/_posts/*"].each do |file|
  FileUtils.rm_rf file
end

files = Dir.glob("/Users/jread/Developer/blog/_blosxom/*.txt")
for file in files
  date_prefix = File.mtime(file).strftime("%Y-%m-%d")
  lines = File.open(file, &:readlines)
  posttitle = lines[0].gsub(/[a-zA-Z]*: /,'').chomp!
  postname = posttitle.downcase.gsub(/[a-zA-Z]*: /,'').gsub(' ','_').gsub(/\W/,'')
  postlayout = lines[0].gsub(/:.*/,'').downcase.chomp!
  newpost = "/Users/jread/Developer/blog/_posts/#{date_prefix}-#{postname}.markdown"

  if postlayout.eql? "text"
    chop = 1
    header = <<-END
---
layout: text
title: "#{posttitle}"
---

END
  elsif postlayout.eql? "draft"
    chop = 1
    header = <<END
---
layout: #{postlayout}
title: "#{posttitle}"
published: no
---

END
  else
    chop = 3
    header = <<-END
---
layout: #{postlayout}
title: "#{posttitle}"
#{postlayout}: #{lines[1].to_s.chomp!}
---

END
  end

  lines.shift(chop)
  
  File.open(newpost, 'w') do |f|
    f << header
    f << lines.join
  end
end