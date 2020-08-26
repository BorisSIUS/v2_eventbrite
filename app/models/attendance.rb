class Attendance < ApplicationRecord
    after_create :notify_creater_send

    belongs_to :attendant, class_name: 'User'
    belongs_to :attended_event, class_name: 'Event'

    def notify_creater_send
        UserMailer.notify_creater(self).deliver_now
    end
    
  
end
