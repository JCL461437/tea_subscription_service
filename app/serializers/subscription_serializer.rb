class SubscriptionSerializer
  include JSONAPI::Serializer
  def self.new_subscription(tea, customer, subscription)
    {
      "data": {
        "id": subscription.id,
        "type": "subscription",
        "attributes": {
          "tea_information": {
            "name": tea.title,
            "description": tea.description,
            "temperature": tea.temperature,
            "brew_time": tea.brew_time
          }, 
          "customer_information": {
            "first_name": customer.first_name,
            "last_name": customer.last_name,
            "email": customer.email, 
            "address": customer.address 
          },
          "subscription_information": {
            "title": subscription.title,
            "price": subscription.price,
            "status": subscription.status, 
            "frequency": subscription.frequency 
        }
      }
    }
  }  

end