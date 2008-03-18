module LightboxTags
  include Radiant::Taggable
  
  tag 'gallery' do |tag|
    result = []
    result << %{<link rel="stylesheet" type="text/css" href="/stylesheets/lightbox.css" />}
    result << %{<script src="/javascripts/prototype.js" type="text/javascript"></script>}
    result << %{<script src="/javascripts/scriptaculous.js?load=effects,builder" type="text/javascript"></script>}
    result << %{<script src="/javascripts/lightbox.js" type="text/javascript"></script>}
    result << tag.expand
  end
  
  tag 'gallery:images' do |tag|
    tag.expand
  end
  
  tag 'gallery:images:each' do |tag| 
    result = []
    gallery = Gallery.find(:first)
    gallery.images.each do |image|
      tag.locals.image = image
      result << tag.expand
    end
    result
  end
  
  tag 'gallery:images:each:image' do |tag| 
    image = tag.locals.image
    %{<a href="#{image.public_filename}" rel="lightbox[gallery]"> <img src="#{image.public_filename(:preview)}"/> </a>}
  end
end