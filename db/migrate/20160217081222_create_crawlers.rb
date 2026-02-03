class CreateCrawlers < ActiveRecord::Migration
  def change
    create_table :crawlers do |t|

      t.text :raw
      t.timestamps null: false
    end
  end
end
