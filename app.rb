configure do
  # Setup the Twitter API using twintr app
  Twitter.configure do |config|
    config.consumer_key       = '79hkBJUSc7BmCREbiH3AAg'
    config.consumer_secret    = 'zcEMmH4dIL2X6lMf4Zr8bFTRK5p4EyrvZI5L8yTHY'
    config.oauth_token        = '15090301-MZrQF86MhuuZ45NAKniMp85l450HZIUIegdqpuBHP'
    config.oauth_token_secret = 'YLf1tCBCOxsJP1jNvxvJtCu1ZmIKccS1Q35I44T54'
  end
end 

helpers do
  # Count the vowels in a string
  def count_vowels(string)
    string.count "aeiou"
  end
  # Downcase the string; upcase the vowels
  def up_vowels(string)
    string.downcase.gsub(/[aeiou]/) {|v| v.capitalize}
  end
end

get '/' do
  # Get 5 latest tweets from WINTR_US
  in_tweets = Twitter.user_timeline("wintr_us", :count => 5)
  # Empty array to hold augmented tweets
  out_tweets = []
  # Tweet Loop
  in_tweets.each do |current_tweet|
    # Count Vowels / Augment Text
    current_tweet_text =  up_vowels current_tweet['text']
    current_vowel_count = count_vowels current_tweet['text']
    # Prepare Output for Template
    out_tweets.push({
      'text' => current_tweet_text,
      'vowel_count' => current_vowel_count, 
      'id' => current_tweet['id'],
      'user' => current_tweet['user']
      })
  end
  # Place Output in an instance variable whilst sorting by vowel count
  @tweets = out_tweets.sort! { |a,b| b['vowel_count'] <=> a['vowel_count'] }
  # Prepare ERB Template
  content_type 'text/html', :charset => 'utf-8'
  erb :index  
end

