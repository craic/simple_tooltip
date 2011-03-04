module SimpleTooltipHelper

  # tooltip helper for inclusion in views
  # TODO - allow a custom class to be passed - e.g. twitter style - look at poshy tip
  def simple_tooltip(text='', mode=:hover)

    return if text == ''
    
    tooltip_help_icon_file = "/images/simple_tooltip_help_icon.png"

    class_str = "simple-tooltip-help-icon"    
    if mode == :click
      title = 'Click for help'
      class_str << " simple-tooltip-clickable"
    else
      title = text
    end

    link_to(image_tag(tooltip_help_icon_file), 
            tooltip_content_simple_tooltips_path(:title => text),
            :name => text, :title => title, 
            :class => class_str)
  end
  
end
