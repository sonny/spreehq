class Image < ActiveRecord::Base
  belongs_to :viewable, :polymorphic => true
  acts_as_list :scope => :viewable
  has_attachment :content_type => :image,
                 :max_size => 500.kilobyte,
                 :resize_to => '800x',
                 #:resize_to => [360,360],
                 #:thumbnails => {:preview => [100,100], :thumb => [48,48]},
                 :thumbnails => {:preview => '150x', :thumb => [48,48]},
                 :path_prefix => 'public/images/viewable',
                 :storage => :file_system,
                 :processor => :MiniMagick
                 
  validates_as_attachment
end
