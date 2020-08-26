class UserMailer < ApplicationMailer
    default from: 'balfoldi@yahoo.fr'
   
    def welcome_email(user)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = user 
  
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'http://monsite.fr/login' 
  
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: 'Bienvenue chez nous !') 
    end

    def promotion_up_email(event)
      @event = event
      @user = @event.administrator
      @url = 'http://monsite.fr/events/#{@event.id}'
      mail(to: @user.email, subject: 'Votre evennement a été promu par l\'équipe de modération')
    end

    def promotion_down_email(event)
      @event = event
      @user = @event.administrator
      @url = 'http://monsite.fr/events/#{@event.id}/attendance'
      mail(to: @user.email, subject: 'Votre evennement a été zapé par l\'équipe de modération')
    end

    def notify_creater(attendance)
    
      @attendant = attendance.attendant

      @event = attendance.attended_event

      @user = @event.administrator


      @url = 'http://monsite.fr/events/#{@event.id}/attendances' 

      mail(to: @user.email, subject: 'Quelqun s\'est inscrit à votre evenement !') 
      
    end
  end