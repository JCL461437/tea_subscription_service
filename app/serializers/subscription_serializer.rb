class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title, :price, :status, :frequency

  attribute :tea_information do |subscription|
    {
      name: subscription.tea.title,
      description: subscription.tea.description,
      temperature: subscription.tea.temperature,
      brew_time: subscription.tea.brew_time
    }
  end

  attribute :customer_information do |subscription|
    {
      first_name: subscription.customer.first_name,
      last_name: subscription.customer.last_name,
      email: subscription.customer.email,
      address: subscription.customer.address
    }
  end
end  
