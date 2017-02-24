module Ruboty
  module Handlers
    class Github < Base
      on(/hello/i, name: "hello", description: "挨拶します")
      on(/issues/i, name: "issues", description: "最新の20件の issue を出す")

      def hello(message)
        msg  = "こんにちは！"
        message.reply(msg)
      end

      def issues(message)
        issues = client.issues(ENV['REPOSITORY'])
        issue_names = "最新の20件だ！\n"

        issues.last(20).each do |issue|
          issue_names += "##{issue[:number]} #{issue[:title]} (#{issue[:url]})\n"
        end

        message.reply(issue_names)
      end
    end
  end
end
