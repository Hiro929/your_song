require 'rails_helper'

RSpec.describe 'AdminUserSessions', type: :system do
  let(:admin) { create(:user, :admin) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit admin_login_path
        fill_in 'メールアドレス', with: admin.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました！'
        expect(current_path).to eq songs_path
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit admin_login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました！'
        expect(current_path).to eq admin_login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンクリック' do
      it 'ログアウト処理が成功する' do
        login(admin)
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました！'
        expect(current_path).to eq  admin_login_path
      end
    end
  end
end
