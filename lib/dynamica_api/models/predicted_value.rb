module DynamicaAPI
  class PredictedValue < Base
    property :from
    property :to
    property :value
    property :predicted
    attr_accessor :forecast_line
  end
end
