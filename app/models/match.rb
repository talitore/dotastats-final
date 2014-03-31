class Match < ActiveRecord::Base
  has_many :match_histories
  has_many :players, through: :match_histories, foreign_key: :steam_id

  include MyUtils

  serialize :players, JSON

  def self.new_set(matches_array)
    matches_array.each do |match_json|
      match = Matches.find_or_create_by(match_id: match_json[:match_id].to_i)
      match.attributes = MyUtils.hash_nonintersect_to_s(match_json, match.attributes)
      match.save
    end
  end
end