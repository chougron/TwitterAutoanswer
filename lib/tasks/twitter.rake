require "#{Rails.root}/app/helpers/twitter_helper"
include TwitterHelper

namespace :twitter do

    #Get the last followers and save it in the database as a flag
    task :init_list => :environment do
        Follower.delete_all

        client = get_twitter_client()

        client.followers.each do |user|
            follower = Follower.new()
            follower.twitter_id = user.id
            follower.name = user.name
            follower.save
            break
        end 
    end

    #List the saved followers
    task :saved_followers => :environment  do
        Follower.all.each do |follower|
            print follower.name + " (" + follower.twitter_id + ")\n"
        end
    end

    #Send a DM to new followers
    task :send_dm => :environment  do
        client = get_twitter_client()

        client.followers.each do |user|
            follower = Follower.where(twitter_id: user.id).first

            if follower
                #If we find the follower, it means DM was already sent, and there is no other new follower
                break
            else
                print "Will send DM to " + user.name + " (" + user.id.to_s + ")\n";
                message = get_message(user)

                print "The DM will be :\n"
                print message + "\n"
                client.create_direct_message(user.id, message)
                follower = Follower.new()
                follower.twitter_id = user.id
                follower.name = user.name
                follower.save
            end
        end
    end

    #Set the Twitter Configuration
    task :set_config => :environment do
        _, consumer_key, consumer_secret, access_token, access_token_secret = ARGV

        if !consumer_key || !consumer_secret || !access_token || !access_token_secret
            print "Missing parameter. The format is twitter:set_config consumer_key consumer_secret access_token access_token_secret\n"
            exit
        end

        Setting.set('consumer_key', consumer_key)
        Setting.set('consumer_secret', consumer_secret)
        Setting.set('access_token', access_token)
        Setting.set('access_token_secret', access_token_secret)

        print "Twitter configuration set. You can now use the service.\n"
        exit
    end

end

#List the twitter commands
task :twitter do
    print "List of commands :\n"
    print "  twitter:init_list\n"
    print "  twitter:saved_followers\n"
    print "  twitter:send_dm\n"
    print "  twitter:set_config consumer_key consumer_secret access_token access_token_secret\n"
end