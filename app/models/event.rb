class Event < ActiveRecord::Base
  acts_as_gmappable
  
  belongs_to :user
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  has_many :translations, :dependent => :destroy
  has_attached_file :pic, :styles =>
            { :medium => "300x300>", :thumb => "100x100>"},
           # :storage => :s3,
            :bucket => ENV['S3_BUCKET_NAME']
          #  :s3_credentials => {
          #    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          #    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
           # },
          #  :path => "for/example/:id/:style.:extension",
          #  :url  => ":s3_eu_url"

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
