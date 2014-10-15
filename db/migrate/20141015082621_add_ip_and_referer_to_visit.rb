class AddIpAndRefererToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :remote_addr, :string
    add_column :visits, :http_referer, :string
    add_reference :visits, :device, index: true
  end
end
