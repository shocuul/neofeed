class Source < ActiveRecord::Base
	has_many :feed_entries, dependent: :destroy
	
	def update_url
		feed = Feedjira::Feed.fetch_and_parse(self.url)
		feed.entries.each do |entry|
			unless self.feed_entries.exists? guid: entry.id
				self.feed_entries.create!(
					name: entry.title,
					summary: entry.summary,
					url: entry.url,
					published_at: entry.published,
					guid: entry.id
					)
			end
		end
	end
	
end
