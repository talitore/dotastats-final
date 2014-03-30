class Player < ActiveRecord::Base
  has_many :match_histories
  has_many :match_ids, through: :match_histories, source: :matches

  include MyUtils
  require 'open-uri'
  require 'json'

  ANON_STEAM_ID = 76561202255233023
  STEAM_IDS = "&steamids=" # comma delimited
  MY_DEV_KEY = "?key=EF42A5E508EA32500904F09903220E7D"
  GET_PLAYER_SUM_URL = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/"

  def self.get_player_info(steam_id)
    steam_id_64bit = MyUtils.to_64bit steam_id
    return Players.get_p(ANON_STEAM_ID) if steam_id_64bit == ANON_STEAM_ID
    response = JSON.parse(open(GET_PLAYER_SUM_URL+MY_DEV_KEY+STEAM_IDS+steam_id_64bit.to_s).read, :symbolize_names => true)[:response]
    player_info = response[:players][0]
    if !player_info.nil?
      return Players.get_p(player_info)
    end
  end

private
  def self.get_p(player_info)
    if player_info == ANON_STEAM_ID
      player = Players.find_or_create_by(steam_id: 76561202255233023, personaname: "Anonfag")
    else
      player = Players.find_or_create_by(steam_id: player_info[:steam_id].to_i)
      player.attributes = MyUtils.hash_nonintersect_to_s(player_info, player.attributes)
    end
    return player if player.save
  end
end