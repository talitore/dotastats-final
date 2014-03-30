class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :steam_id, :limit => 8
      t.integer :communityvisibilitystate
      t.integer :profilestate
      t.string :personaname
      t.string :realname
      t.integer :lastlogoff
      t.string :profileurl
      t.string :avatar
      t.string :avatarmedium
      t.string :avatarfull
      t.integer :personastate
      t.integer :primaryclanid, :limit => 8
      t.integer :timecreated
      t.integer :personastateflags
      t.integer :gameid
      t.string :gameserverip
      t.integer :gameserversteamid, :limit => 8
      t.integer :lobbysteamid, :limit => 8
      t.string :gameextrainfo
      t.string :loccountrycode
      t.string :locstatecode
      t.integer :loccityid
      t.string :commentpermission

      t.timestamps
    end
  end
end