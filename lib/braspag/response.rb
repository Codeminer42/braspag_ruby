module Braspag
  class Response
    attr_reader :data, :errors

    def initialize(options)
      @data   = options[:data] || {}
      @errors = Braspag::ResponseErrors.new(options[:errors] || data[:error_report_collection])
    end

    def success?
      data[:success]
    end

    def error_code
      warn '[deprecated] response.error_code will be removed. Use response.errors instead'
      errors.first[:error_code]
    end

    def error_message
      warn '[deprecated] response.error_message will be removed. Use response.errors instead'
      errors.first[:error_message]
    end
  end
end
