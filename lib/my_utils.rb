module MyUtils
  # Finds the non interseting k/v of two hashes
  # I use to only update necessary fields for players
  # --- player_info, Player.attributes ---
  def self.hash_nonintersect_to_s(new_hash, current_Hash)
    new_hash.reject { |k, v| current_Hash.include?(k) && current_Hash[k].to_s == v.to_s }
  end

  def self.to_64bit(steamid)
    steamid < 76561197960265728 ? steamid + 76561197960265728 : steamid
  end

  def self.to_32bit(steamid)
    steamid > 76561197960265728 ? steamid - 76561197960265728 : steamid
  end
end