module TooltipHelper

  # tooltip helper for inclusion in views
  # TODO - allow a custom class to be passed - e.g. twitter style - look at poshy tip
  def tooltip(text='', mode=:hover)

    return if text == ''
    
    tooltip_help_icon_file = "/images/simple_tooltip_help_icon.png"

    class_str = "simple-tooltip-help-icon"    
    if mode == :click
      title = 'Click for help'
      class_str << " simple-tooltip-clickable"
    else
      title = text
    end
    # Add the locale to the class string - e.g. locale_de
    class_str << " locale_#{I18n.locale.to_s}"
    
    link_to(image_tag(tooltip_help_icon_file), 
            tooltip_content_tooltips_path(:title => text, :locale => I18n.locale.to_s),
            :name => text, :title => title, 
            :class => class_str)
  end
  
end
