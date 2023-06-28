module Projections
  module Accounts
    module WithActiveSubscriptionsAt
      def self.call(date_at, stream, snapshot = Set.new)
        snapshot.tap do |accounts|
          stream.each do |entry|
            entry => { account:, event:, date: }
            break if date > date_at

            ['reactivation', 'subscription'].include?(event) ? accounts << account : accounts.delete(account)
          end
        end.to_a
      end
    end
  end
end