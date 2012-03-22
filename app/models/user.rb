class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :email
  validates_presence_of :name
  
  has_and_belongs_to_many :events
  has_many :created_events, :class_name => "Event", :foreign_key => "user_id"
  has_many :comments, :dependent => :destroy
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :followings
  has_many :followeds, :through => :followings
  has_many :communications
  has_many :receivers, :through => :communications
  
end
