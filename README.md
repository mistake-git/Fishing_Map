# README


### Fishing Map

### アプリ概要
 地図上で釣果を共有したりデータ分析を見たりできる,SNS型釣果登録アプリケーション
 
### 技術一覧
* Ruby on rails [5.2]
* AWS(VPC,EC2,S3,RDS,Route53,ACM,ALB)
* MySQL
* Nginx
* unicorn
* MySQL
* device
* google Map API
* Twitter API
* Active Storage
* geocode
* kaminari
* bootstrap
* chartkick
* ransack
* JQuery

### 機能一覧
* ユーザー登録
* ユーザー情報編集
* ログイン
* ログアウト
* パスワード再設定
* 釣果のCRUD
* 画像投稿機能
* 記事ページネーション
* ユーザー一覧表示
* 記事一覧表示
* コメント
* いいね
* フォロー
* Ajaxを用いた非同期通信
* 通知機能
* 住所から緯度経度を算出
* 緯度経度から住所を算出
* ユーザー検索
* ユーザー釣果検索
* 地図に釣果を登録
* 地図釣果検索機能
* 釣果データ分析機能
* 魚のサイズランキング機能
* Twitter認証機能
* 投稿作成時Twitterにも投稿
* お問い合わせ機能
* モデルテスト
* システムテスト

### Dockerで立ち上げる場合

docker-compose build  <br>
docker-compose up  <br>
docker-compose run app bash  <br>
rails db:create  <br>
rails db:migrate  <br>
上記のコマンドを順に実行してください。  <br>


docker-compose build  <br>
docker-compose up  <br>
再度上記を実行することでDockerを使ってアプリケーションを起動する事ができます。