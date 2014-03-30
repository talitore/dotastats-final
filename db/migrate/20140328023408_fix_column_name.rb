class FixColumnName < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.rename :steamid, :steam_id
    end
  end
end
