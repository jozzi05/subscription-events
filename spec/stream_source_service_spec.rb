require 'date'
require 'stream_source_service'

RSpec.describe StreamSourceService do
  subject(:prepared_stream) { described_class.new(input).prepare.provide }

  describe 'with empty input' do
    let(:input) { [] }

    it 'returns empty array' do
      expect(prepared_stream).to eq []
    end
  end

  describe 'with input containing event with date as a string' do
    let(:input) { [{ "event": "reactivation", "account": "C001", "date": "2020-05-17" }] }

    it 'returns stream with events containing parsed date field' do
      expect(prepared_stream).to eq [
        { "event": "reactivation", "account": "C001", "date": Date.parse("2020-05-17") }
      ]
    end
  end
end