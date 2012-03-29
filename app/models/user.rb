class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :email
  validates_presence_of :name
  has_and_belongs_to_many :events
  has_many :created_events, :class_name => "Event", :foreign_key => "user_id"
  has_many :comments, :dependent => :destroy
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" },
   # :storage => :s3,
  #  :s3_credentials => {
  #    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
   #   :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  #  },
  #  :s3_protocol => "https",
  #  :path => ":class/:id/:basename_:style.:extension",
    :bucket => ENV['S3_BUCKET_NAME']
  #  :url  => ":s3_eu_url"
  has_many :followings
  has_many :followeds, :through => :followings
  has_many :communications
  has_many :receivers, :through => :communications
  has_many :translations
  
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    AccountNotifier.password_reset_instructions(self).deliver
  end
end
