#
# Get the most recent matches and associated player data.
#
include MyUtils
require 'open-uri'
require 'json'

MY_DEV_KEY ||= "?key=EF42A5E508EA32500904F09903220E7D"
GET_MATCH_HISTORY_URL ||= "https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/"

if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
  puts "*** can't lock file, another instance of script running?  exiting"
  exit 1
end

t = Time.now
puts "++++++++++++++++++++++++"
puts "GET_RECENT_MATCHES"
puts Time.now.strftime("%Y%m%d-%H:%M:%S") + " : " + __FILE__ + " starting..."

start_at = Matches.last.match_id
puts "Starting from match id: #{start_at}"
matches = JSON.parse(open(GET_MATCH_HISTORY_URL+MY_DEV_KEY).read)['result']['matches']

matches.each do |match_json|
  t1 = Time.now
  puts "=========================="
  match = Matches.find_or_create_by(match_id: match_json['match_id'].to_i)
  puts "Updating match: #{match.match_id}"
  match.attributes = MyUtils.hash_nonintersect_to_s(match_json, match.attributes)
  match.save
  match['players'].each do |match_player|
    puts "  Updating player: #{match_player['account_id'] == 4294967295 ? puts('4294967295 skipping') : match_player['account_id'] }"
    sleep 1 unless match_player['account_id'] == 4294967295 # Only allowed 100,000 queries per day, but never query for anons
    Players.get_player_info(match_player['account_id'].to_i)
  end
  t2 = Time.now
  puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished iteration in #{t2 - t1} secs"
puts "=========================="
end

t2 = Time.now
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished whole in #{t2 - t} secs"
puts "++++++++++++++++++++++++"