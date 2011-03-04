class CreateSimpleTooltips < ActiveRecord::Migration
  def self.up
    create_table :simple_tooltips do |t|
      t.string   :title
      t.text     :content
      t.string   :markup,     :default => "markdown"
      t.string   :locale
      t.timestamps
    end
  end

  def self.down
    drop_table :simple_tooltips
  end
end
