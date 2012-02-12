class User < ActiveRecord::Base
  attr_accessible :name, :town, :province, :website, :pic, :email, :password, :password_confirmation
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :within => 2..12
  
  serialize :events_created
  
  has_and_belongs_to_many :events
  has_many :comments, :dependent => :destroy
  has_attached_file :pic, :styles =>
           { :medium => "300x300>", :thumb => "100x100>" }
  
   
   
   def self.authenticate(email, password)
       user = find_by_email(email)
       if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
         user
       else
         nil
       end
     end

     def encrypt_password
       if password.present?
         self.password_salt = BCrypt::Engine.generate_salt
         self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
       end
     end
end
