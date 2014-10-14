class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :shortened_url

      t.timestamps
    end

    add_index :visits, :shortened_url_id
  end
end
