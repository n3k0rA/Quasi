class Communication < ActiveRecord::Base
  belongs_to :user
  belongs_to :receiver, :class_name => "User"
end
