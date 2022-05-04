# frozen_string_literal: true

require 'test_helper'

class TurnosControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get turnos_new_url
    assert_response :success
  end

  test 'should get index' do
    get turnos_index_url
    assert_response :success
  end

  test 'should get show' do
    get turnos_show_url
    assert_response :success
  end

  test 'should get edit' do
    get turnos_edit_url
    assert_response :success
  end
end
