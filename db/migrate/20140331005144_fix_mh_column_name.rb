class FixMhColumnName < ActiveRecord::Migration
  def change
    change_table :match_histories do |t|
      t.rename :players_id, :steam_id
      t.rename :matches_id, :match_id
    end
  end
end
