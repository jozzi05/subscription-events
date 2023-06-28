module Projections
  module Accounts
    module WithReactivatedSubscriptions
      def self.call(stream, snapshot = Set.new)
        stream.reduce(snapshot) do |accounts, event|
          accounts << event[:account] if event[:event] == 'reactivation'
          accounts
        end.to_a
      end
    end
  end
end