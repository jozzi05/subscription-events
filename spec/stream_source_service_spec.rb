require 'stream_source_service'

RSpec.describe StreamSourceService do
  subject(:prepared_stream) { described_class.new(input).prepare.provide }

  describe 'with empty input' do
    let(:input) { [] }

    it 'returns empty array' do
      expect(prepared_stream).to eq []
    end
  end
end