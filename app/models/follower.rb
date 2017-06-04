class Follower < ApplicationRecord
    validates :twitter_id, presence: true, uniqueness: { case_sensitive: true }
    validates :name, presence: true
end
