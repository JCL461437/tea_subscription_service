class Api::V1::SubscriptionsController < ApplicationController

  def create
    customer = Customer.find_by(email: params[:customer])
    tea = Tea.find_by(title: params[:tea])
    frequency = params[:frequency]
    
    if customer.blank? || tea.blank? || frequency.blank? 
      render json: { error: 'Subscription attempt failed, try re-entering your customer email and tea name' }, status: 404
      return
    end
    
    title = "Subscription for #{tea.title} tea."

    subscription = Subscription.new(
      customer: customer,
      tea: tea,
      title: title,
      price: 2.0,
      frequency: frequency,
      status: "active"  
    )

    if subscription.save
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: { error: 'Subscription attempt failed, try re-entering your customer email or tea name' }, status: 422
    end
  end

  def update
    begin
      subscription = Subscription.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Attempt to unsubscribe failed, try entering a valid subscription id' }, status: 404
      return
    end

    subscription.cancel

    render json: SubscriptionSerializer.new(subscription)
  end

  def index

  end
end