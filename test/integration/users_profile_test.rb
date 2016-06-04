# -*- coding: utf-8 -*-
require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.deals.count.to_s, response.body
    assert_select 'div.pagination'
    @user.deals.paginate(page: 1).each do |deal|
      assert_match deal.empresa[0], response.body   # Se hace así por problemas de comparación 
      assert_match deal.empresa[-1], response.body  # de encodings con apóstrofes.
      assert_match deal.estado, response.body
      assert_match deal.producto, response.body
      assert_match deal.probabilidad.to_s, response.body
    end
  end
  
end
