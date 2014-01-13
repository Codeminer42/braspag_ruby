module Braspag
  class CaptureTransactionRequest < Request
    def initialize(params)
      @soap_adapter = SavonAdapter
      @wsdl_url = Braspag.transaction_wsdl
      @action = :capture_credit_card_transaction
      @params = filter_params(params)

      @success_callback = Proc.new do |response|
        response_handler.capture_transaction(response)
      end

      @failure_callback = Proc.new do |response|
        response_handler.handle_error(response)
      end
    end

    private

    def filter_params(params)
      TransactionParamBuilder.new(params).capture
    end
  end
end
