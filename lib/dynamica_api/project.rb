module DynamicaAPI
  class Project < Base
    property :id
    property :name

    def create_value(options)
      item = DynamicaAPI::Item.new(options[:item])
      item.project = self
      item.create_value(options[:value])
    end

    def create_forecast(options)
      item = DynamicaAPI::Item.new(options[:item])
      item.project = self
      item.create_forecast(options[:forecast])
    end

  end
end
