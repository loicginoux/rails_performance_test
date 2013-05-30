desc "flush cache"
namespace :cache do
	task :flush => :environment do
		puts "Flushing Cache..."
	  	# require 'dalli'
	   #  dc = Dalli::Client.new
	   #  dc.flush
	   puts Rails.env
	    Rails.cache.clear()
	end
end