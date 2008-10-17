module TagExtensions
  include Radiant::Taggable

  def self.included(base)
    PageContext.send(:include, PageContextExtensions)
    Radius::TagBinding.send(:include, TagBindingExtensions)
  end
  
  module PageContextExtensions
    def parser
      page.instance_variable_get(:@parser)
    end
  end
  
  module TagBindingExtensions
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.send(:alias_method, :attr, :parsed_attributes)
    end
    
    module InstanceMethods
      def parsed_attributes
        @parsed_attributes ||= parse_attributes
      end
    
      private
        def parse_attributes
          new_attr = {}
          @attributes.each do |k, v|
            new_attr[k] = context.parser.parse(v)
          end
          new_attr
        end
    end
  end

  tag "set" do |tag|
    var = tag.attr['var']
    value = tag.double? ? tag.expand : tag.attr['value']
    tag.globals.send(:"#{var}_var=", value)
    ''
  end
  
  tag "get" do |tag|
    var = tag.attr['var']
    tag.globals.send(:"#{var}_var")
  end

  tag "if_children" do |tag|
    count = tag.attr['min_count'] && tag.attr['min_count'].to_i || 0
    children = tag.locals.page.children.count(:conditions => children_find_options(tag)[:conditions])
    tag.expand if children > count
  end
  
  tag 'if_matches' do |tag|
    regexp = regexp = Regexp.new(tag.attr['regexp'])
    value = tag.attr['value']
    unless value.match(regexp).nil?
       tag.expand
    end
  end
end