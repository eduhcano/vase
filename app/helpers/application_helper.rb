# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def submit_tag(value = "Save changes", options = {})
    or_option = options.delete(:or)
    return super + "<span class='button_or'>" + " or " + or_option + "</span>" if or_option
    super
  end
end
