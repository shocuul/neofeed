class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.string :name
      t.text :summary
      t.string :url
      t.datetime :published_at
      t.string :guid
      t.string :image_url

      t.timestamps
    end
    add_reference :feed_entries, :source, index: true
  end
end
