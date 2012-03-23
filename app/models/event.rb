class Event < ActiveRecord::Base
  acts_as_gmappable
  
  belongs_to :user
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  has_attached_file :pic, :styles =>
            { :medium => "300x300>", :thumb => "100x100>"}
  
  
  
  validates :title, :description, presence: true
  
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.place}, #{self.address}, #{self.town}, #{self.province}"
  end
  
  
  #validates :pic, allow_blank: true, format: {
  #    with: %r{\.(gif|jpg|png|jpeg)$}i,
  #    message: 'must be a URL for GIF, JPG or PNG image.'
  #}  
end
