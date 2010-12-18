#!/usr/bin/env ruby

html = File.read("index.maximized.html")
minified = html.gsub(/$\s*/, "").gsub("\n", "")
File.open("index.html", 'w') {|f| f.write(minified) }
