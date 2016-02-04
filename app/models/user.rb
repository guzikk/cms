class User < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :first_name,
            :presence => {:in => true, :message=>"can't be blank"}

  validates :last_name,
            :presence => {:in => true, :message=>"can't be blank"}

  validates :login,
            :length => {:within => 4..25, :message => "length od login has to be between 4..25 characters"},
            :uniqueness => true

  validates :email,
            :presence => true,
            :length => {:maximum=>100},
            :format => {:with => EMAIL_REGEX, :message => "wrong format"},
            :confirmation => true

  scope :sort, lambda{order("last_name ASC, first_name ASC")}

end
