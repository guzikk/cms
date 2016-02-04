class Gallery < ActiveRecord::Base
  has_many :photos

  has_attached_file :photo, :styles => { :medium => "600x600>", :thumb => "200x200>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/(png|jpeg|jpg|gif)/,
                                    :message => 'They are accepted only jpg, gif, jpeg, png files'

  validates_attachment_size :photo,
                            :in => 0..1000.kilobytes,
                            :message => 'size is to big, max size 1000Kb'

  validates :name,
            :presence => true,
            :length => {:maximum=>30, :message => " : name of Gallery is too long"}

  scope :visible, lambda{where(:visible => true)}
  scope :invisible, lambda{where(:visible => false)}
  scope :sort, lambda{order("galleries.position ASC")}
  scope :sort_new_galleries, lambda{order("galleries.created_at DESC")}
end
