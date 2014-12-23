module DynamicaAPI
  class Project < Base
    property :id
    property :name

    def forecasts
      response = get("projects/#{id}/forecasts")
      if response.code == 200
        json = JSON.parse(response, symbolize_names: true)
        json.map do |forecast_json|
          forecast = Forecast.new(forecast_json[:forecast])
          forecast.project = self
          forecast
        end
      else
        raise "Can't load forecasts: #{response.body}"
      end
    end

    def create_forecast(options)
      forecast = DynamicaAPI::Forecast.new(options)
      forecast.project = self
      forecast.create
    end

    def create_values(options)
      item = DynamicaAPI::Item.new(options[:item])
      item.project = self
      item.create_values(options[:values])
    end

  end
end
