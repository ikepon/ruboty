module Ruboty
  module Handlers
    class Github < Base
      on(/issues/i, name: 'issues', description: '最新の20件の issue を表示')

      on(/branches/i, name: 'branches', description: 'ブランチ一覧を表示')

      on(/create lw_tag (?<name>.+) (?<branch>.+)/i, name: 'create_ref', description: '指定ブランチから lightweight tag を作成(ブランチがない場合はmasterから作成)')

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

      def create_ref(message)
        tag_name = message[:name]
        branches = client.branches(repo)
        original_branch_sha1 = ''

        branches.each do |branch|
          if branch.name == message[:branch]
            original_branch_sha1 = branches.first.commit.sha
            break
          elsif branch.name == 'master'
            original_branch_sha1 = branches.first.commit.sha
          end
        end

        client.create_ref(repo, 'tags/' + tag_name, original_branch_sha1)

        message.reply('lightweight tag を作成しました')
      end
    end
  end
end
