## your song
![ogp](https://user-images.githubusercontent.com/79961416/194931854-07d2f232-3c85-46ef-a5d9-3e16e06b8442.png)

## サービス概要

表情の撮影を行い、その表情を感情分析。
その結果に応じて、おすすめの楽曲の提案を行うアプリです。  
※SUPER BEAVERの楽曲のみ。

## メインのターゲットユーザー

音楽聴くことが好きな方。SUPER BEAVERが好きな方。

## ユーザーが抱える課題

今、どんな曲を聴こうかなと悩む。
super beaverを好きな人で、どの曲を聴くか悩む。

## 解決方法

ユーザーの今の感情によって曲を提案してあげる。

## 主な機能

- 感情分析機能
  - ユーザーのリアルタイムの表情を撮影し、感情分析を行う。感情分析をする為、Amazon Rekognitionを導入。  
   (感情タイプ：幸せ 悲しみ 怒り 困惑 驚き 穏やか うんざり 恐れ 無感情)
- 楽曲提案機能
  - 取得している楽曲情報を元に、感情分析の結果に応じて、選曲を行う。
- Twitterシェア機能
  - 選曲結果をTwitterにシェアすることができる。
  
### 管理者の機能

- 楽曲登録機能
  - Spotify APIで楽曲の情報を取得。
- 登録楽曲一覧
  - 登録した楽曲を見ることができる。

## なぜこのサービスを作ったのか？

みなさん、音楽を聴こうとしたとき、何の曲聴こうかなと悩んだことありませんか？
私の場合、ハマっている曲があれば、それを聴くことが多いですが、そうでない場合は「どうしようかな〜」となることが多いです。
また、悲しい時(落ち込んだ時)など、何聴こうかな〜となることが多いです。
そういった時に、おすすめの曲を提案してくれるものがあればいいなと思い、本サービスを作りました。

## 使用技術

**バックエンド**
Ruby 3.0.3  
Ruby on Rails 6.1.4

**フロントエンド**
Javascript  
Bootstrap

**外部API**
Amazon Rekognition  
Spotify API

**インフラ**
Heroku  
postgreSQL

## 画面遷移図
https://www.figma.com/file/9RIT8Eg8fCLcdPVj4ovJZP/your-song-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1

## ER図
https://drive.google.com/file/d/1dFD7ThYUKqogehEp4HkC2UA47ClPuLW3/view?usp=sharing
