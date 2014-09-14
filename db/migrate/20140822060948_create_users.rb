class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :email, uniqueness: true 
      t.integer :extend
      t.boolean :gender, default: true
      t.string :education
      t.string :id_no, uniqueness: true 
      t.string :passport_no
      t.string :nationality
      t.date :birthday
      t.string :address
      t.string :phone_no
      t.string :mobile_no
      t.string :hashed_pw
      t.string :salt
      t.integer :identity
      t.string :verify_code
      t.boolean :verified, default: false
      
      t.timestamps
    end
  end
end
