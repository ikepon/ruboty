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
Rubotyの立ち上げ
```
bundle exec ruboty
```
動きのチェック
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
