module TagExtensions
  include Radiant::Taggable

  class TagError < StandardError; end
  
  desc %{
    Render contents only if <code>description</code> attribute exists.
    
    *Usage*:
    <pre><code><r:meta:if_description>...</r:meta:if_description></code></pre>
  }
  tag 'meta:if_description' do |tag|
    tag.expand unless tag.locals.page.description.blank?
  end

  desc %{
    Sets a variable specified by the name in @var@ in the page context.
    When used as a single tag it uses the @value@ attribute.
    When used as a double tag the part between both tags will be used as the value.
    
    *Usage*:
    <pre><code><r:set var="variable_name" value="variable_value"/></code></pre>
    or
    <pre><code><r:set var="variable_name">...variable value...</r:set></code></pre>
  }
  tag "set" do |tag|
    var = tag.attr['var']
    value = tag.double? ? tag.expand : tag.attr['value']
    tag.globals.send(:"#{var}_var=", value)
    ''
  end
  
  desc %{
    Gets the value of a previously set value with <code><r:set/></code>.
    
    *Usage*:
    <pre><code><r:get var="variable_name"/></code></pre>
  }
  tag "get" do |tag|
    var = tag.attr['var']
    tag.globals.send(:"#{var}_var")
  end

  tag_descriptions['if_children'] = RedCloth.new(Util.strip_leading_whitespace(%{
    Renders the contained elements only if the current contextual page has one or
    more child pages.  The @status@ attribute limits the status of found child pages
    to the given status, the default is @"published"@. @status="all"@ includes all
    non-virtual pages regardless of status.
    
    You can specify the minimum required number of children with @min_count@.
    
    *Usage:*
    <pre><code><r:if_children [status="published"] [min_count="0"]>...</r:if_children></code></pre>
  })).to_html
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
  
  tag 'cycle' do |tag|
    raise TagError, "`cycle' tag must contain a `values' attribute." unless tag.attr['values']
    cycle = (tag.globals.cycle ||= {})
    cycle_count = (tag.globals.cycle_count ||= {})
    values = tag.attr['values'].split(",").collect(&:strip)
    cycle_name = tag.attr['name'] || 'cycle'
    current_index = (cycle[cycle_name] ||=  0)
    current_index = 0 if tag.attr['reset'] == 'true'
    cycle[cycle_name] = (current_index + 1) % values.size
    cycle_count[cycle_name] = (cycle_count[cycle_name] || 1) + 1 if current_index + 1 == values.size
    values[current_index]
  end
  
  tag 'cycle_number' do |tag|
    cycle_count = (tag.globals.cycle_count ||= {})
    cycle_name = tag.attr['name'] || 'cycle'
    cycle_count[cycle_name] || 1
  end
end