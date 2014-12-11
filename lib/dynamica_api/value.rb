module DynamicaAPI
  class Value < Base
    property :timestamp, transform_with: -> (time) { Time.parse(time.to_s) }
    property :value
    attr_accessor :item

    def create
      response = post("projects/#{item.project.id}/values", create_params)
      if response.code == 201
        self
      else
        raise "Can't create value: #{response.body}"
      end
    end

    private

      def create_params
        { value: { timestamp: timestamp, value: value },
          item: { sku: item.sku, name: item.name } }
      end

  end
end
