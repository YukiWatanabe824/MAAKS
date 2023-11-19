
# MAAKS


## 概要
MAAKS(マークス)は、サイクリング中の事故を減らための道路上の自転車事故やトラブルを共有するサービスです。

ユーザーは 地図上で他のユーザーが投稿した事故の情報やレポートを確認することができ、サイクリングルート設定時・走行時の危険予測が可能です。

属コミュニティ化していた「危ないスポットの情報」をコミュニティの枠を超えて確認できるようになることで、より安全で楽しいライドに役立ちます。

## URL
```
https://maaks.jp/
```

## 使い方
### 1. スポットを閲覧する

### 2. ログインする(サービス内アカウント or Googleアカウントでログイン可能)

### 3. スポットを登録する

## 開発環境
- Ruby 3.2.2
- Ruby on Rails 7.0.5
- Hotwire
- Node.js 18.12.1
- yarn 1.22.19

## 開発環境立ち上げ
```
$ git clone https://github.com/YukiWatanabe824/MAAKS.git
$ cd maaks
$ bin/setup

$ bin/dev
```

## credentials.yml.enc

| credential | 説明 |
|---|---|
| google.client_id | GoogleクライアントID |
| google.client_secret | Googleクライアント シークレット |
| mapbox.access_token | MapBoxアクセストークン |
| mapbox.style | MapBoxスタイル情報 |
| gmail.user_name | gmailユーザー名 |
| gmail.password | gmailパスワード |

## Lint/Test
### Lint
```
$ rubocop
$ yarn run lint:eslint
$ yarn run lint:prettier
```

### Test
```
$ bin/rails test:all
```