# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  title      :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @email = 'andrew@rails.ruby'
    @person = Person.new(name: 'Andrew', title: 'Prof.', details_attributes: [{ email: @email }])
    @titles_value = Person.titles.values.join(', ')
  end

  test 'should be valid' do
    assert @person.valid?
  end

  test 'name should not be less than 2 chars.' do
    @person.name = '*'
    assert_not @person.valid?, 'Name length should not be lesser than 2 characters'
  end

  test 'name should be more than 72 chars.' do
    @person.name = '*' * 73
    assert_not @person.valid?, 'Name length should not be greater than 72 characters'
  end

  test 'name should not be empty' do
    @person.name = ''
    assert_not @person.valid?, 'Name should not be empty'
  end

  test 'name should accept foreign or international characters' do
    @person.name = 'ありがとう சிவா'
    assert @person.valid?, 'Name should allow foreign languages'
  end

  test 'title should be within list' do
    assert_raises ArgumentError, "Title value should contain any one of this #{@titles_value}" do
      @person.title = 'Sr.'
    end
  end

  test 'title should allow blank' do
    @person.title = ''
    assert @person.valid?, 'title should not be blank'
  end

  test 'title should allow nil' do
    @person.title = nil
    assert @person.valid?, 'title should not be nil'
  end

  test 'should be valid without details data' do
    person = Person.new(name: 'Andrew')
    assert person.valid?, 'should save without details'
  end

  test 'age should be numeric' do
    @person.age = 29.45
    assert_not @person.valid?, 'age should be number'
  end

  test 'age should not be lesser than 1' do
    @person.age = -45
    assert_not @person.valid?, 'age should be lesser than 1'
  end

  test 'age should not be greater than 100' do
    @person.age = 101
    assert_not @person.valid?, 'age should be greater than 100'
  end

  test 'age should not optional' do
    @person.age = nil
    assert @person.valid?, 'age should be optional'
  end

  test 'details attributes should not be empty' do
    assert_raises ActiveRecord::AssociationTypeMismatch do
      @person.details = [{}]
    end
  end

  test 'should save to database' do
    assert_difference 'Person.count', 1 do
      @person.save
    end
  end

  test 'saved data should have person id' do
    @person.save
    assert_not_nil @person.id
  end

  test 'saved data should have person name' do
    @person.save
    assert_equal 'Andrew', @person.name
  end

  test 'saved data should have title' do
    @person.save
    assert_equal 'Prof.', @person.title
  end

  test 'should strip name' do
    @person.name = '\tgoodbye\r\n'
    @person.save
    assert @person.name = 'goodbye', 'should strip name value'
  end

  test 'should not save if name has only none tab characters' do
    @person.name = "\x00\t\n\v\f\r"
    assert_not @person.save, 'should squish name value'
  end

  test 'saved data should return details' do
    assert @person.save
    assert_not_empty @person.details, 'should return details data'
  end

  test 'saved data should have correct email details' do
    @person.save
    assert_equal 'andrew@rails.ruby', @person.details.first.email, 'should return email from details data'
  end

  test 'should have valid email error message if details data doesn\'t have email' do
    person = Person.new(name: 'Andrew',
                        details_attributes: [{ phone: 1_000_010 },
                                             { email: 'test@rubyonrails.com', phone: '+130000000' }])
    person.save
    assert_includes person.errors.messages[:'details.email'], 'is invalid'
  end

  test 'email should not be duplicated in details data' do
    person = Person.new(name: 'Andrew',
                        details_attributes: [{ email: Detail.first.email },
                                             { email: 'test@rubyonrails.com', phone: '+130000000' }])
    assert_not person.valid?
    assert_includes person.errors.messages[:'details.email'], 'has already been taken'
  end

  test 'name should not be empty on update' do
    person = Person.first
    person.name = ''
    assert_not person.save, 'name should not be empty on update'
  end

  test 'title should not be empty on update' do
    person = Person.first
    msg = "title should be valid on update. Must contain any one of the following #{@titles_value}"
    assert_raises ArgumentError, msg do
      person.title = 'Sr.'
      person.save
    end
  end

  test 'person should not present after destroyed' do
    person = Person.first
    person_id = person.id
    person.destroy
    assert_nil Person.find_by(id: person_id)
  end

  test 'details should be destroyed after person destroyed' do
    person = Person.first
    detail_ids = person.details.ids
    person.destroy
    assert_empty Detail.where(id: detail_ids)
  end
end
