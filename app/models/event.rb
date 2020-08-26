class Event < ApplicationRecord

    has_many :attendances, foreign_key: :attended_event_id
    has_many :attendants, through: :attendances, source: :attendant 
  
    belongs_to :administrator, class_name: 'User'
    has_one_attached :scene

    validates :start_date, 
    presence: true,
    if: :is_futur

    validates :scene,
    presence: true
    
    def is_futur
        start_date.to_i > Time.now.to_i
    end

    validates :duration,
    presence: true,
    numericality: { greater_than: 0 },
    if: Proc.new { |x| x.duration % 5 == 0 }

    validates :title,
    presence: true,
    length: { in: 5..140 }

    validates :description,
    presence: true,
    length: { in: 20..1000 }
    
    validates :price,
    presence: true,
    if: :price_fork

    def price_fork
        price <= 10000 && price >= 1
    end

    validates :location,
    presence: true

    def is_admin?(user)
        user == self.administrator || user.web_master
    end

    def is_attending?(user)
        self.attendants.any? { | attendants | attendants == user }
    end


    def is_free?
        self.price == 0
    end
end
