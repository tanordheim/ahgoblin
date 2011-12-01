STATUS_MESSAGES = {
  200 => 'OK',
  404 => 'Not Found',
  500 => 'Internal Server Error'
}

# Register a FakeWeb request.
def register_fakeweb(method, uri, response_file, status_code = 200)
  file_path = File.join(Rails.root, 'spec', 'fixtures', response_file)
  FakeWeb.register_uri(method, uri, :body => File.open(file_path).read, :status => [status_code.to_s, STATUS_MESSAGES[status_code]])
end
