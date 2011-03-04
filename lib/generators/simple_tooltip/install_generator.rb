module SimpleTooltip
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
  
      desc "This generator installs all the files necessary for the simple_tooltip gem"

#      argument :simple_tooltip_name, :type => :string, :default => 'simple_tooltip'

      # the simple_tooltip_name argument allows the user to change the name of the model, etc
      # possible actions include directory (copy files recursively)
      # rake, rakefile and route...
      # Look here for the list of actions:
      # https://github.com/rails/rails/blob/master/railties/lib/rails/generators/actions.rb
      # and
      # http://rdoc.info/github/wycats/thor/master/Thor/Actions
      
      def copy_stylesheet_and_images
        path = "public/stylesheets/simple_tooltip.css"
        copy_file "./#{path}", path
        path = "public/images/simple_tooltip_help_icon.png"
        copy_file "./#{path}", path
        path = "public/images/simple_tooltip_close_icon.png"
        copy_file "./#{path}", path

#        copy_file "./public/stylesheets/simple_tooltip.css", "public/stylesheets/simple_tooltip.css"
#        copy_file "./public/images/simple_tooltip_help_icon.png",  "public/images/simple_tooltip_help_icon.png"
#        copy_file "./public/images/simple_tooltip_close_icon.png", "public/images/simple_tooltip_close_icon.png"
      end

      def copy_javascript
#        copy_file "./public/javascripts/simple_tooltip.js", "public/javascripts/simple_tooltip.js"

        path = "public/javascripts/simple_tooltip.js"
        copy_file "./#{path}", path
      end

      def copy_migration
        # Migration file name is preceded by the date/time string - UTC timestamp Time.now.gmtime.strftime("%Y%m%d%H%M%S")
        copy_file "./db/migrate/create_simple_tooltips.rb", 
                  "db/migrate/#{Time.now.gmtime.strftime("%Y%m%d%H%M%S")}_create_simple_tooltips.rb"
      end
  
      def copy_app_files
        path = "app/controllers/simple_tooltips_controller.rb"
        copy_file "./#{path}", path
        path = "app/models/simple_tooltip.rb"
        copy_file "./#{path}", path
        path = "app/helpers/simple_tooltip_helper.rb"
        copy_file "./#{path}", path
        path = "app/views/simple_tooltips"
        directory "./#{path}", path
      end
  
      def copy_tests
        path = "test/unit/simple_tooltip_test.rb"
        copy_file "./#{path}", path
        path = "test/unit/helpers/simple_tooltips_helper_test.rb"
        copy_file "./#{path}", path
        path = "test/fixtures/simple_tooltips.yml"
        copy_file "./#{path}", path
        path = "test/functional/simple_tooltips_controller_test.rb"
        copy_file "./#{path}", path
      end

      # Add this multi line definition to the routes file - but only a single call to route
      # otherwise they are placed in reverse line order!
      def setup_route
        route "resources :simple_tooltips do\n" +
              "             collection do\n" +
              "               get 'tooltip_content'\n" +
              "             end\n" +
              "           end"
      end

    end
  end
end
