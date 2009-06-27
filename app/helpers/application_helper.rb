module ApplicationHelper
  def submit_tag(value = t("views.common.save_changes"), options = {})
    or_option = options.delete(:or)
    return super + "<span class='button_or'> #{t("views.common.or")} #{or_option}</span>" if or_option
    super
  end
  
  def textilize(text)
    Textilizer.new(text).to_html unless text.blank?
  end
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def back(url)
    content_for(:back) { link_to t("views.common.back").downcase, url}
  end
  
  def tab_for(name, href, html_options = {})
    request.request_uri.split('/').last == name ? html_options.merge!(:class => 'tab active') : html_options.merge!(:class => 'tab')
    content_tag :div, (link_to t("shared.settings.#{name}"), href), html_options
  end
end
