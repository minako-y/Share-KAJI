# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Monsterモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { monster.valid? }

    let!(:user) { build(:user) }
    let(:monster) { build(:monster, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        monster.name = ''
        is_expected.to eq false
      end
    end
    context 'memoカラム' do
      it '空欄でないこと' do
        monster.memo = ''
        is_expected.to eq false
      end
    end
    context 'image_idカラム' do
      it '空欄でないこと' do
        monster.image_id = ''
        is_expected.to eq false
      end
    end
    context 'genre_idカラム' do
      it 'ジャンルが未選択でないこと' do
        monster.genre_id = ''
        is_expected.to eq false
      end
    end
  end
end