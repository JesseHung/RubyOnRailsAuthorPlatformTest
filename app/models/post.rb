class Post < ApplicationRecord
  has_many :comments
  belongs_to :author
end
