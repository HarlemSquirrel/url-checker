# frozen_string_literal: true

module UrlChecker
  # The main class
  class Cli
    BAD_CALL_MSG = "Please call with one CSV file with URLs in the first column\n"
    RESULTS_HEADERS = %w(Response URL).freeze

    attr_reader :file_path, :results_file_path

    def initialize(file_path:)
      @file_path = file_path
    end

    def call
      @results = [RESULTS_HEADERS]
      @num_issues = 0
      display_summary Benchmark.measure { check_urls_from_csv }.real
      write_results
    end

    def self.call
      if ARGV.length == 1 && ARGV.first.match?(/\.csv\z/)
        url_checker = new(file_path: ARGV.first).call
      else
        print BAD_CALL_MSG.red
      end
      url_checker
    end

    private

    attr_accessor :num_issues, :results

    def check_url(url)
      response = UrlChecker::SingleChecker.new(url: url).call
      collect_result response
      display_result response
    end

    def check_url_thread(url)
      Thread.new { check_url(url) }
    end

    def check_urls_from_csv
      threads = []
      CSV.foreach(file_path) do |row|
        url = row[0]
        threads << check_url_thread(url) if url.is_a?(String) && url.match?(/\Ahttp/)
      end
      threads.each(&:join)
    end

    def collect_result(response)
      line = ["#{response.code} #{response.message}", response.uri.to_s]
      results << line
    end

    def display_result(response)
      msg = " #{response.code} #{response.message} #{response.uri}\n"
      case response
      when Net::HTTPSuccess, Net::HTTPRedirection
        print msg.green
      else
        @num_issues += 1
        print msg.red
      end
    end

    def display_summary(run_time)
      num_checked = results.length - 1
      msg = "  #{num_checked} URLs checked with #{num_issues} issue(s) in #{run_time.round 2} s.\n"
      num_issues.positive? ? print(msg.yellow) : print(msg.green)
    end

    def write_results
      time = Time.now.strftime('%Y-%m-%d-%H:%M:%S')
      @results_file_path = file_path.gsub('.csv', "_results_#{time}.csv")
      print "  Results saved to #{results_file_path}\n"
      CSV.open(results_file_path, 'wb') do |csv|
        results.each { |r| csv << r }
      end
      results_file_path
    end
  end
end
