class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :email
  validates_presence_of :name
  has_and_belongs_to_many :events
  has_many :created_events, :class_name => "Event", :foreign_key => "user_id"
  has_many :comments, :dependent => :destroy
  
  has_attached_file :photo, :styles => 
     { :medium => "300x300>", :thumb => "100x100>"},
      :storage => Rails.env.production? ? :s3 : :filesystem,
      :s3_credentials => {
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      },
      :path => ":attachment/:id/:style.:extension",
      :bucket => ENV['S3_BUCKET_NAME']
    #{ :medium => "300x300>", :thumb => "100x100>" }
    #,
    #:storage => Rails.env.production? ? :s3 : :filesystem,
    #:s3_credentials => { :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']},
    #:s3_protocol => "https",
    #:path => ":class/:id/:basename_:style.:extension",
    #:path => ":attachment/:id/:style.:extension",
    #:bucket => ENV['S3_BUCKET_NAME']
    #:url  => ":s3_eu_url"
  
  has_many :followings, :dependent => :destroy
  has_many :followeds, :through => :followings, :dependent => :destroy
  has_many :communications
  has_many :receivers, :through => :communications
  has_many :translations, :dependent => :destroy
  has_many :alarms, :dependent => :destroy
  has_many :microposts, :dependent => :destroy
   
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    AccountNotifier.password_reset_instructions(self).deliver
  end
end
