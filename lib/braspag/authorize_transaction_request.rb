require Braspag.root.join 'lib/braspag/response'
require Braspag.root.join 'lib/braspag/request'

module Braspag
  class AuthorizeTransactionRequest < Request
    def initialize(params)
      @soap_adapter = SavonAdapter
      @wsdl_url = Braspag.transaction_wsdl
      @action = :authorize_transaction
      @params = filter_params(params)

      @success_callback = Proc.new do |response|
        response_handler.authorize_transaction(response)
      end

      @failure_callback = Proc.new do |response|
        response_handler.handle_error(response)
      end
    end

    private

    def filter_params(params)
      TransactionParamBuilder.new(params).authorize
    end

    def response_handler
      @response_handler ||= ResponseHandler.new
    end
  end
end
