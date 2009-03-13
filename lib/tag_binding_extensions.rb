module TagBindingExtensions
  def self.included(base)
    base.send(:include, InstanceMethods)
    # base.send(:alias_method, :orig_attr, :attr)
    # base.send(:alias_method, :attr, :parsed_attributes)
    base.send(:alias_method_chain, :attr, :parsed_attributes)
  end
  
  module InstanceMethods
    def attr_with_parsed_attributes
      if PageContext === context
        parsed_attributes
      else
        attr_without_parsed_attributes
      end
    end
    
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
