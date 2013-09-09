configure do
  Twitter.configure do |config|
    config.consumer_key       = '79hkBJUSc7BmCREbiH3AAg'
    config.consumer_secret    = 'zcEMmH4dIL2X6lMf4Zr8bFTRK5p4EyrvZI5L8yTHY'
    config.oauth_token        = '15090301-MZrQF86MhuuZ45NAKniMp85l450HZIUIegdqpuBHP'
    config.oauth_token_secret = 'YLf1tCBCOxsJP1jNvxvJtCu1ZmIKccS1Q35I44T54'
  end
end 

helpers do
  def count_vowels(string)
    string.count "aeiou"
  end
  def up_vowels(string)
    string.downcase.gsub(/[aeiou]/) {|v| v.capitalize}
  end
end

get '/' do
  in_tweets = Twitter.user_timeline("wintr_us", :count => 5)
  out_tweets = []
  in_tweets.each do |current_tweet|
    current_tweet_text =  up_vowels current_tweet['text']
    current_vowel_count = count_vowels current_tweet['text']
    out_tweets.push({'text' => current_tweet_text,'vowel_count' => current_vowel_count, 'id' => current_tweet['id']})
  end
  @tweets = out_tweets.sort! { |a,b| b['vowel_count'] <=> a['vowel_count'] }
  erb :index  
end

