module DynamicaAPI
  class Project < Base
    property :id
    property :name

    def create_values(options)
      item = DynamicaAPI::Item.new(options[:item])
      item.project = self
      item.create_values(options[:values])
    end

    def create_forecast(options)
      item = DynamicaAPI::Item.new(options[:item])
      item.project = self
      item.create_forecast(options[:forecast])
    end

  end
end
