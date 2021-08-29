RSpec.describe 'Roomモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { room.valid? }

    let(:other_room) { create(:room) }
    let!(:room) { build(:room) }

    context 'nameカラム' do
      it '空欄でないこと' do
        room.name = ''
        is_expected.to eq false
      end
      it '30文字以下であること: 30文字は〇' do
        room.name = Faker::Lorem.characters(number: 30)
        is_expected.to eq true
      end
      it '30文字以下であること: 31文字は×' do
        room.name = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
      it '一意性があること' do
        room.name = other_room.name
        is_expected.to eq false
      end
    end

    context 'passwordカラム' do
      it '空欄でないこと' do
        room.password = ''
        room.password_digest = ''
        is_expected.to eq false
      end
      it '6文字以上であること: 6文字は〇' do
        room.password = Faker::Lorem.characters(number: 6)
        is_expected.to eq true
      end
      it '6文字以上であること: 5文字は×' do
        room.password = Faker::Lorem.characters(number: 5)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
