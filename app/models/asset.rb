class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_attached_file  :document, :url => "/:class/:attachment/:id/:style_:filename"
end
