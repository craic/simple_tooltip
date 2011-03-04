SimpleTooltip
=============

Simple and flexible Tooltip Help for Rails applications

There are many JavaScript plugins that provide basic tooltip (popup) help for web pages. These work by including the 
text of the help message directly in the content of each page.

But this approach fails when the information requires more than one paragraph and when more than plain
text is required. For example, the help message might require a link to an external web site.

With SimpleTooltip you create tooltip help content in a web form and record it in the database via a Tooltip model.
Content can be created in plain text, HTML, Markdown and Textile, allowing tooltips to use the
full features of HTML, including links, CSS styling, etc.

Tooltip links, typically small icons, are placed in your views with calls to a simple helper method that refer 
to the related content by title.

Tooltip records include a locale column that defines the language used for their content. Multiple tooltips can
be created with the same title but different locales. When a given title is requested, the code tries to find
a version that matches the user's current locale.

SimpleTooltip helps bridge the gap between short, fixed tooltips and full help pages. 

Tooltips are displayed via a jQuery. They can be configured to appear transiently when a user hovers over a link icon,
or to appear when the link icon is clicked, remaining until closed by a click within the tooltip.


If the client browser does not have JavaScript enabled, the tooltip links take the user to a separate help 
page.

Developers can customize the styling of the tooltip content via CSS definitions and tooltip icons can be replaced with others.


Prerequisites
=============

The initial release of SimpleTooltip works Rails 3 and jQuery. It is not expected to work with Rails 2.


Installation
============

SimpleTooltip is distributed as a Ruby Gem and is installed in an application via a Rails generator.

1: Install the gem on your system

	$ gem install simple-tooltip

2: Within your Rails application, run the generator

	$ rails generate simple_tooltip:install

(note the underscore in the generator name - this seems to be a requirement of the Rails generator machinery)

The generator creates the following items

* A Tooltip model, controller and views and a database migration
* A stylesheet, javascript file and icon image files
* Tests

3: Setup your gem dependencies

Add this line to your Gemfile and run `$ bundle install`

	gem 'simple-tooltip'

4: Create the tooltips table in your database

	$ rake db:migrate

5: Include the JQuery file

Make sure you have the jQuery JavaScript library installed (via jquery-rails)'
	$ rails generate jquery:install

Then add this line to `app/views/layouts/application.html.erb` after other JavaScript files
	<%= javascript_include_tag 'simple_tooltip.js' %>

The stylesheet should be included automatically.

6: Now create some tooltips 

Start your application and go to /tooltips/new

7: In the views of other models, add links to your tooltip records

For example:

	<%= tooltip('email format', :hover) %>
	<%= tooltip('privacy agreement', :click) %>


Usage
=====

Tooltips are defined in your views with the tooltip helper method, found in `app/helpers/tooltip_helper.rb`

Each tooltip record in the database should be given a title, preferably something informative such as 'phone number format'.
This title is supplied to the tooltip helper in order to retrieve the matching record.

Multiple calls to the helper can use the same title. They will operate independently.

The tooltip 'popup' is displayed in one of two modes.

The default `:hover` mode specifies that the tooltip will appear when the mouse is held over the help icon and will
disappear when the mouse leaves that icon.

With the `:click` mode, the tooltip appears then the icon is clicked. The tooltip remains in view until the `close` icon at the 
top of the tooltip is clicked or until another tooltip help icon is clicked.

This mode is used when the tooltip contains a link to another web page or when the content is extensive.


Customizing
===========

Although the Tooltip model, etc use the word `tooltip`, the images and other asset files use the longer form `simple_tooltip`. This is
intentional as a number of the JavaScript tooltip solutions use the shorter form.

The help and close icons are found in `public/images/simple_tooltip_help_icon.png` and `public/images/simple_tooltip_close_icon.png`
respectively. The images can be replaced as long as the file names stay the same. If you want to change the filenames you will
need to modify them in the JavaScript file.

The stylesheet is found at `public/stylesheets/simple_tooltip.css` and defines two class selectors that affect how the icons are displayed and an ID selector that defines how the 'popup'
tooltip content is displayed.

The jQuery JavaScript is found at `public/javascripts/simple_tooltip.js`. You should not need to modify this file.

SimpleTooltip is written by [Rob Jones]http://github.com/craic at [Craic Computing]http://craic.com in Seattle. It is distributed freely under the MIT license.




