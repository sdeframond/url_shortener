class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :full_url, nil: false
      t.string :hash, nil: false

      t.timestamps
    end

    add_index :shortened_urls, :hash
  end
end
