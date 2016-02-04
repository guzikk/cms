class Photo < ActiveRecord::Base
  belongs_to :gallery

  has_attached_file :photo, :styles => { :medium => "600x600>", :thumb => "200x200>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/(png|jpeg|jpg|gif)/,
                                    :message => 'They are accepted only jpg, gif, jpeg, png files'

  validates_attachment_size :photo,
                            :in => 0..1000.kilobytes,
                            :message => 'size is to big, max size 1000Kb'

  validates :name,
            :presence => true,
            :length => {:maximum=>30, :message => " : name of Photo is too long"}

  scope :visible, lambda{where(:visible => true)}
  scope :invisible, lambda{where(:visible => false)}
  scope :sort, lambda{order("photos.position ASC")}
  scope :sort_new_photos, lambda{order("photos.created_at DESC")}
end
