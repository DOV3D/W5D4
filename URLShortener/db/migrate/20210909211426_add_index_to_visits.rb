class AddIndexToVisits < ActiveRecord::Migration[5.2]
  def change
    add_index :visits, :visitor_id
    add_index :visits, :url_id
  end
end
