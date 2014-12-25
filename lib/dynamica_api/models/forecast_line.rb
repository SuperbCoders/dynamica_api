module DynamicaAPI
  class ForecastLine < Base
    attr_accessor :forecast
    attr_accessor :item
    attr_accessor :values
    property :summary
  end
end
