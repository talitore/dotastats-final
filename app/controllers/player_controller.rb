class PlayerController < ApplicationController
  include MyUtils
  require 'open-uri'
  require 'json'

  ANON_STEAM_ID = 76561202255233023
  STEAM_IDS = "&steamids=" # comma delimited
  MY_DEV_KEY = "?key=EF42A5E508EA32500904F09903220E7D"
  GET_PLAYER_SUM_URL = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/"

  #Views
  def index
    if params[:player_id]
      # Support login's later
    end
  end

  def show(player = nil)
    if player.nil?
      if params[:dotabuff_url].to_s.length == 0
        logger.error "url blank" ## Logic for blank url's
      else
        steamid = MyUtils.to_64bit(URI.parse(params[:dotabuff_url]).path.split('/').last.to_i)
        steamid = 76561202255233023 if steamid == 76561197960265728
        @player = get_player_info steamid
      end
    end
  end

  def matches
    @matches = Player.match_ids
  end

  #Non-views
  def get_player_info(steamid)
    raise "steam_id not converted correct" if steamid < 76561197960265728
    if steamid == ANON_STEAM_ID
      player = Player.find_or_create_by(steam_id: 76561202255233023, personaname: "Anonymous")
    else
      player = Player.find_by_steam_id(steamid)
      if !player
        response = JSON.parse(open(GET_PLAYER_SUM_URL+MY_DEV_KEY+STEAM_IDS+steamid.to_s).read, :symbolize_names => true)[:response]
        player_info = response[:players][0]
        if !player_info.nil?
          player_info[:steam_id] = player_info[:steamid]
          player_info.delete :steamid
          player = Player.new(player_info)
        else
          player = nil
        end
      end
    end
  end

  def get_match_history(player_id)
    history = JSON.parse(open(GET_MATCH_HISTORY_URL+QUERY_KEY_START+MY_DEV_KEY+ACCOUNT_ID+MyUtils.to_32bit(self.steam_id).to_s).read, :symbolize_names => true)[:result]
    return Matches.new_set(result[:matches])
  end
end