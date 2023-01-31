require 'rails_helper'

    describe '投稿機能' do 
      before do
        @user = FactoryBot.create(:user)
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

           find("option[value='1']").click
          user.user_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test.jpg'))
          
          # 新規投稿ボタンを押す
          find('input[name="commit"]').click
          
          # 学習投稿ページへ戻されることを確認する
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
          
          @user.user_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test.jpg'))
          
          # 新規投稿ボタンを押す
          find('input[name="commit"]').click
          
          # 学習投稿ページへ戻されることを確認する
          expect(current_path).to eq(new_post_learning_path)
        end
      end
    end
