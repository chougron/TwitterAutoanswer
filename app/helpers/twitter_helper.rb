module TwitterHelper
    def get_twitter_client
        client = Twitter::REST::Client.new do |config|
            config.consumer_key         = Setting.get("consumer_key", "")
            config.consumer_secret      = Setting.get("consumer_secret", "")
            config.access_token         = Setting.get("access_token", "")
            config.access_token_secret  = Setting.get("access_token_secret", "")
        end
    end

    def get_message(follower)
        message = Setting.get("message", "")
        message.gsub! '#NAME', follower.name
    end
end
