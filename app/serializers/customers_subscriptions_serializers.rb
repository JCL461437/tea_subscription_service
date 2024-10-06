class CustomerSubscriptionsSerializer
  include JSONAPI::Serializer

  attributes :title, :price, :status, :frequency

  attribute :subscriptions do |subscription|
    {
      name: subscription.tea.title,
      description: subscription.tea.description,
      temperature: subscription.tea.temperature,
      brew_time: subscription.tea.brew_time
    }
  end
end