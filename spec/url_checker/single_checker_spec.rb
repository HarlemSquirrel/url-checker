# frozen_string_literal: true

RSpec.describe UrlChecker::SingleChecker do
  let(:url_checker) { described_class.new url: url }

  shared_context 'response and message' do
    it { expect(url_checker.call.code).to eq code }
    it { expect(url_checker.call.message).to match message }
  end

  describe '#call' do
    context 'with an OK url' do
      let(:code) { '200' }
      let(:message) { 'OK' }
      let(:url) { 'https://www.google.com' }

      include_context 'response and message'
    end

    context 'with a moved permanently url' do
      let(:code) { '301' }
      let(:message) { 'Moved Permanently' }
      let(:url) { 'https://google.com' }

      include_context 'response and message'
    end

    context 'with a not found url' do
      let(:code) { '404' }
      let(:message) { 'Not Found' }
      let(:url) { 'https://google.com/asdf' }

      include_context 'response and message'
    end

    context 'when the connection is refused' do
      let(:code) { 'Connection refused' }
      let(:message) do
        'Failed to open TCP connection to 000'
      end
      let(:url) { 'http://000' }

      include_context 'response and message'
    end

    context 'with a URL that does not start with http' do
      let(:code) { 'Invalid URL' }
      let(:message) { described_class::INVALID_URI_MSG }
      let(:url) { '1234' }

      include_context 'response and message'
    end

    context 'with an invalid URL that contains spaces' do
      let(:code) { 'Invalid URL' }
      let(:message) { described_class::INVALID_URI_MSG }
      let(:url) { 'https://Example .com' }

      include_context 'response and message'
    end

    context 'with an invalid url argument' do
      let(:code) { 'Invalid argument' }
      let(:message) do
        'Failed to open TCP connection to 1234:80 '\
        '(Invalid argument - connect(2) for "1234" port 80)'
      end
      let(:url) { 'http://1234' }

      include_context 'response and message'
    end

    context 'with a socket error from the url' do
      let(:code) { 'SocketError' }
      let(:message) do
        'Failed to open TCP connection to 123.td:80 (getaddrinfo: Name or service not known)'
      end
      let(:url) { 'http://123.td' }

      include_context 'response and message'
    end
  end
end
