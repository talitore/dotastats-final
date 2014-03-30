class PlayerController < ApplicationController
  include MyUtils
  require 'open-uri'

  ANON_STEAM_ID = 76561202255233023

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
        steamid = URI.parse(params[:dotabuff_url]).path.split('/').last.to_i
        @player = get_player_info steamid
      end
    end
  end

  def matches
    @matches = Player.matches
  end

  #Non-views
  def get_player_info(steamid)
    if steamid == ANON_STEAM_ID
      player = Player.find_or_create_by(steamid: 76561202255233023, personaname: "Anonymous")
    else
      player = Player.find_or_create_by(steamid: steamid.to_i)
    end
    return player if player.save
  end

  def get_match_history(player_id)
    history = JSON.parse(open(GET_MATCH_HISTORY_URL+QUERY_KEY_START+MY_DEV_KEY+ACCOUNT_ID+MyUtils.to_32bit(self.steamid).to_s).read, :symbolize_names => true)[:result]
    return Matches.new_set(result[:matches])
  end
end