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

  test 'should get edit' do
    get edit_person_detail_url(@person, @detail)
    assert_response :success
  end

  test 'should update detail' do
    patch person_detail_url(@person, @detail), params: { detail: { age: 99 } }
    assert_redirected_to person_url(@person)
  end

  test 'should destroy detail' do
    assert_difference('Detail.count', -1) do
      delete person_detail_url(@person, @detail)
    end

    assert_redirected_to person_url(@person)
  end
end
