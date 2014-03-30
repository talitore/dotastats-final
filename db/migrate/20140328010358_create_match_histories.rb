class CreateMatchHistories < ActiveRecord::Migration
  def change
    create_table :match_histories do |t|
      t.integer :steam_id, :limit => 8
      t.integer :matches_id, :limit => 8
    end

    add_index :match_histories, [:steam_id, :matches_id]
  end
end