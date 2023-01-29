require 'rails_helper'

describe '新規登録' do
  before do
    @user = FactoryBot.build(:user)
  end
  context '新規登録ができるとき' do 
    it '正しい情報を入力すれば新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'user[name]', with: @user.name
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password
      
      click_button '新規登録'

      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      #トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'user[name]', with: ''
      fill_in 'user[email]',  with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      
      click_button '新規登録'
 
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq users_path
    end
  end
end

describe 'ログイン'  do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path

      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit user_session_path

      # 正しいユーザー情報を入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password

      # ログインボタンを押す
      find('input[name="commit"]').click

      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path

      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit user_session_path

      # ユーザー情報を入力する
      fill_in 'user[email]',  with: ''
      fill_in 'user[password]', with: ''

      # ログインボタンを押す
      find('input[name="commit"]').click

      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end