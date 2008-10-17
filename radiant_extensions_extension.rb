# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RadiantExtensionsExtension < Radiant::Extension
  version "0.1"
  description "Radiant core extensions"
  url "http://github.com/ihoka/radiant-extensions-extension"
  
  def activate
    Page.send(:include, TagExtensions)
  end
  
  def deactivate
  end
  
end