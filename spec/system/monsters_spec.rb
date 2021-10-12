require 'rails_helper'

describe 'モンスター登録のテスト' do
  let!(:monster) { create(:monster) }
  describe 'マイページのテスト' do
    before do
      visit mypage_path
    end
    context 'リンク表示の確認' do
      it 'マイページ(mypage_path)に一覧ページのリンクが表示されているか' do
        expect(page).to have_link "", herf: monsters_path
      end
    end
  end
  describe 'モンスター一覧画面(monsters_path)のテスト' do
    before do
      visit monsters_path
    end
    context '一覧の表示とリンクの確認' do
      it 'monsterの一覧表示と登録フォームが同一画面に表示さsれているか' do
        expect(page).to have_field 'monster[name]'
        expect(page).to have_field 'monster[memo]'
      end
    end
  end
end
