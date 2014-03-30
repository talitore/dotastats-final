class CreateMatchHistories < ActiveRecord::Migration
  def change
    create_table :match_histories do |t|
      t.belongs_to :players, :limit => 8
      t.belongs_to :matches, :limit => 8
    end

    add_index :match_histories, [:players_id, :matches_id]
  end
end