# frozen_string_literal: true

RSpec.describe UrlChecker::RecuedResponse do
  let(:subject) { described_class.new code: '123', message: 'hi', uri: uri }
  let(:uri) { Addressable::URI.parse 'http://yahoo.com' }

  it { is_expected.to respond_to :code }
  it { is_expected.to respond_to :message }
  it { is_expected.to respond_to :uri }
end
