module SimpleTooltip
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
  
      desc "This generator installs all the files necessary for the simple_tooltip gem"
      argument :simple_tooltip_name, :type => :string, :default => 'simple_tooltip'

    # the simple_tooltip_name argument allows the user to change the name of the model, etc
    # possible actions include directory (copy files recursively)
    # rake, rakefile and route...

    def copy_stylesheet_and_images
#      STDERR.puts "** copy_stylesheet **"
#      copy_file "./public/stylesheets/simple_tooltip.css", "public/stylesheets/simple_tooltip.css"
#      copy_file "./public/images/simple_tooltip_help_icon.png",  "public/images/simple_tooltip_help_icon.png"
#      copy_file "./public/images/simple_tooltip_close_icon.png", "public/images/simple_tooltip_close_icon.png"

    end

    def copy_javascript
#      STDERR.puts "** copy_javascript **"
#      copy_file "./public/javascripts/simple_tooltip.js", "public/javascripts/simple_tooltip.js"
    end

#    def copy_migration
#    end
  
#    def copy_mvc_files
#    end
  
#    def copy_tests
#    end

    # Add this multi line definition to the routes file
    def setup_route

#      STDERR.puts "** setup_route **"

      route "resources :mytest"
      
#      route "resources :simple_tooltips do\
#      collection do \
#        get 'tooltip_content' \
#      end \
#    end"
    end
  
  end
end
