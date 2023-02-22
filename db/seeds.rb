# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 User.create!(
   name:  "管理者",
   email: "admin@example.jp",
   password:  "AdminTest",
   password_confirmation: "AdminTest",
   admin: true
  )
            
users = User.create!(
  [
    {
      email: 'gakushu@test.com', 
      name: '学習 健二', 
      password: 'test_1',
      password_confirmation: 'test_1',
      introduction: '初めまして！休日は色々な勉強をするのが好きです！最近は統計学に興味があるので、同じ人がいたら嬉しいです！',
      user_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"),
      filename:"sample-user1.jpg")
     },
    {
      email: 'benkyo@test.com', 
      name: '勉強 太郎', 
      password: 'test_2', 
      password_confirmation: 'test_2',
      introduction: 'まだwebデザインを初めて１ヶ月です。cssが苦手でなかなか良いデザインができません。',
      user_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), 
      filename:"sample-user2.jpg")
     },
    {
      email: 'jishuu@test.com', 
      name: '自習 花子', 
      password: 'test_3', 
      password_confirmation: 'test_3',
      introduction: '現在は、大学生でいろんなことを学んで、将来の糧にしたいと考えています。一人で勉強し続けるのが苦手なので、一緒に勉強できる仲間ができれば嬉しいです。',
      user_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), 
      filename: "sample-user3.jpg")
    }
  ]
)

genres = Genre.create!(
 [
  {name: 'IT・情報処理'},
  {name: 'デザイン'},
  {name: '語学'},
  {name: '教育'},
  {name: '医療・福祉'},
  {name: '理数'}
  ]
 )
 
post_learning = PostLearning.create!(
  [
    {
     learning_name: '統計学の勉強', 
     learning_content: 'ベルヌーイ試行と二項分布の特徴とその公式の使い方を学んだ。', 
     learning_real: '公式の理解は本当に理解するのが大変だった。二項分布の公式で計算ができたのは嬉しかった！',
     post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), 
     filename: "sample-post1.jpg"),
     genre_id: genres[5].id,
     user_id: users[0].id 
    },
    {
     learning_name: 'コーディングとレイアアウト調整', 
     learning_content: 'Flexboxを使って商品画像を３×４列に整列し、見やすいように色の配色も考えた。', 
     learning_real: '色彩検定の知識を活かして、配置だけじゃなく色の配色を考えて実装できてよかった！今度はフォントを意識して実装してみたい！',
     post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), 
     filename: "sample-post2.jpg"),
     genre_id: genres[0].id,
     user_id: users[1].id 
    },
    {
     learning_name: '英検３級の学習', 
     learning_content: '関係代名詞の文法の使い方 ・単語を５０個覚えた', 
     learning_real: '関係代名詞は、後ろから前に読むことがあるので、ややこしくてしんどかった。',
     genre_id: genres[2].id,
     user_id: users[2].id 
    },
    {
     learning_name: 'HTMLコーディング', 
     learning_content: 'Flexboxの理解と実装。marginの余白調整', 
     learning_real: 'Flexboxを実装できたけど、やっぱり難しい。もっと良い方法を学びたい。デザインは自身ある！',
     post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), 
     filename: "sample-post3.jpg"),
     genre_id: genres[0].id,
     user_id: users[2].id 
    }
  ]
)

PostComment.create!(
  [
    {
      comment: '初めまして',
      post_learning_id: post_learning[0].id,
      user_id: users[1].id
    },
    {
      comment: 'よろしくお願い致します！',
      post_learning_id: post_learning[0].id,
      user_id: users[0].id
    },
    {
      comment: 'こんにちは',
      post_learning_id: post_learning[1].id,
      user_id: users[2].id
    },
    {
      comment: 'こんにちは',
      post_learning_id: post_learning[1].id,
      user_id: users[1].id
    },
    {
      comment: 'お疲れ様です',
      post_learning_id: post_learning[2].id,
      user_id: users[1].id
    },
    {
      comment: 'お疲れ様です',
      post_learning_id: post_learning[3].id,
      user_id: users[1].id
    }
  ]
)

Favorite.create!(
  [
    {
      post_learning_id: post_learning[1].id, 
      user_id: users[0].id
    },
    {
      post_learning_id: post_learning[2].id, 
      user_id: users[1].id
    },
    {
      post_learning_id: post_learning[2].id, 
      user_id: users[0].id
    },
    {
      post_learning_id: post_learning[3].id, 
      user_id: users[1].id
    },
    {
      post_learning_id: post_learning[3].id, 
      user_id: users[2].id
    }
  ]
)

users[0].follow(users[1])
users[1].follow(users[2])
users[2].follow(users[0])