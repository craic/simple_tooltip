module SimpleTooltip
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
  
      desc "This generator installs all the files necessary for the simple_tooltip gem"
      argument :simple_tooltip_name, :type => :string, :default => 'simple_tooltip'

      # the simple_tooltip_name argument allows the user to change the name of the model, etc
      # possible actions include directory (copy files recursively)
      # rake, rakefile and route...
      # Look here for the list of actions:
      # https://github.com/rails/rails/blob/master/railties/lib/rails/generators/actions.rb
      # and
      # http://rdoc.info/github/wycats/thor/master/Thor/Actions
      
      def copy_stylesheet_and_images
        copy_file "./public/stylesheets/simple_tooltip.css", "public/stylesheets/simple_tooltip.css"
        copy_file "./public/images/simple_tooltip_help_icon.png",  "public/images/simple_tooltip_help_icon.png"
        copy_file "./public/images/simple_tooltip_close_icon.png", "public/images/simple_tooltip_close_icon.png"
      end

      def copy_javascript
        copy_file "./public/javascripts/simple_tooltip.js", "public/javascripts/simple_tooltip.js"
      end

      def copy_migration
        # Migration file name is preceded by the date/time string
        # So use generate to create it, get the generated name and replace the contents
        generate(:migration, "create_simple_tooltips")
        # Get the most recent migration file that matches
        # 
        src_file = "./db/migrate/create_simple_tooltips.rb"
        files = Dir.glob("db/migrate/*create_simple_tooltips.rb").sort
        if files.length == 0
          copy_file src_file, "db/migrate/create_simple_tooltips.rb"
        else
          # delete the existing file
          path = files.last
          File.delete(path)
          # copy the migration template into its place
          copy_file src_file, path
        end
      end
  
  #    def copy_mvc_files
  #    end
  
  #    def copy_tests
  #    end

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
