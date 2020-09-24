class Login < ActiveRecord::Base
  belongs_to :user
  
  validates :name, message: 'Username/Password incorrect!'
  validates :passwword, message: 'Username/Password incorrect!' 

end
