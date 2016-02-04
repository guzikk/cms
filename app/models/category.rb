class Category < ActiveRecord::Base

  has_many :pages

  scope :visible, lambda{where(:visible => true)}
  scope :invisible, lambda{where(:visible => false)}
  scope :sort, lambda{order("categories.position ASC")}
  scope :sort_new_category, lambda{order("categories.created_at DESC")}
end
