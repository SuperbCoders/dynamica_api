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
    attr_accessor :item

    def create_value(options)
      value = DynamicaAPI::Value.new(options)
      value.item = self
      value.create
    end

    def create
      response = post("projects/#{item.project.id}/items/#{item.sku}/forecasts", create_params)
      if response.code == 201
        json = JSON.parse(response, symbolize_names: true)
        self.id = json[:forecast][:id]
        self
      else
        raise "Can't create forecast: #{response.body}"
      end
    end

    def predicted_values
      response = get("forecasts/#{id}/predicted_values")
      if response.code == 200
        json = JSON.parse(response, symbolize_names: true)
        puts json.inspect
        json.map do |data|
          pv = PredictedValue.new(data)
          pv.forecast = self
          pv
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
