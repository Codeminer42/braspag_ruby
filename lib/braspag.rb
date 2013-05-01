$:.push File.expand_path("../lib", __FILE__)

require "braspag/version"
require "savon"
require "securerandom"
require "logger"
require "braspag/savon_adapter"
require "braspag/response_handler"
require "braspag/request"
require "braspag/payment_data_request_xml"
require "braspag/transaction_param_builder"
require "braspag/transaction"
require "braspag/credit_card"

module Braspag
  TRANSACTION_WSDL = { 
    :homologation => "https://homologacao.pagador.com.br/webservice/pagadorTransaction.asmx?wsdl",
    :production => ""
  }

  CREDIT_CARD_WSDL = { 
    :homologation => "https://homologacao.braspag.com.br/services/testenvironment/CartaoProtegido.asmx?wsdl",
    :production => ""
  }

  class << self
    attr_accessor :merchant_id, :merchant_key, :logger, :production, :payment_data_request_xml_builder

    def credit_card_wsdl
      production? ? CREDIT_CARD_WSDL[:production] : CREDIT_CARD_WSDL[:homologation]
    end

    def transaction_wsdl
      production? ? TRANSACTION_WSDL[:production] : TRANSACTION_WSDL[:homologation]
    end

    def production?
      production
    end
  end

  def self.configure
    yield self
  end

end

Braspag.configure do |config|
  config.production = false
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::ERROR
  config.payment_data_request_xml_builder = Braspag::PaymentDataRequestXML
end