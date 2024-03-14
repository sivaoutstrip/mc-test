require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test 'should get index' do
    get people_url
    assert_response :success
  end

  test 'should get new' do
    get new_person_url
    assert_response :success
  end

  test 'should redirect to root if params nil' do
    post people_url, params: nil

    assert_response :redirect
    assert_redirected_to root_url
  end

  test 'should redirect to root url if title is invalid' do
    post people_url, params: { person: { title: 'Sr.' } } 

    assert_response :unprocessable_entity
  end

  test 'should create person' do
    assert_difference('Person.count') do
      post people_url, params: { person: { name: 'George' } }
    end

    assert_redirected_to people_url
  end

  test 'should show person' do
    get person_url(@person)
    assert_response :success
  end

  test 'should redirect to people page if person is invalid' do
    person_id = 'invalid'
    get person_url(person_id)
    assert_response :redirect
    assert_redirected_to people_url
  end

  test 'should get edit' do
    get edit_person_url(@person)
    assert_response :success
  end

  test 'should update person' do
    put person_url(@person), params: { person: { name: 'George VI' } }
    assert_redirected_to people_url
  end

  test 'should return error message if person name is empty' do
    put person_url(@person), params: { person: { name: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy person' do
    assert_difference('Person.count', -1) do
      delete person_url(@person)
    end

    assert_redirected_to people_url
  end
end
