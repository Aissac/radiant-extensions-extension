module PageContextExtensions
  def parser
    page.instance_variable_get(:@parser)
  end
end
