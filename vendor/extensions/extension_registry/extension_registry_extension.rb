# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ExtensionRegistryExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/extension_registry"
  
  define_routes do |map|
    #map.connect 'admin/extension_registry/test', :controller => 'admin/extensions'
    map.resources :extensions
    #map.resources :authors
  end
  
  def activate
    admin.tabs.add "Extension Registry", "/admin/extension_registry", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Extension Registry"
  end
  
end
