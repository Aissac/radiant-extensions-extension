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
