class User < ApplicationRecord
    has_many :user_qualities
    has_many :qualities, through: :user_qualities

    has_many :posts

    # Classifications of users who have classified your posts
        # returns - A collection Classification objects
    has_many :classifications_recieved, class_name: "Classification"

    # Classifications you have made for other users posts
        # returns - A collection Classification objects
    has_many :classifications_made, foreign_key: :classifier_id, class_name: "Classification"

    # Users you have classified posts for 
        # returns - A collection User objects
    has_many :classified_users, through: :classifications_made, source: :user


    def get_quality_rating(quality_id)
        rating = 1
        self.posts.each do |post|
            post.classifications.where(quality_id: quality_id, active: true).each do |classification|
                rating += classification.rating_snapshot
            end
        end
        rating
    end


    # def classify(post_id, quality_id)
    #     classification = Classification.new
    #     classification.user_id = self.id
    #     classification.post_id = post_id
    #     classification.quality_id = quality_id
    #     classification.rating_snapshot = self.get_quality_rating(quality_id)**0.5 + 1
    #     classification.save
    # end

end














