class MatchHistory < ActiveRecord::Base
  belongs_to :player, foreign_key: :steam_id, primary_key: :steam_id
  belongs_to :match
end