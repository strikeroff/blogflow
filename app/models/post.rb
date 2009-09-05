class Post < ActiveRecord::Base
  acts_as_taggable
   has_many :assets, :as=> :attachable
  HUMANIZED_ATTRIBUTES = {
     :title => "Заголовок",
          :body => "Заголовок"
   }
  
  belongs_to :author, :class_name=> User, :foreign_key=>:author_id
  validates_presence_of :title, :body, :author_id
end
