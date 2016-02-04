class Page < ActiveRecord::Base
  belongs_to :category
  has_many :articles

  scope :visible, lambda{where(:visible => true)}
  scope :invisible, lambda{where(:visible => false)}
  scope :sort, lambda{order("pages.position ASC")}
  scope :sort_new_page, lambda{order("pages.created_at DESC")}

end
