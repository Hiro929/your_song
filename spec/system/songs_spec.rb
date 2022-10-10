require 'rails_helper'

RSpec.describe 'Songs', type: :system do
  let(:admin) { create(:user, :admin) }

  describe '楽曲登録' do
    before do
      login(admin)
      visit new_song_path
    end

    context '楽曲登録ページにアクセス' do
      it '楽曲登録ができる' do
        fill_in 'album', with: '東京'
        click_button '検索'
        first('.submit').click_button('登録')
        expect(page).to have_content '登録しました！'
        expect(current_path).to eq songs_path
      end

      it 'すでに登録した楽曲を登録しようとすると失敗する' do
        fill_in 'album', with: '東京'
        click_button '検索'
        first('.submit').click_button('登録')
        click_link '楽曲登録'
        fill_in 'album', with: '東京'
        click_button '検索'
        first('.submit').click_button('登録')
        expect(page).to have_content 'すでに登録されているか、正常に登録されませんでした。'
        expect(current_path).to eq songs_path
      end
    end
  end
end
