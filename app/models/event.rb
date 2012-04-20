class Event < ActiveRecord::Base
  acts_as_gmappable :check_process => false, :checker => "gmaps"
  
  belongs_to :user
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  has_many :translations, :dependent => :destroy
  has_attached_file :pic, :styles =>
            { :medium => "300x300>", :thumb => "100x100>"},
            :storage => Rails.env.production? ? :s3 : :filesystem,
            :s3_credentials => {
              :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
              :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
            },
            :path => ":attachment/:id/:style.:extension",
            :bucket => ENV['S3_BUCKET_NAME'],
            :default_url => "/images/default_:style_pic.png"
          #  :path => "for/example/:id/:style.:extension",
          #  :url  => ":s3_eu_url"

  validates_datetime :finish_date, :after => :start_date
  validates_datetime :finish_date, :on_or_after => lambda { Date.current }
  validates :town, presence: true
  validate :the_event_must_have_at_least_one_description
  scope :start_between, lambda{|from, to| where ["start_date BETWEEN ? and ?", from.to_date - 1, to.to_date + 1] }
  
  self.per_page = 5
  
  # Sets Google maps coordenates
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.town}, #{self.province}"
  end
  
  #Sets the values for the Province select field
  PROVINCES = ["alaba", "biscay", "guipuzkoa", "navarre", "labourd", "b_navarre", "soule"]
  
  #validates the presence of at least one title and description
  def the_event_must_have_at_least_one_description
    if des_es.empty? && des_eu.empty? && des_en.empty? && des_fr.empty?
      errors.add(:des_es, "Please fill in the desciption at least in one language")
    end
    if title_es.empty? && title_eu.empty? && title_en.empty? && title_fr.empty?
      errors.add(:des_es, "Please fill in the desciption at least in one language")
    end
  end
  
  # Look for events that need to send reminders to those interested
  def self.remind_users
    @events = Event.all
    @events.each do |event|
      if (!event.reminded  && ((event.start_date-Time.now)< 259146.01469397545))
        EventNotifier.reminder(event).deliver
      end
    end
  end
  
  
  
  #validates :pic, allow_blank: true, format: {
  #    with: %r{\.(gif|jpg|png|jpeg)$}i,
  #    message: 'must be a URL for GIF, JPG or PNG image.'
  #}  
end
