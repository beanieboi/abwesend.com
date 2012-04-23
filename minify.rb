# encoding: UTF-8

html = File.read("index.maximized.html").force_encoding("UTF-8")
minified = html.gsub(/$\s*/, "").gsub("\n", "")
File.open("index.html", 'w') {|f| f.write(minified) }
