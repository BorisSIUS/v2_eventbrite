class ChargesController < ApplicationController
    before_action :authenticate_user!

        
    def new
        @price = Event.find(params[:event_id]).price
        @amount = @price * 100
    end

    def create
        # Amount in cents
        @price = Event.find(params[:event_id]).price
        
        @amount = @price * 100

        customer = Stripe::Customer.create({
            email: params[:stripeEmail],
            source: params[:stripeToken],
        })

        charge = Stripe::Charge.create({
            customer: customer.id,
            amount: @amount,
            description: 'Rails Stripe customer',
            currency: 'usd',
        })


        Attendance.create(attendant: current_user, attended_event: Event.find(params[:event_id]), stripe_customer_id: customer.id)

        redirect_to event_path(params[:event_id])  


        puts "BEFORE"*10
        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
        puts "AFTER"*10

    end
        
end