class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :email
  validates_presence_of :name
  
  has_and_belongs_to_many :events
  has_many :created_events, :class_name => "Event", :foreign_key => "user_id"
  has_many :comments, :dependent => :destroy
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
end
