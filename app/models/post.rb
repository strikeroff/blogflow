class Post < ActiveRecord::Base
  acts_as_taggable
  has_many :assets, :as=> :attachable
  has_many :comments,  :as=>:commentable
  
  HUMANIZED_ATTRIBUTES = {
          :title => "Заголовок",
          :body => "Основное содержание"
  }

  belongs_to :author, :class_name=> "User", :foreign_key=>:author_id
  validates_presence_of :title, :body, :author_id
end
