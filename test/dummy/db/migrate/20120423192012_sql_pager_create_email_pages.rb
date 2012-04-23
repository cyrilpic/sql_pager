class SqlPagerCreateEmailPages < ActiveRecord::Migration
  def change
    create_table :email_pages do |t|
      t.text :body
      t.string :path
      t.string :format
      t.string :locale
      t.string :handler
      t.boolean :partial, default: false
      # To add filtering capabilities
      # t.string :keyword
      t.timestamps
    end
  end
end
