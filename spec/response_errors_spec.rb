require 'spec_helper'

describe Braspag::ResponseErrors, focus: true do
  subject(:response_errors) { described_class.new(error_report_collection) }

  let(:error_report_collection) { Hash.new(error_report: { error_code: 300, error_message: 'Invalid credit card' }) }

  describe '#codes' do
    it 'collects error_code values from error report collection' do
      expect(response_errors.codes).to eq [error_report_collection[:error_report][:error_code]]
    end
  end

  describe '#messages' do
    it 'collects error_message values from error report collection' do
      expect(response_errors.messages).to eq [error_report_collection[:error_report][:error_message]]
    end
  end

  describe '#each' do
    it 'evaluates block within @base_errors' do
      block = lambda do
        1 + 1
      end

      expect(response_errors.instance_variable_get(:@base_errors)).to receive(:each).with(&block)
      response_errors.each(&block)
    end
  end

  describe 'size' do
    it 'returns @base_errors size' do
      base_errors = response_errors.instance_variable_get(:@base_errors)
      expect(response_errors).to receive(:size).and_return(base_errors.size)
      response_errors.size
    end
  end
end
