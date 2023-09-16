require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'John Doe', email: 'local@host', password: '123456', password_confirmation: '123456')
  before { user.save }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid with a name longer than 50 characters' do
    user.name = ('a' * 51)
    expect(user).to_not be_valid
  end

  it 'is valid with a name of 50 characters or less' do
    user.name = ('a' * 50)
    expect(user).to be_valid

    user.name = ('a' * 40)
    expect(user).to be_valid
  end

  it 'is not valid with a name of less than characters' do
    user.name = 'a'
    expect(user).to_not be_valid
  end

  it 'is valid with a password of 6 characters or more' do
    user.password = '123456'
    user.password_confirmation = '1234569'
    expect(user).to_not be_valid
  end

  it 'is valid with a password confirmation that matches' do
    user.password = '1234569'
    user.password_confirmation = '1934569'
    expect(user).to_not be_valid
  end
end
