module Ruboty
  module Handlers
    class Github < Base
      on(/issues/i, name: 'issues', description: '最新の20件の issue を表示')

      on(/branches/i, name: 'branches', description: 'ブランチ一覧を表示')

      def issues(message)
        issues = client.issues(repo)
        issue_names = "最新の20件だ！\n"

        issues.last(20).each do |issue|
          issue_names += "##{issue[:number]} #{issue[:title]} (#{issue[:url]})\n"
        end

        message.reply(issue_names)
      end

      def branches(message)
        git_branches = client.branches(repo).map(&:name)

        branch_names = "ブランチ一覧:\n"

        message.reply(branch_names + git_branches.join("\n"))
      end
    end
  end
end
