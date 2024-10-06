class CustomerSubscriptionsSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :email, :address

  attribute :subscriptions do |customer|
    customer.subscriptions.map do |subscription|
      {
        title: subscription.title,
        price: subscription.price,
        status: subscription.status,
        frequency: subscription.frequency
      }
    end
  end
end