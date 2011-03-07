# encoding: UTF-8

require 'rdiscount'
require 'RedCloth'

class Tooltip < ActiveRecord::Base

  attr_accessible :title, :content, :markup, :locale
    
  validates_presence_of   :title
  validates_presence_of   :content
  validates_presence_of   :markup
  
  validates_format_of :locale,
                      :with => /^[a-z][a-z]$/,
                      :message => 'must be in ISO-639-1 two letter format (e.g. en, de, zh)',
                      :allow_blank => true

  validates_inclusion_of  :markup,
                          :in => %w{ html markdown textile },
                          :message => 'must be one of html, markdown or textile'
                          
  validate :validate_no_script_tags

  validate :validate_unique_title_locale_combination, :on => :create


  # find the tooltip that matches the title and locale - locale is a string
  def self.from_title_and_locale(title, user_locale = I18n.locale.to_s)
    tooltip = nil
    tooltips = Tooltip.where(:title => title).all

    if tooltips.count == 1
      # there is only one, so use that
      tooltip = tooltips.first

    elsif tooltips.count > 1
      # Try and match by locale
      default_tooltip = nil
      tooltips.each do |tooltip_i|
        if tooltip_i.locale == user_locale
          tooltip = tooltip_i
          break
        elsif tooltip_i.locale.nil? or tooltip_i.locale == I18n.default_locale.to_s
          default_tooltip = tooltip_i
        end
      end
      tooltip = default_tooltip if tooltip.blank?
    end

    tooltip
  end


  # Process content with RDiscount if needed
  def content_to_html
    if self.markup == 'markdown'
      RDiscount.new(self.content, :autolink).to_html
    elsif self.markup == 'textile'
      RedCloth.new(self.content).to_html
    else
      self.content
    end
  end
  
  protected
  
  def validate_unique_title_locale_combination
    if Tooltip.where(:title => self.title).where(:locale => self.locale).count > 0
      errors.add(:title, 'and locale combination already exists')    
    end
  end
  
  def validate_no_script_tags
    if self.content =~ /\<\s*script/im
      errors.add(:content, 'must not contain <script> tags')
    end
  end
  
end
