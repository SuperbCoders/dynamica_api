module DynamicaAPI
  class Item < Base
    property :sku
    property :name
    attr_accessor :project

    def create_value(options)
      value = DynamicaAPI::Value.new(options)
      value.item = self
      value.create
    end

    def create_forecast(options)
      forecast = DynamicaAPI::Forecast.new(options)
      forecast.item = self
      forecast.create
    end

    def destroy_values
      response = delete("projects/#{project.id}/items/#{sku}/values")
      if response.code == 204
        true
      else
        raise "Can't destroy values: #{response.body}"
      end
    end

  end
end
