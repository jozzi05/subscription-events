require 'stream_source_service'
require 'projections/accounts/with_active_subscriptions_at'

RSpec.describe "Test that uses implementation with sample data" do
  let(:input) do
    [
      { "event": "subscription", "account": "A001", "date": "2020-01-15" },
      { "event": "subscription", "account": "B001", "date": "2020-01-23" },
      { "event": "subscription", "account": "C001", "date": "2020-01-25" },
      { "event": "cancellation", "account": "B001", "date": "2020-02-23" },
      { "event": "reactivation", "account": "B001", "date": "2020-04-01" },
      { "event": "cancellation", "account": "B001", "date": "2020-04-03" },
      { "event": "reactivation", "account": "B001", "date": "2020-05-12" },
      { "event": "cancellation", "account": "B001", "date": "2020-06-18" },
      { "event": "cancellation", "account": "C001", "date": "2020-03-10" },
      { "event": "reactivation", "account": "C001", "date": "2020-05-17" }
    ]
  end

  let(:stream) { StreamSourceService.new(input).prepare.provide }

  describe 'task A' do
    it 'is correctly implemented' do
      task_a_result = Projections::Accounts::WithReactivatedSubscriptions.call(stream)
      expect(task_a_result).to eq ["B001", "C001"]
    end
  end

  describe 'task B' do
    it 'is correctly implemented' do
      task_b_result = Projections::Accounts::WithActiveSubscriptionsAt.call(Date.parse('2020-04-02'), stream)
      expect(task_b_result).to eq ["A001", "B001"]
    end
  end
end