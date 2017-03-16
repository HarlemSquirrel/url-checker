# frozen_string_literal: true
RSpec.describe UrlChecker::Cli do
  let(:file_path) { 'spec/fixtures/test.csv' }
  let(:url_checker) { described_class.new file_path: file_path }

  describe '.new' do
    it 'sets :file_path' do
      expect(url_checker.file_path).to eq file_path
    end
  end

  describe '.call' do
    let(:bad_call_msg) { /#{described_class::BAD_CALL_MSG}/ }
    let(:url_checker) do
      instance_double described_class, call: nil, file_path: file_path
    end

    before do
      allow(described_class).to receive(:new) { url_checker }
    end

    context 'with no runtime arguments' do
      before { allow(ARGV).to receive(:length) { 0 } }

      it { expect { described_class.call }.to output(bad_call_msg).to_stdout }
    end

    context 'with one runtime argument' do
      before do
        allow(ARGV).to receive(:length) { 1 }
        allow(ARGV).to receive(:first) { file_path }
        described_class.call
      end

      it 'creates a new instance and calls #call' do
        expect(url_checker).to have_received :call
      end
    end

    context 'with more than one runtime argument' do
      before { allow(ARGV).to receive(:length) { 2 } }

      it { expect { described_class.call }.to output(bad_call_msg).to_stdout }
    end
  end

  describe '#call' do
    context 'stdout' do
      let(:url_matcher_200) { %r{200 OK https://www.google.com} }
      let(:url_matcher_301) { %r{301 Moved Permanently http://google.com} }
      let(:url_matcher_404) { %r{404 Not Found http://google.com/cheese} }

      before do
        allow(url_checker).to receive(:write_results) { nil }
      end

      it 'displays OK for 200 URLs' do
        expect { url_checker.call }.to output(url_matcher_200).to_stdout
      end

      it 'displays moved for 301 URLs' do
        expect { url_checker.call }.to output(url_matcher_301).to_stdout
      end

      it 'displays Not Found for 404 URLs' do
        expect { url_checker.call }.to output(url_matcher_404).to_stdout
      end
    end

    context 'CSV output' do
      let(:expected_results_csv) { CSV.read('spec/fixtures/expected_test_results.csv') }
      let(:results_headers) { described_class::RESULTS_HEADERS }
      let(:results_file_path) { url_checker.results_file_path }
      let(:results_csv) { CSV.read results_file_path }

      before do
        allow(url_checker).to receive(:puts) { nil }
        url_checker.call
      end

      it 'sets results headers' do
        expect(url_checker.send(:results).first).to eq results_headers
      end

      it 'save the results CSV file' do
        expect(results_csv.sort).to eq expected_results_csv.sort
      end
    end
  end
end
