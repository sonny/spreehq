class Image < ActiveRecord::Base
  belongs_to :viewable, :polymorphic => true
  acts_as_list :scope => :viewable
  has_attachment :content_type => :image,
                 :size => 0.kilobytes..500.kilobytes,
                 :resize_to => '800x',
                 :thumbnails => {:preview => '150x', :thumb => [48,48]},
                 :path_prefix => 'public/images/viewable',
                 :storage => :file_system,
                 :processor => :MiniMagick
                 
  validates_as_attachment
end
