require 'projections/accounts/with_active_subscriptions_at'

RSpec.describe Projections::Accounts::WithActiveSubscriptionsAt do
  subject(:projection) { described_class.call(date_at, stream, snapshot) }
  let(:snapshot) { Set.new }
  let(:date_at) { Date.parse('2020-05-17') }

  describe 'with empty stream' do
    let(:stream) { [] }

    it 'returns empty array' do
      expect(projection).to eq []
    end
  end

  describe 'with subscription and cancellation event' do
    let(:stream) do
      [
        { "event": "subscription", "account": "C001", "date": Date.parse("2020-05-16") },
        { "event": "cancellation", "account": "C001", "date": Date.parse("2020-05-18") }
      ]
    end

    describe "with date between subscription and cancellation" do
      let(:date_at) { Date.parse('2020-05-17') }

      it 'returns found account' do
        expect(projection).to eq ["C001"]
      end
    end

    describe "with date before subscription" do
      let(:date_at) { Date.parse('2020-05-15') }

      it 'returns empty array' do
        expect(projection).to eq []
      end
    end

    describe "with date after cancellation" do
      let(:date_at) { Date.parse('2020-05-18') }

      it 'returns empty array' do
        expect(projection).to eq []
      end
    end
  end

  describe 'with reactivation and cancellation event' do
    let(:stream) do
      [
        { "event": "reactivation", "account": "C001", "date": Date.parse("2020-05-16") },
        { "event": "cancellation", "account": "C001", "date": Date.parse("2020-05-18") }
      ]
    end

    describe "with date between reactivation and cancellation" do
      let(:date_at) { Date.parse('2020-05-17') }

      it 'returns found account' do
        expect(projection).to eq ["C001"]
      end
    end

    describe "with date before reactivation" do
      let(:date_at) { Date.parse('2020-05-15') }

      it 'returns empty array' do
        expect(projection).to eq []
      end
    end

    describe "with date after cancellation" do
      let(:date_at) { Date.parse('2020-05-18') }

      it 'returns empty array' do
        expect(projection).to eq []
      end
    end
  end
end