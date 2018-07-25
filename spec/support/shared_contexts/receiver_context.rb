shared_context 'receiver' do
  let(:credentials) { build(:hbci_credentials) }

  let!(:dialog_init_request) { stub_dialog_init_request(credentials) }
  let!(:dialog_finish_request) { stub_dialog_finish_request(credentials, 3) }

  let(:dialog) { Hbci::Dialog.new }
  let(:iban) { Ibanizator.iban_from_string('DE05740900000011111111') }

  around do |example|
    Timecop.freeze { example.run }
  end

  before do
    connector = Hbci::Connector.instance
    connector.credentials = credentials
    connector.reset_message_number
  end

  before do
    allow_any_instance_of(Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  before do
    dialog.initiate
  end

  after do
    dialog.finish
  end
end
