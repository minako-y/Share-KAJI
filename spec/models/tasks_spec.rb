require 'rails_helper'

RSpec.describe 'Taskモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { task.valid? }

    let!(:user) { build(:user) }
    let(:task) { build(:task) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        task.body = ''
        is_expected.to eq false
      end
    end
    context 'due_dateカラム' do
      it '空欄でないこと' do
        task.due_date = ''
        is_expected.to eq false
      end
    end
    context 'genre_idカラム' do
      it '空欄でないこと' do
        task.genre_id = ''
        is_expected.to eq false
      end
    end
  end
end