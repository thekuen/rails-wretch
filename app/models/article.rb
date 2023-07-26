class Article < ApplicationRecord
    validates :title, :content, presence: true

    belongs_to :user
    has_many :comments

    has_many :like_logs
    has_many :users, through: :like_logs

    #update(deleted_at: Time.current)
end
