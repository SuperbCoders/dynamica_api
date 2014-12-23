module DynamicaAPI
  class Item < Base
    property :sku
    property :name
    attr_accessor :project

    def create_values(options)
      response = post("projects/#{project.id}/values", create_values_params(options))
      if response.code == 201
        json = JSON.parse(response, symbolize_names: true)
        json.map do |value_json|
          value = Value.new(value_json[:value])
          value.item = self
          value
        end
      else
        raise "Can't create values: #{response.body}"
      end
    end

    def destroy_values
      response = delete("projects/#{project.id}/items/#{sku}/values")
      if response.code == 204
        true
      else
        raise "Can't destroy values: #{response.body}"
      end
    end

    private

      def create_values_params(options)
        { item: { sku: sku, name: name },
          values: value_params(options) }
      end

      def value_params(options)
        options.map do |value_options|
          { timestamp: value_options[:timestamp], value: value_options[:value] }
        end
      end

  end
end
