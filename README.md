# Ruboty
## ローカルでの動かし方
```
gem install ruboty
ruboty --generate
cd ruboty

bundle install

bundle exec ruboty
```

## 動作確認
- Rubotyの立ち上げ
```
bundle exec ruboty
```
- 動きのチェック
```
# ヘルプを表示する
> ruboty help
ruboty /help( me)?(?: (?<filter>.+))?\z/i - Show this help message
ruboty /ping\z/i - Return PONG to PING
ruboty /who am i\?/i - Answer who you are

# pingを飛ばす
> ruboty ping
pong
```

## ローカルで Slack から動かす
- Gemfileに以下を追加して、 `bundle install`
```
gem 'ruboty-slack_rtm'
```
- 以下よりSlackにBotアカウントを作成。追加するTeam, channel
https://slack.com/apps/A0F7YS25R-bots
- その際、 `Integration Settings` に表示される `API Token` を .env ファイルに保存
- `--dotenv` を追加して起動(ローカルでは固まってるように見えるけど動いてる)
```
bundle exec ruboty --dotenv
```
- 作成したBotがいるルームでピンポン(名前をrubotyにした場合)
```
ruboty ping
```
