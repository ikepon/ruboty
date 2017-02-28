module Ruboty
  module Handlers
    class Base
      private

      def client
        @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
      end
    end
  end
end
