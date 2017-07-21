class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.st_point :lonlat, geographic: true

      t.timestamps
    end
  end
end
