RSpec.describe UrlChecker::RecuedResponse do
  let(:subject) { described_class.new code: '123', message: 'hi', uri: uri }
  let(:uri) { URI('http://yahoo.com') }

  it { is_expected.to respond_to :code }
  it { is_expected.to respond_to :message }
  it { is_expected.to respond_to :uri }

  context 'with an invalid uri type' do
    it 'raises a TypeError' do
      expect{ described_class.new code: '1', message: 'a', uri: 'bad' }.to raise_error TypeError
    end
  end
end
