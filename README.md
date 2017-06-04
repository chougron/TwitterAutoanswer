# Requirements

Working with Ruby 2.3.1 and Rails 5.1.1

You will also need to install the twitter gem 

`gem install twitter`

# Installation

Install the database with the following command :

`bin/rails db:migrate`

# Usage

You need to first set the configuration for the twitter API (to generate at https://apps.twitter.com). You will need Read, write and direct messages permission.

`bin/rails twitter:set_config consumer_key consumer_secret access_token access_token_secret`

You also need to configure the message that you want to send to your new followers. You can use the variable #NAME that will be replaced with the screen name of the follower.

`bin/rails settings:set_message "Hello #NAME, this is a message for my new followers."`

Then, load the list of your current followers, to compare with the future list and send DM to your new followers.

`bin/rails twitter:init_list`

Finally, you can set a cron job or manually send DM to your new followers with the following command :

`bin/rails twitter:send_dm`