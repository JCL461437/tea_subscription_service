class Api::V1::SubscriptionsController < ApplicationController

  def create
    customer = Customer.where(email: params[:customer])
    tea = Tea.where(title: params[:tea])
    frequency = params[:frequency]
    title = "Subscription for #{tea} tea."

    subscription = Subscription.create(
      customer: customer,
      tea: tea,
      title: title,
      price: 2.0,
      frequency: frequency
      )

    if subscription.save
      render json: SubscriptionSerializer.new.new_subscription(customer, tea, subscription), status: 200
    else 
      render json: {error: 'Subscription attempt failed, try re-entering your customer email and tea name'}, status: 422
    end
  end
end