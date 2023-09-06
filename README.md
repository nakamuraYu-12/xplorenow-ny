# xplorenow
## 概要
イベントを地上にマッピングし公開することができるアプリケーションになります。

RPGの世界地図から着想を得て、世の中のイベントを地図上にマッピングして表示させたら面白いのではないかと考え、冒険をテーマに作成しました。

<img width="1437" alt="スクリーンショット 2023-09-05 6 29 01" src="https://github.com/nakamuraYu-12/xplorenow-ny/assets/66306795/56170a70-b88a-4a4a-985f-f629ce0306a9">

## こだわった点
ユーザーが直感的に操作しやすいよう既存のSNSを参考に作成しました。

冒険がテーマであるため他のイベント紹介サイトと異なり、地図を全面に出して、イベントのマーカーを設置するという方法を取っています。

そうすることで地図から視覚的に探す、リストからキーワードで探すなどイベントを双方向から探すことができ、新しいSNSのような操作感を得ることができるのではないかと考えました。

## 使用技術
・フロントエンド
・Ruby(2.7.3) 

・Ruby on Rails(6.1)

・MySQL(5.3)

・AWS

　└S3

・Docker/Docker-compose

・CircleCI/CD

・Rspec

・Google Maps API


## ER図

![image](https://github.com/nakamuraYu-12/xplorenow-ny/assets/66306795/080e0abd-7373-4695-9e9c-5f316197fa7a)

## 全体設計

![image](https://github.com/nakamuraYu-12/xplorenow-ny/assets/66306795/d47c2cae-5d48-4170-9662-81801ccfecd1)


## CircleCI/CI
push時にRubocop,Rspecが自動で実行され、marge時にHerokuへの自動デプロイが実行されます。


## 機能一覧

ユーザーログイン(Devise)機能

ゲストログイン機能

イベント投稿機能(画像投稿)

地域検索機能(geocoder)

イベント検索機能(フィルター機能、ソート機能)

タグ登録機能,タグ編集機能、タグ検索機能

ブックマーク機能

ユーザーページ(ユーザープロフィール、アイコン、作成したイベント一覧)

マイページ(作成したイベント確認、プロフィール、プロフィール編集)

## デモ

https://xplorenow-ny-ed648b526613.herokuapp.com/
