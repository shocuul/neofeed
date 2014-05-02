class FeedEntry < ActiveRecord::Base
	#Relaciones
	belongs_to :source

	require 'nokogiri'

	def self.update_from_feed(feed_url)
		feed = Feedjira::Feed.fetch_and_parse(feed_url.url)
		add_entries(feed.entries, feed_url)
	end

	def self.extract_img_url(dochtml)
		doc = Nokogiri::HTML(dochtml)
		img_srcs = doc.css('img').map{ |i| i['src'] }
	end

	private
	def self.add_entries(entries,url)
	entries.each do |entry|
		unless exists? guid: entry.id
		create!(
		name: entry.title,
		summary: entry.summary,
		url: entry.url,
		published_at: entry.published,
		guid: entry.id,
		source_id: url.id
		)
		end
		end
	end
end
