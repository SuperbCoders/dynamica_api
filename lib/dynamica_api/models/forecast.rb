module DynamicaAPI
  class Forecast < Base
    property :id
    property :period
    property :depth
    property :group_method
    property :from
    property :to
    property :workflow_state
    property :planned_at
    attr_accessor :project

    def create
      response = post("projects/#{project.id}/forecasts", create_params)
      if response.code == 201
        json = JSON.parse(response, symbolize_names: true)
        self.id = json[:forecast][:id]
        self
      else
        raise "Can't create forecast: #{response.body}"
      end
    end

    def lines
      response = get("forecasts/#{id}/predicted_values")
      if response.code == 200
        json = JSON.parse(response, symbolize_names: true)
        json.map do |data|
          forecast_line = ForecastLine.new
          forecast_line.forecast = self
          forecast_line.item = Item.new(data[:prediction][:item])
          forecast_line.values = data[:prediction][:predicted_values].map do |pv_data|
            pv = PredictedValue.new(pv_data)
            pv.forecast_line = forecast_line
            pv
          end
          forecast_line
        end
      else
        raise "Can't load predicted values: #{response.body}"
      end
    end

    private

      def create_params
        { forecast: { period: period, depth: depth, group_method: group_method, from: from, to: to, planned_at: planned_at } }
      end

  end
end
