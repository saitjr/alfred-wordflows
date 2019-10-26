#!/usr/bin/env ruby
# encoding: utf-8

require 'shellwords'

# 处理默认文件创建目录
nf_dir = ENV['nf_dir'] || File.join("~", "Desktop")
nf_dir = File.expand_path(nf_dir)
abort("#{nf_dir} not exist") unless File.exist?(nf_dir)

# 处理文件打开命令
nf_open = ENV['nf_open'] || File.join('open')
nf_open = "#{nf_open} -n"

argv_file = ARGV[0]

# 只有文件名，就拼接默认目录
path = File.basename(argv_file) == argv_file ? File.join(nf_dir) : argv_file

if File.exist?(path)
  puts path
  system "#{nf_open} #{path}"
  return
end

extname = File.extname(file)
tmpl_path = File.join(Dir.pwd, "tmpls", "tmpl#{extname}")

# 如果有模板，拷贝模板
# 否则直接创建
if File.exist?(tmpl_path)
  system "cp #{tmpl_path.shellescape} #{path}"
else
  system "touch #{path}"
end

system "#{nf_open} #{path}"
