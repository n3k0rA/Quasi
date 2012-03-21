class Event < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  has_attached_file :pic, :styles =>
            { :medium => "300x300>", :thumb => "100x100>"}
  
  
  
  validates :title, :description, presence: true
  
  #validates :pic, allow_blank: true, format: {
  #    with: %r{\.(gif|jpg|png|jpeg)$}i,
  #    message: 'must be a URL for GIF, JPG or PNG image.'
  #}  
end
