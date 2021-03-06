module Braspag
  CAPTURE_TRANSACTION_SUCCESS_STATUS = "0"
  VOID_TRANSACTION_SUCCESS_STATUS = "0"
  AUTHORIZE_TRANSACTION_SUCCESS_STATUS = ["0", "1"]

  class ResponseHandler
    def authorize_transaction(response)
      data = response.body[:authorize_transaction_response][:authorize_transaction_result]

      if data[:success]
        payment_data_response = data[:payment_data_collection][:payment_data_response]
        status =  payment_data_response[:status]

        if AUTHORIZE_TRANSACTION_SUCCESS_STATUS.include? status
          respond_with_success(payment_data_response.merge(data[:order_data]))
        else
          respond_with_failure(data)
        end

      else
        respond_with_failure(data)
      end
    end

    def capture_transaction(response)
      data = response.body[:capture_credit_card_transaction_response][:capture_credit_card_transaction_result]

      if data[:success]
        data_collection = data[:transaction_data_collection][:transaction_data_response]

        if data_collection[:status] == CAPTURE_TRANSACTION_SUCCESS_STATUS
          respond_with_success(data_collection)
        else
          respond_with_failure(data)
        end

      else
        respond_with_failure(data)
      end
    end

    def void_transaction(response)
      data = response.body[:void_credit_card_transaction_response][:void_credit_card_transaction_result]

      if data[:success]
        data_collection = data[:transaction_data_collection][:transaction_data_response]

        if data_collection[:status] == VOID_TRANSACTION_SUCCESS_STATUS
          respond_with_success(data_collection)
        else
          respond_with_failure(data_collection)
        end

      else
        respond_with_failure_transaction(data)
      end
    end

    def get_credit_card(response)
      data = response.body[:get_credit_card_response][:get_credit_card_result]
      credit_card_response_for(data)
    end

    def save_credit_card(response)
      data = response.body[:save_credit_card_response][:save_credit_card_result]
      credit_card_response_for(data)
    end

    def handle_error(response)
      OpenStruct.new(:success? => false, :data => response)
    end

    private

    def respond_with_failure_transaction(data)
      error_report = data[:error_report_data_collection][:error_report_data_response]
      respond_with_failure({:return_code => error_report[:error_code], :return_message => error_report[:error_message]})
    end

    def credit_card_response_for(soap_response)
      Braspag::Response.new(data: soap_response)
    end

    def respond_with_success(data)
      OpenStruct.new(:success? => true, :data => data)
    end

    def respond_with_failure(data)
      data_response = data.fetch(:error_report_data_collection){{}}[:error_report_data_response]

      OpenStruct.new(:success? => false,
                     :error_code => data_response[:error_code],
                     :error_message => data_response[:error_message],
                     :error_data => data)
    end
  end
end
