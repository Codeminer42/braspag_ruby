module Braspag
  class Transaction
    attr_accessor :response_handler, :transaction_param_builder

    def initialize(response_handler = ResponseHandler.new)
      @response_handler = response_handler
    end

    def self.authorize(params)
      Braspag::Transaction.new.authorize(params)
    end

    def self.capture(params)
      Braspag::Transaction.new.capture(params)
    end

    def self.cancel(params)
      Braspag::Transaction.new.cancel(params)
    end

    def authorize(params)
      AuthorizeTransactionRequest.new(params).call
    end

    def capture(params)
      CaptureTransactionRequest.new(params).call
    end

    def cancel(params)
      request = Request.new(Braspag.transaction_wsdl, :void_credit_card_transaction, build_capture_credit_card_params(params)) do |request|
        request.on_success {|response| response_handler.void_transaction(response) }
        request.on_failure {|response| response_handler.handle_error(response) }
      end

      request.call
    end
  end
end
