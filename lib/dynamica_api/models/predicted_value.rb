module DynamicaAPI
  class PredictedValue < Base
    property :timestamp
    property :value
    property :predicted
    attr_accessor :forecast
  end
end
