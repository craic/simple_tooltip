require 'test_helper'

class TooltipTest < ActiveSupport::TestCase

  
  # test no script validation routine
  
  test "validate ok if content has no <script> tag" do
    tooltip = Tooltip.new(:title => 'foo', :markup => 'html', 
                                :content => "<p>all good here</p>")
    assert tooltip.valid?
  end

  test "validate with error if content has <script> tag" do
    tooltip = Tooltip.new(:title => 'foo', :markup => 'html', 
                                :content => "foo <script> bad \n stuff </script> bar")
    assert !tooltip.valid?
    assert tooltip.errors[:content].any?    
  end

  test "validate with error if format of locale is not two letter" do
    tooltip = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'locale', 
                                :content => "text")
    assert !tooltip.valid?
    assert tooltip.errors[:locale].any?    
  end

  test "validate OK if format of locale is two letter" do
    tooltip = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'en', 
                                :content => "text")
    assert tooltip.valid?
  end


  test "validate fails unless unique title and locale" do
    tooltip0 = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'en',
                                 :content => "<p>Here to help</p>")
    tooltip0.save!
    
    tooltip1 = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'en',
                                 :content => "<p>Here to help</p>")


    assert !tooltip1.valid?
    assert tooltip1.errors[:title].any?  
  end


  test "validate passes duplicate title but unique locale" do

    tooltip0 = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'en',
                                 :content => "<p>Here to help</p>")
    tooltip0.save!
    
    tooltip1 = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'de',
                                 :content => "<p>Here to help</p>")

    assert tooltip1.valid?
  end
  
  
  test "content_to_html passes through html content" do
    content = "<p>Here is some text in <span style=\"color: red;\">HTML</span> format.</p>"
    tooltip = Tooltip.new(:title => 'foo', :markup => 'html', 
                                :content => content)
    assert_equal tooltip.content_to_html, content
  end


  test "content_to_html converts Markdown content to html" do
    content = "<p>Here is some text in <strong>Markdown</strong> format</p>\n\n<p><a href=\"http://craic.com\">http://craic.com</a></p>\n"
    markdown = "Here is some text in **Markdown** format\n\nhttp://craic.com"
    tooltip = Tooltip.new(:title => 'foo', :markup => 'markdown', 
                                :content => markdown)
    assert_equal tooltip.content_to_html, content
  end

  test 'class method from_title_and_locale return the correct tooltip' do
  
    tooltip0 = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'en',
                                 :content => "<p>English text</p>")
    tooltip0.save!
    
    tooltip1 = Tooltip.new(:title => 'foo', :markup => 'html', :locale => 'de',
                                 :content => "<p>German text</p>")

    tooltip1.save!
  
  
    tooltip_out = Tooltip.from_title_and_locale('foo', 'de')

    assert_equal tooltip_out.content_to_html, "<p>German text</p>"
    assert_equal tooltip_out.title, "foo"
    assert_equal tooltip_out.locale, "de"
  end

end
