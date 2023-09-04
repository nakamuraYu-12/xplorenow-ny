# xplorenow-ny
## 概要
イベントを投稿し、地図と紐づけて公開することができるwebアプリケーションです。

直感的に操作しやすいように、既存のSNSをイメージして作成しました。


## 使用技術

Ruby(2.7.3) 

Ruby on Rails(6.1)

MySQL(5.3)

AWS(S3)

Docker/Docker-compose

CircleCI/CD

Rspec

Rubocop

Google Maps API

## CircleCI/CI
push時にRubocop,Rspecが自動で実行され、marge時にHerokuへの自動デプロイが実行されます。

## 機能一覧

ユーザーログイン(Devise)機能

ゲストログイン機能

イベント投稿機能(画像投稿)

地域検索機能(geocoder)

イベント検索機能(フィルター機能、ソート機能)

ブックマーク機能

ユーザーページ(ユーザープロフィール、アイコン、作成したイベント一覧)

マイページ(作成したイベント確認、プロフィール、プロフィール編集)

## デモ

https://xplorenow-ny-ed648b526613.herokuapp.com/
