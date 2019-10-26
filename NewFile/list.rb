#!/usr/bin/env ruby
# encoding: utf-8

require 'json'

# 处理默认文件创建目录
nf_dir = ENV['nf_dir'] || File.join("~", "Desktop")
nf_dir = File.expand_path(nf_dir)
abort("#{nf_dir} not exist") unless File.exist?(nf_dir)

# 获取支持的后缀
nf_ext = Dir[File.join(Dir.pwd, "tmpls", "*")].map { |f| File.extname(f) }.reject { |ext| ext.empty? }

nf_filter = ARGV[0]

files = Dir[File.join(nf_dir, "*")].select { |f| File.file?(f) && nf_ext.include?(File.extname(f)) }
files = files.select { |f| f.include?(nf_filter) } unless nf_filter.nil? || nf_filter.empty?

items = files.map do |path|
  {
    uid: File.basename(path),
    type: 'file',
    title: File.basename(path),
    subtitle: path,
    arg: path
  }
end

res = {
  items: items
}

# require 'ap'
# ap res

puts res.to_json
