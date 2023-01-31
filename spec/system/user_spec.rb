require 'rails_helper'

describe 'ログイン'  do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'トップページでログインができるとき' do
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
