Simple Tooltip
==============

Simple and flexible Tooltip Help for Rails 3 applications

There are many JavaScript plugins that provide basic tooltip (popup) help for web pages. These work by including the 
text of the help message directly in the content of each page.

But this approach fails when the information requires more than one paragraph and when more than plain
text is required. For example, the help message might require a link to an external web site.

With Simple Tooltip you create tooltip help content in a web form and record it in the database via a Tooltip model.
Content can be created in plain text, HTML, Markdown and Textile, allowing tooltips to use the
full features of HTML, including links, CSS styling, etc.

Take a look at the [Demo Site](http://simple-tooltip-demo.craic.com 'Demo site') to see it in action.

Tooltip links, typically small icons, are placed in your views with calls to a simple helper method that refer 
to the related content by title.

Tooltip records include a locale column that defines the language used for their content. Multiple tooltips can
be created with the same title but different locales. When a given title is requested, the code tries to find
a version that matches the user's current locale.

Simple Tooltip helps bridge the gap between short, fixed tooltips and full help pages. 

Tooltips are displayed via [jQuery](http://jquery.com "jQuery") script. They can be configured to appear transiently when a user hovers over a link icon,
or to appear when the link icon is clicked, remaining until closed by a click within the tooltip.


If the client browser does not have JavaScript enabled, the tooltip links take the user to a separate help 
page.

Developers can customize the styling of the tooltip content via CSS definitions and tooltip icons can be replaced with others.


Prerequisites
=============

The initial release of Simple Tooltip works with [Rails 3](http://rubyonrails.org "Rails 3") and [jQuery](http://jquery.com "jQuery"). It is not expected to work with Rails 2.


Installation
============

Simple Tooltip is distributed as a Ruby Gem and is installed in an application via a Rails generator.

1: Install the gem on your system

	$ gem install simple-tooltip

The gem is hosted at [Ruby Gems](https://rubygems.org "Ruby Gems")

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


Internationaliztion
===================

Simple Tooltip helps you provide help in multiple languages. Rails itself provides extensive support through the <a href="http://guides.rubyonrails.org/i18n.html">I18n functions</a>, but this mostly targets short text strings, such as 
labels for form fields, standard error messages, etc.

To support multiple languages in Simple Tooltip, you create multiple Tooltip database records with the same Title but 
different Locales (specified in ISO-639-1 Two letter format, e.g. 'de').

The code uses the value of I18n.locale as defined by your application, and defaults to I18n.default_locale. If it can find
a version of the tooltip that matches the user's locale then it will use it. 

If you don't want to use internationalization then don't worry about it. Just leave the 'locale' field blank in the tooltip form.

While this mechanism is separate from the Rails I18n approach, I think it offers some advantages when you want to create 
large blocks of help text.

Author
======

Simple Tooltip is written by [Rob Jones](http://github.com/craic "Rob Jones") at [Craic Computing](http://craic.com "Craic Computing") in Seattle. It is distributed freely under the MIT license.




