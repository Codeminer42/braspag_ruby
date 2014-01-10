$:.push File.expand_path("../lib", __FILE__)

require "savon"
require "securerandom"
require "logger"

module Braspag
  TRANSACTION_WSDL = {
    :homologation => "https://homologacao.pagador.com.br/webservice/pagadorTransaction.asmx?wsdl",
    :production => "https://pagador.com.br/webservice/pagadorTransaction.asmx?wsdl"
  }

  CREDIT_CARD_WSDL = {
    :homologation => "https://homologacao.braspag.com.br/services/testenvironment/CartaoProtegido.asmx?wsdl",
    :production => "https://cartaoprotegido.braspag.com.br/Services/V2/CartaoProtegido.asmx?wsdl"
  }

  class << self
    attr_accessor :merchant_id, :merchant_key, :logging, :production, :payment_data_request_xml_builder

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

  def self.root
    Pathname.new File.expand_path('../..', __FILE__)
  end

  def self.configure
    yield self
  end
end

Dir[Braspag.root.join('lib/braspag/**/*.rb')].each { |f| require f }

Braspag.configure do |config|
  config.production = false
  config.logging    = false
  config.payment_data_request_xml_builder = Braspag::PaymentDataRequestXML
end
