# frozen_string_literal: true

shared_context 'shared context for service' do
  let(:iban) { 'DE05740900000011111111' }
  let(:connector) { Hbci::Connector.new(iban) }
  let(:session) { Hbci::Services::Session.new(connector) }

  def response_sample(path)
    Hbci::Response.new(File.read(path).delete("\n").delete("\s"))
  end

  before do
    Hbci.configure do |config|
      config.product_name = 'TEST-PRODUCT-NAME'
      config.user_id = 'TEST-USER-ID'
      config.pin = 'TEST-PIN'
    end
  end
end
