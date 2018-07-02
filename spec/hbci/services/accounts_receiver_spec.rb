# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Services::AccountsReceiver do
  let(:credentials) { build(:hbci_credentials) }
  let!(:dialog_init_request) { stub_dialog_init_request(credentials) }
  let!(:dialog_finish_request) { stub_dialog_finish_request(credentials, 2) }
  let(:dialog) { Hbci::Dialog.new(credentials) }

  before do
    Timecop.freeze
    allow(Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  before do
    dialog.initiate
  end

  after do
    dialog.finish
  end

  subject { Hbci::Services::AccountsReceiver.new(dialog) }

  it 'requests and returns the balance' do
    expect(subject.perform).to eql([
                                     { account_number: '11111111', bank_code: '74090000' },
                                     { account_number: '22222222', bank_code: '74090000' },
                                     { account_number: '333333333', bank_code: '74090000' },
                                     { account_number: '444444444', bank_code: '74090000' },
                                     { account_number: '5555555555', bank_code: '74090000' },
                                     { account_number: '6666666666', bank_code: '74090000' },
                                     { account_number: '7777777777', bank_code: '74090000' }
                                   ])
  end
end
