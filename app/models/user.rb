class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    after_create :welcome_send
    after_create :default_avatar

    has_one_attached :avatar

    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :administrated_events, foreign_key: 'administrator_id', class_name:"Event" 
  
    has_many :attendances, foreign_key: :attendant_id
    has_many :attended_events, through: :attendances, source: :attended_event
  
    #validates :first_name,
    #presence: true

    #validates :last_name,
    #presence: true

    #validates :description,
    #presence: true,
    #length: { maximum: 500 }

    validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }


    def welcome_send
        UserMailer.welcome_email(self).deliver_now
    end

    def default_avatar
      self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.png')), filename: 'default_avatar.png', content_type: 'image/png')
    end

end