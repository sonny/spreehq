# dependencies
require 'mini_magick'
require 'tempfile'
require 'geometry'

class LightboxExtension < Radiant::Extension
  version "1.0"
  description "Allows you to generate a gallery of images using lightbox javascript effects."
  url "http://yourwebsite.com/lightbox"
  
  define_routes do |map|
    map.connect 'admin/gallery/:action', :controller => 'admin/gallery'
    map.connect 'admin/images/:action', :controller => 'admin/images'
  end
  
  def activate
    init_attachment_fu
    admin.tabs.add "Gallery", "/admin/gallery", :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Images", "/admin/images", :after => "Gallery", :visibility => [:all]
    # make the custom tags available
    Page.send :include, LightboxTags
  end
  
  def deactivate
    admin.tabs.remove "Gallery"
    admin.tabs.remove "Images"
  end
  
  private

      # perform steps normally done in the init.rb of the attachment_fu plugin
      def init_attachment_fu
        Tempfile.class_eval do
          # overwrite so tempfiles use the extension of the basename.  important for rmagick and image science
          def make_tmpname(basename, n)
            ext = nil
            sprintf("%s%d-%d%s", basename.to_s.gsub(/\.\w+$/) { |s| ext = s; '' }, $$, n, ext)
          end
        end
        ActiveRecord::Base.send(:extend, Technoweenie::AttachmentFu::ActMethods)
        Technoweenie::AttachmentFu.tempfile_path = ATTACHMENT_FU_TEMPFILE_PATH if Object.const_defined?(:ATTACHMENT_FU_TEMPFILE_PATH)
        FileUtils.mkdir_p Technoweenie::AttachmentFu.tempfile_path
      end
  
end