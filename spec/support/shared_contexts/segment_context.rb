shared_context 'segment' do
  let(:credentials) { build(:hbci_credentials) }
  let(:dialog) { Hbci::Dialog.new }
  let(:message) { Hbci::Message.new(dialog) }
  let(:iban) { Ibanizator.iban_from_string('DE05740900000011111111') }

  around do |example|
    Timecop.freeze(Time.parse('01.01.2018')) { example.run }
  end

  before do
    allow_any_instance_of(Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  before do
    connector = Hbci::Connector.instance
    connector.credentials = credentials
    connector.reset_message_number
  end

  before do
    subject.build(message)
  end

  before do |example|
    if example.metadata[:example_group][:description_args].include?('#compile')
      subject.head.position = 1
      subject.compile
    end
  end
end
