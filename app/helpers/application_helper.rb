module ApplicationHelper
  def include_css_for_controller(_controller_name)
    file = Rails.root.join('app', 'assets', 'stylesheets', "#{_controller_name}.scss")
    stylesheet_link_tag _controller_name if File.exist?(file)
  end
end
