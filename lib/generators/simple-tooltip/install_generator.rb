module SimpleTooltip
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
  
      desc "This generator installs all the files necessary for the simple_tooltip gem"

      
      def copy_stylesheet_and_images
        path = "public/stylesheets/simple_tooltip.css"
        copy_file "./#{path}", path
        path = "public/images/simple_tooltip_help_icon.png"
        copy_file "./#{path}", path
        path = "public/images/simple_tooltip_close_icon.png"
        copy_file "./#{path}", path
      end

      def copy_javascript
        path = "public/javascripts/simple_tooltip.js"
        copy_file "./#{path}", path
      end

      def copy_migration
        # Migration file name is preceded by the date/time string - UTC timestamp Time.now.gmtime.strftime("%Y%m%d%H%M%S")
        copy_file "./db/migrate/create_tooltips.rb", 
                  "db/migrate/#{Time.now.gmtime.strftime("%Y%m%d%H%M%S")}_create_tooltips.rb"
      end
  
      def copy_app_files
        path = "app/controllers/tooltips_controller.rb"
        copy_file "./#{path}", path
        path = "app/models/tooltip.rb"
        copy_file "./#{path}", path
        path = "app/helpers/tooltip_helper.rb"
        copy_file "./#{path}", path
        path = "app/views/tooltips"
        directory "./#{path}", path
      end
  
      def copy_tests
        path = "test/unit/tooltip_test.rb"
        copy_file "./#{path}", path
        path = "test/unit/helpers/tooltips_helper_test.rb"
        copy_file "./#{path}", path
        path = "test/fixtures/tooltips.yml"
        copy_file "./#{path}", path
        path = "test/functional/tooltips_controller_test.rb"
        copy_file "./#{path}", path
      end

      # Add this multi line definition to the routes file - but only a single call to route
      # otherwise they are placed in reverse line order!
      def setup_route
        route "resources :tooltips do\n" +
              "             collection do\n" +
              "               get 'tooltip_content'\n" +
              "             end\n" +
              "           end"
      end

      # Output installation instructions for the user
      def instructions
        puts '---------------------------------------------------------------'
        puts 'To complete your installation...'
        puts ''
        puts "1: Add this gem to your project Gemfile and run 'bundle install'"
        puts ''
        puts "   gem 'simple-tooltip'"
        puts ''
        puts '2: Create the tooltips database table'
        puts ''
        puts "   $ rake db:migrate"
        puts ''
        puts '3: Make sure you have the jQuery JavaScript library installed'
        puts '   via the jquery-rails gem'
        puts ''
        puts '   $ rails generate jquery:install'
        puts ''
        puts '4: Check that these lines are in layouts/application.html.erb'
        puts ''
        puts '  <%= stylesheet_link_tag :all %>'
        puts '  <%= javascript_include_tag :defaults %>'
        puts ''
        puts '5: Add this line after those two'
        puts ''
        puts "  <%= javascript_include_tag 'simple_tooltip.js' %>"
        puts ''
        puts '6: Create some tooltip entries in /tooltips'
        puts '   and add links to those entries in your views'
        puts "   <%= tooltip('tooltip title', :hover) %>"
        puts ''
        puts 'For more information see the project page on GitHub'
        puts '   https://github.com/craic/simple_tooltip'
        puts '---------------------------------------------------------------'
      end
      
    end
  end
end
