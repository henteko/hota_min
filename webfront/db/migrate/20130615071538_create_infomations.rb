class CreateInfomations < ActiveRecord::Migration
  def change
    create_table :infomations do |t|
      t.string :latitude
      t.string :longitude
      t.integer :birth_year

      t.timestamps
    end
  end
end
