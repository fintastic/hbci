# frozen_string_literal: true

def stub_session_init_request(credentials)
  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_session_init_request_message))
    .to_return(status: 200, body: Base64.encode64(stub_session_init_response_message))
end

def stub_dialog_init_request(credentials)
  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_dialog_init_request_message))
    .to_return(status: 200, body: Base64.encode64(stub_dialog_init_response_message))
end

def stub_dialog_finish_request(credentials)
  stub_request(:post, credentials.url)
    .with(body: Base64.encode64(stub_dialog_finish_request_message))
end
