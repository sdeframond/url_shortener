class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :session
      t.string :fingerprint
      t.string :http_accept
      t.string :http_accept_language
      t.string :http_accept_encoding
      t.string :http_dnt
      t.string :user_agent

      t.timestamps
    end

    add_index :devices, :session
    add_index :devices, :fingerprint
  end
end
