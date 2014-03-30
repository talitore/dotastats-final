class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :match_id, :limit => 8
      t.integer :match_seq_num
      t.integer :start_time
      t.integer :lobby_type
      t.text :players

      t.timestamps
    end
  end
end