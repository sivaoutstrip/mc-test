require 'test_helper'

class DetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
    @detail = details(:one)
  end

  test 'should get index' do
    get person_details_url(@person)
    assert_response :success
  end

  test 'should get new' do
    get new_person_detail_url(@person)
    assert_response :success
  end

  test 'should redirect to people url if person is invalid' do
    get new_person_detail_url('10010001')
    assert_redirected_to people_url
  end

  test 'should display errors if person not valid' do
    post person_details_url(@person), params: { detail: { email: '' } }
    assert_response :unprocessable_entity
  end

  test 'should create detail' do
    assert_difference('Detail.count') do
      post person_details_url(@person), params: { detail: { email: 'george.vi@rails.ruby' } }
    end

    assert_redirected_to person_url(@person)
  end

  test 'should show detail' do
    get person_detail_url(@person, @detail)
    assert_response :success
  end

  test 'should redirect to people url if detail is invalid' do
    get person_detail_url(@person, '10010001')
    assert_redirected_to people_url
  end

  test 'should get edit' do
    get edit_person_detail_url(@person, @detail)
    assert_response :success
  end

  test 'should update detail' do
    put person_detail_url(@person, @detail), params: { detail: { email: 'hello@hello.hello' } }
    assert_redirected_to person_url(@person)
  end

  test 'should return error message if email is empty' do
    put person_detail_url(@person, @detail), params: { detail: { email: 'hello' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy detail' do
    assert_difference('Detail.count', -1) do
      delete person_detail_url(@person, @detail)
    end

    assert_redirected_to person_url(@person)
  end
end
