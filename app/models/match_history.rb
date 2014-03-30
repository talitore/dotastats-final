class MatchHistory < ActiveRecord::Base
  belongs_to :players, foreign_key: :steam_id, primary_key: :steam_id
  belongs_to :matches
end