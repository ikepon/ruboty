require 'octokit'

module Ruboty
  module Handlers
    class Github < Base
      on(/hello/i, name: "hello", description: "こんにちは")
      on(/issues/i, name: "issues", description: "issue を出す")

      def hello(message)
        user = client.user
        msg  = user.login
        message.reply(msg)
      end

      def say(message)
        user = client.user
        msg  = user.login
        message.reply('say')
      end

      private

      def client
        @client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
      end
    end
  end
end
