class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :full_url, nil: false
      t.string :url_hash, nil: false

      t.timestamps
    end

    add_index :shortened_urls, :url_hash
  end
end
