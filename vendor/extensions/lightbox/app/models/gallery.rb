class Gallery < ActiveRecord::Base
  has_many :images, :as => :viewable, :dependent => :destroy, :order => :position
  
  validates_presence_of :name
end
