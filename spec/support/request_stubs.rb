def stub_dialog_init_request(credentials)
  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_dialog_init_request_message(credentials)))
    .to_return(status: 200, body: Base64.encode64(stub_dialog_init_response_message(credentials)))
end

def stub_dialog_finish_request(credentials, message_number = 3)
  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_dialog_finish_request_message(credentials, message_number: message_number)))
    .to_return(status: 200, body: Base64.encode64(stub_dialog_finish_response_message(credentials, message_number: message_number)))
end

def stub_transaction_v6_request(credentials, iban, start_date, end_date)
  iban = Ibanizator.iban_from_string(iban)

  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_transactions_v6_request_message(credentials, iban: iban, start_date: start_date, end_date: end_date)))
    .to_return(status: 200, body: Base64.encode64(stub_transactions_response_message(credentials, account_number: iban.extended_data.account_number)))
end

def stub_transaction_v7_request(credentials, iban, start_date, end_date)
  iban = Ibanizator.iban_from_string(iban)

  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_transactions_v7_request_message(credentials, iban: iban, start_date: start_date, end_date: end_date)))
    .to_return(status: 200, body: Base64.encode64(stub_transactions_response_message(credentials, account_number: iban.extended_data.account_number)))
end

def stub_paginated_transaction_v7_request(credentials, iban, start_date, end_date, request_attachment_id, next_attachment_id, message_number)
  iban = Ibanizator.iban_from_string(iban)

  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_transactions_v7_request_message(credentials, iban: iban, start_date: start_date, end_date: end_date, attachment_id: request_attachment_id, message_number: message_number)))
    .to_return(status: 200, body: Base64.encode64(stub_transactions_response_message(credentials, account_number: iban.extended_data.account_number, attachment_id: next_attachment_id)))
end

def stub_balance_v4_request(credentials, iban)
  iban = Ibanizator.iban_from_string(iban)

  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_balance_v4_request_message(credentials, iban: iban)))
    .to_return(status: 200, body: Base64.encode64(stub_balance_response_message(credentials, account_number: iban.extended_data.account_number)))
end

def stub_balance_v7_request(credentials, iban)
  iban = Ibanizator.iban_from_string(iban)

  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_balance_v7_request_message(credentials, iban: iban)))
    .to_return(status: 200, body: Base64.encode64(stub_balance_response_message(credentials, account_number: iban.extended_data.account_number)))
end
