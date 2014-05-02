class Source < ActiveRecord::Base
	has_many :feed_entries, dependent: :destroy
end
