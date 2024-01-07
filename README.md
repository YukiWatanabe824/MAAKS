# MAAKS
![logo](https://github.com/YukiWatanabe824/MAAKS/assets/69577164/57a50068-5c89-406d-bca2-fc52f633329c)

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
<img width="70%" alt="readme_show_spot" src="https://github.com/YukiWatanabe824/MAAKS/assets/69577164/8aaff52f-ae60-4b44-a9fc-66eba489ae42">

### 2. ログインする(Googleアカウントでログイン可能)
<img width="70%" alt="readme_login" src="https://github.com/YukiWatanabe824/MAAKS/assets/69577164/d3237146-e471-4a8f-a7f7-b77a7914c77a">

### 3. スポットを登録する
<img width="70%" alt="readme_create_spot" src="https://github.com/YukiWatanabe824/MAAKS/assets/69577164/3f7d60b0-0a54-47ef-bc4e-b45988721b68">

## 開発環境
- Ruby 3.2.2
- Ruby on Rails 7.1.2
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
