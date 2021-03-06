require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :access_token }
    it { should validate_presence_of :refresh_token }
    it { should validate_presence_of :uid }
    it { should validate_uniqueness_of :uid }
  end

  describe 'relationships' do
      it { should have_many :friendships }
      it { should have_many(:friends).through(:friendships) }
  end

  describe 'class methods' do
    it '.from_omniauth' do
      params = {
        uid: '123',
        info: {email: 'joe@me.com'},
        credentials: {token: 'access', refresh_token: 'aiourlk3m1j'}
      }
      user = User.from_omniauth(params)
      user_id = user.id

      expect(user).to eq(User.last)
      expect(user.uid).to eq('123')
      expect(user.email).to eq('joe@me.com')
      expect(user.access_token).to eq('access')

      params_2 = {
        uid: '456',
        info: {email: 'bob@me.com'},
        credentials: {token: 'more_access', refresh_token: 'ajfiowejfl'}
      }
      user_2 = User.from_omniauth(params_2)

      expect(User.from_omniauth(params)).to eq(user)
      expect(User.from_omniauth(params).id).to eq(user_id)
      expect(User.last).to eq(user_2)
    end
  end
end
