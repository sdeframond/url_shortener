class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :full_url
      t.string :hash

      t.timestamps
    end
  end
end
