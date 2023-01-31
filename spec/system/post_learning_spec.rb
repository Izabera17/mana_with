require 'rails_helper'

describe '投稿のテスト' do 
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:genre, name: 'IT・情報処理')
    FactoryBot.create(:genre, name: 'デザイン')
    FactoryBot.create(:genre, name: '語学')
    FactoryBot.create(:genre, name: '教育')
    FactoryBot.create(:genre, name: '医療・福祉')
    FactoryBot.create(:genre, name: '理数')
  end
  context '新規投稿ができる' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
          
      # トップページに新規投稿ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('投稿する')
          
      # 新規投稿フォームに移動する
      visit new_post_learning_path
          
      # 正しい投稿情報を入力する
      fill_in 'post_learning[learning_name]', with: Faker::Lorem.characters(number:5)
      fill_in 'post_learning[learning_content]', with: Faker::Lorem.characters(number:20) 
      fill_in 'post_learning[learning_real]', with: Faker::Lorem.characters(number:20) 
      select 'IT・情報処理', from: 'post_learning[genre_id]'
      @user.user_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test.jpg'))
          
      # 新規投稿ボタンを押す
      click_on '新規投稿', match: :first
          
      # 学習投稿詳細ページへ遷移することを確認する
      expect(current_path).to eq(post_learning_path(PostLearning.last))
    end
  end
  context '新規投稿ができない' do
    it 'ログインしていないユーザーは新規投稿できない' do
      #トップページへ移動
      visit root_path
          
      # トップページに新規投稿ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('投稿する')
          
      # 新規投稿フォームに移動する
      visit new_post_learning_path
      
      # ログインページへ遷移することを確認する
      expect(current_path).to eq(new_user_session_path)
    end
    it '学習名・頑張ったこと・学びの本音・ジャンルに何も入力されていないと投稿できない' do
      # ログインする
      sign_in(@user)
          
      # トップページに新規投稿ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('投稿する')
          
      # 新規投稿フォームに移動する
      visit new_post_learning_path
          
      # 誤った投稿情報を入力する
      fill_in 'post_learning[learning_name]', with: ''
      fill_in 'post_learning[learning_content]', with: ''
      fill_in 'post_learning[learning_real]', with: ''
      select '選択してください', from: 'post_learning[genre_id]'
          
      # 新規投稿ボタンを押す
      click_on '新規投稿', match: :first
          
      # 学習投稿ページへ戻されることを確認する
      expect(current_path).to eq(post_learnings_path)
    end
    it '学習名・頑張ったこと・学びの本音・ジャンルが規定文字以上だと投稿できない' do
      # ログインする
      sign_in(@user)
          
      # トップページに新規投稿ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('投稿する')
          
      # 新規投稿フォームに移動する
      visit new_post_learning_path
          
      # 誤った投稿情報を入力する
      fill_in 'post_learning[learning_name]', with: Faker::Lorem.characters(number:51)
      fill_in 'post_learning[learning_content]', with: Faker::Lorem.characters(number:201)
      fill_in 'post_learning[learning_real]', with: Faker::Lorem.characters(number:201)
      select '選択してください', from: 'post_learning[genre_id]'
          
      # 新規投稿ボタンを押す
      click_on '新規投稿', match: :first
          
      # 学習投稿ページへ戻されることを確認する
      expect(current_path).to eq(post_learnings_path)
    end
  end
end