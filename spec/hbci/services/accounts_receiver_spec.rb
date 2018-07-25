# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Services::AccountsReceiver, type: :receiver do
  let!(:dialog_finish_request) { stub_dialog_finish_request(credentials, 2) }

  subject { Hbci::Services::AccountsReceiver.new(dialog) }

  let(:accounts) do
    [
      { account_number: '11111111', bank_code: '74090000' },
      { account_number: '22222222', bank_code: '74090000' },
      { account_number: '333333333', bank_code: '74090000' },
      { account_number: '444444444', bank_code: '74090000' },
      { account_number: '5555555555', bank_code: '74090000' },
      { account_number: '6666666666', bank_code: '74090000' },
      { account_number: '7777777777', bank_code: '74090000' }
    ]
  end

  it 'returns accounts' do
    expect(subject.perform).to eql(accounts)
  end
end
