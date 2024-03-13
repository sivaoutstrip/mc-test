# == Schema Information
#
# Table name: details
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  email      :string           not null
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class DetailTest < ActiveSupport::TestCase
  def setup
    @detail = Person.first.details.new(phone: '+1 234 567 890', email: 'andrew@rubyonrails.com')
  end

  test 'should be valid' do
    assert @detail.valid?
  end

  test 'person is mandatory' do
    @detail.person_id = nil
    assert_not @detail.valid?
  end

  test 'person should available' do
    @detail.person_id = 'unknown'
    assert_not @detail.valid?
    assert_includes @detail.errors.messages[:person], 'must exist'
  end

  test 'email is mandatory' do
    @detail.email = nil
    assert_not @detail.valid?
  end

  test 'email should not be text' do
    @detail.email = 'Some string'
    assert_not @detail.valid?
  end

  test 'should strip email address' do
    @detail.email = "\hello@rubyonrails.com\r\n"
    @detail.valid?
    assert_equal 'hello@rubyonrails.com', @detail.email
  end

  test 'should squish email address' do
    @detail.email = ' test@rubyonrails.com  '
    @detail.valid?
    assert_equal 'test@rubyonrails.com', @detail.email
  end

  test 'should convert email address to downcase' do
    @detail.email = " HELLO@RUBYONRAILS.COM \n"
    @detail.valid?
    assert_equal 'hello@rubyonrails.com', @detail.email
  end

  test 'should not allow duplicate email address' do
    @detail.email = Detail.first.email
    assert_not @detail.valid?
    assert_includes @detail.errors.messages[:email], 'has already been taken'
  end

  test 'should not allow duplicate email address check case sensitive' do
    @detail.email = Detail.first.email.upcase
    assert_not @detail.valid?
    assert_includes @detail.errors.messages[:email], 'has already been taken'
  end

  test 'phone number should be optional' do
    @detail.phone = nil
    assert @detail.valid?
  end

  def invalid_email_patterns
    ['user@domain',
     'user@domain.',
     'user@.domain.com',
     'user@domain_com',
     'user@-domain.com',
     'user@domain-.com',
     'user@domain..com',
     'user@domain.com.']
  end

  test 'should not accept invalid email pattern' do
    invalid_email_patterns.each do |invalid_email|
      @detail.email = invalid_email
      assert_not @detail.valid?
    end
  end

  def valid_email_patterns
    ['user@example.com',
     'user.name@example.com',
     'user123@example.com',
     'user_name@example.com',
     'user-name@example.com',
     'user+name@example.com',
     'user_name123@example.com',
     'user123.name@example.com',
     'user@example.co.uk',
     'user@example-domain.com',
     'user@example.studio',
     'user@example.io']
  end

  test 'should accept valid email pattern' do
    valid_email_patterns.each do |valid_email|
      @detail.email = valid_email
      assert @detail.valid?
    end
  end

  test 'person should be present after child destroyed' do
    detail = Detail.last
    person_id = detail.person_id
    detail.destroy
    assert Person.find_by(id: person_id)
  end
end
