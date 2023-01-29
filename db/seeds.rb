# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 User.create!(name:  "管理者",
             email: "admin@example.jp",
             password:  "AdminTest",
             password_confirmation: "AdminTest",
             admin: true)
             
             
users = User.create!(
  [
    {
      email: 'gakushu@test.com', 
      name: '学習　健二', 
      password: 'asasas',
      password_confirmation: 'asasas',
      user_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"),
      filename:"sample-user1.jpg")
     },
    {
      email: 'benkyo@test.com', 
      name: '勉強　太郎', 
      password: 'asasas', 
      password_confirmation: 'asasas',
      user_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), 
      filename:"sample-user2.jpg")
     },
    {
      email: 'jishuu@test.com', 
      name: '自習　花子', 
      password: 'asasas', 
      password_confirmation: 'asasas',
      user_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), 
      filename:"sample-user3.jpg")
    }
  ]
)

PostImage.create!(
  [
    {
     learning_name: '統計学の勉強', 
     learning_content: 'ベルヌーイ試行と二項分布の特徴とその公式の使い方を学んだ。', 
     post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), 
     filename:"sample-post1.jpg"),
     learning_real: '公式の理解は本当に理解するのが大変だった。二項分布の公式で計算ができたのは嬉しかった！',
     genre: genres[5].name,
     user_id: users[0].id 
    },
    {
     learning_name: 'コーディングとレイアアウト調整', 
     learning_content: 'Flexboxを使って商品画像を３×４列に整列し、見やすいように色の配色も考えた。', 
     post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), 
     filename:"sample-post1.jpg"),
     learning_real: '色彩検定の知識を活かして、配置だけじゃなく色の配色を考えて実装できてよかった！今度はフォントを意識して実装してみたい！',
     genre: genres[0].name,
     user_id: users[1].id 
    },
    {
     learning_name: '英検３級の学習', 
     learning_content: '関係代名詞の文法の使い方 ・単語を５０個覚えた', 
     post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), 
     filename:"sample-post1.jpg"),
     learning_real: '関係代名詞は、後ろから前に読むことがあるので、ややこしくてしんどかった。',
     genre: genres[2].name,
     user_id: users[2].id 
    },
   {
     learning_name: 'HTMLコーディング', 
     learning_content: 'Flexboxの理解と実装。marginの余白調整', 
     post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), 
     filename:"sample-post1.jpg"),
     learning_real: 'Flexboxを実装できたけど、やっぱり難しい。もっと良い方法を学びたい。デザインは自身ある！',
     genre: genres[0].name,
     user_id: users[2].id 
    },
   
  ]
)

Genre.create!(
 [
  {name: 'IT・情報処理'},
  {name: 'デザイン'},
  {name: '語学'},
  {name: '教育'},
  {name: '医療・福祉'},
  {name: '理数'}
  ]
 )