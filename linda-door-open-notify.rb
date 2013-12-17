#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

url =     ENV["LINDA_BASE"] || ARGV.shift || "http://localhost:5000"
spaces = (ENV["LINDA_SPACES"]||ENV["LINDA_SPACE"]||"test").split(/,/)
puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url

tss = {}
spaces.each do |i|
  tss[i] = linda.tuplespace[i]
end
puts "spaces : #{tss.keys}"

lasts = Hash.new{|h,k| h[k] = Hash.new }

linda.io.on :connect do  ## RocketIO's "connect" event
  puts "connect!! <#{linda.io.session}> (#{linda.io.type})"
  tss.each do |name, ts|
    ts.watch ["door", "open", "success"]{|tuple|
      next unless tuple.size == 3
      puts "#{name} - #{tuple}"
      msg = "#{name}でドアが開きました"
      puts msg
      tss.each do |name_, ts_|
        ts_.write ["skype", "send", msg]
        ts_.write ["twitter", "tweet", msg]
        ts_.write ["say", msg] if name_ != name
      end
    }
  end
end

linda.io.on :disconnect do
  puts "RocketIO disconnected.."
end

linda.wait
