class User < ActiveRecord::Base
  acts_as_authentic
  HUMANIZED_ATTRIBUTES = {
    :login => "Имя пользователя" 
  }

  has_many :posts,:foreign_key=>:author_id
end
