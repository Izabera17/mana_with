module SignInSupport
  def sign_in(user)
    visit root_path
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end