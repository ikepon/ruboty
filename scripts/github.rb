module Ruboty
  module Handlers
    class Github < Base
      on(/issues/i, name: 'issues', description: '最新の20件の issue を表示')

      on(/branches/i, name: 'branches', description: 'ブランチ一覧を表示')

      on(/create lw_tag (?<tag_name>.+) (?<branch>.+)/i, name: 'create_ref', description: '指定ブランチから lightweight tag を作成(ブランチがない場合はmasterから作成)')

      on(/create prerelease (?<tag_name>.+) (?<branch>.+)/i, name: 'create_prerelease', description: '指定ブランチから Pre-release タグを作成(ブランチがない場合はmasterから作成)')

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
        tag_name = message[:tag_name]
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

        message.reply('lightweight タグを作成しました')
      end

      def create_prerelease(message)
        tag_name = message[:tag_name]
        branche_names = client.branches(repo).map(&:name)
        original_branch = branche_names.include?(message[:branch]) ? message[:branch] : 'master'

        client.create_release(repo, tag_name, prerelease: true, target_commitish: original_branch)

        message.reply('Pre-release タグを作成しました')

      rescue Octokit::UnprocessableEntity => e
        error_message = e.errors.first[:field] + ' ' + e.errors.first[:code]
        message.reply(error_message)
      end
    end
  end
end
