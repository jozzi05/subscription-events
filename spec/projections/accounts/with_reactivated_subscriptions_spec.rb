require 'projections/accounts/with_reactivated_subscriptions'

RSpec.describe Projections::Accounts::WithReactivatedSubscriptions do
  subject(:projection) { described_class.call(stream, snapshot) }
  let(:snapshot) { Set.new }

  describe 'with empty stream' do
    let(:stream) { [] }

    it 'returns empty array' do
      expect(projection).to eq []
    end
  end

  describe 'with one reactivation event' do
    let(:stream) { [{ "event": "reactivation", "account": "C001", "date": Date.parse("2020-05-17") }] }

    it 'returns found accounts' do
      expect(projection).to eq ["C001"]
    end
  end

  describe 'with one subscription event' do
    let(:stream) { [{ "event": "subscription", "account": "C001", "date": Date.parse("2020-05-17") }] }

    it 'returns empty array' do
      expect(projection).to eq []
    end
  end

  describe 'with multiple reactivation events for the same account' do
    let(:stream) do
      [
        { "event": "reactivation", "account": "C001", "date": Date.parse("2020-05-17") },
        { "event": "reactivation", "account": "C001", "date": Date.parse("2020-05-18") }
      ]
    end

    it 'returns found accounts only once' do
      expect(projection).to eq ["C001"]
    end
  end
end