# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Monsterモデルのテスト', type: :model do
  describe '実際に保存してみる' do
    it '有効な内容であれば保存されるか' do
      expect(FactoryBot.build(:monster)).to be_valid
    end
  end
  describe 'バリデーションのテスト' do
    subject { monster.valid? }

    let!(:user) { build(:user) }
    let(:monster) { build(:monster, user_id: user.id) }

    context 'nameカラム' do
      it '空欄の場合バリデーションテェックされ、空欄のエラーメッセージが返る' do
        monster.name = ''
        is_expected.to eq false
        expect(monster.errors[:name]).to include("can't be blank")
      end
    end
    context 'memoカラム' do
      it '空欄の場合バリデーションテェックされ、空欄のエラーメッセージが返る' do
        monster.memo = ''
        is_expected.to eq false
        expect(monster.errors[:memo]).to include("can't be blank")
      end
    end
    context 'image_idカラム' do
      it '空欄の場合バリデーションテェックされ、空欄のエラーメッセージが返る' do
        monster.image = ''
        is_expected.to eq false
        expect(monster.errors[:image]).to include("can't be blank")
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
