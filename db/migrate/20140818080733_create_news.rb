class CreateNews < ActiveRecord::Migration
  def change
    create_table :news, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.belongs_to :cce_class, index: true
      t.belongs_to :user, index: true      
      t.string :title
      t.string :link      
      t.text :content
      t.integer :view, default: 0
      t.attachment :cover
      t.attachment :DM      
      t.boolean :verified, default: false
      t.integer :verified_user_id    
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
