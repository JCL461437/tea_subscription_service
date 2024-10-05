class Api::V1::SubscriptionsController < ApplicationController

  def create
    customer = Customer.find_by(email: params[:customer])
    tea = Tea.find_by(title: params[:tea])
    frequency = params[:frequency]
    title = "Subscription for #{tea.title} tea."

    unless customer && tea
      render json: { error: 'Customer or Tea not found' }, status: 404
      return
    end

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
      render json: { error: 'Subscription attempt failed, try re-entering your customer email and tea name' }, status: 422
    end
  end
end