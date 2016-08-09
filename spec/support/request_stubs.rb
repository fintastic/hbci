def stub_dialog_init_request(credentials)
  stub_request(:post, credentials.url)
  .with(body: Base64.encode64(stub_dialog_init_request_message(credentials)))
  .to_return(status: 200, body: Base64.encode64(stub_dialog_init_response_message(credentials)))
end

def stub_transaction_v6_request(credentials, account_number, start_date, end_date)
  stub_request(:post, credentials.url)
  .with(body: Base64.encode64(stub_transactions_v6_request_message(credentials, account_number: account_number, start_date: start_date, end_date: end_date)))
  .to_return(status: 200, body: Base64.encode64(stub_transactions_response_message(credentials, account_number: account_number)))
end

def stub_transaction_v7_request(credentials, account_number, start_date, end_date)
  stub_request(:post, credentials.url)
  .with(body: Base64.encode64(stub_transactions_v7_request_message(credentials, account_number: account_number, start_date: start_date, end_date: end_date)))
  .to_return(status: 200, body: Base64.encode64(stub_transactions_response_message(credentials, account_number: account_number)))
end

def stub_paginated_transaction_v7_request(credentials, account_number, start_date, end_date, request_attachment_id, next_attachment_id, message_number)
  stub_request(:post, credentials.url)
  .with(body: Base64.encode64(stub_transactions_v7_request_message(credentials, account_number: account_number, start_date: start_date, end_date: end_date, attachment_id: request_attachment_id, message_number: message_number)))
  .to_return(status: 200, body: Base64.encode64(stub_transactions_response_message(credentials, account_number: account_number, attachment_id: next_attachment_id)))
end

def stub_balance_request(credentials, account_number)
  stub_request(:post, credentials.url)
  .with(body: Base64.encode64(stub_balance_request_message(credentials, account_number: account_number)))
  .to_return(status: 200, body: Base64.encode64(stub_balance_response_message(credentials, account_number: account_number)))
end
