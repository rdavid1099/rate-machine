require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest
  test 'shows a single rating' do
    rating = Rating.create(product_id: 1, user_id: 1, title: 'Test', body: 'Test Body')
    get "/ratings/#{rating.id}"

    assert_equal 200, status
  end

  test 'shows the ratings for a single product' do
    Rating.create(product_id: 1, user_id: 1, title: 'Test', body: 'Test Body')
    Rating.create(product_id: 1, user_id: 1, title: 'Test', body: 'Test Body')
    Rating.create(product_id: 2, user_id: 1, title: 'Test', body: 'Test Body')
    get "/ratings?product_id=1"

    assert_equal 200, status
    assert_equal 2, response.parsed_body.count
  end

  test 'ratings can be created using http' do
    post '/ratings?product_id=1&user_id=1&title=this&body=test'

    assert_equal 200, status
    assert_equal 'this', Rating.last.title
    assert_equal 'test', Rating.last.body
  end

  test 'ratings can be edited using http' do
    rating = Rating.create(product_id: 1, user_id: 1, title: 'Test', body: 'Test Body')
    put "/ratings/#{rating.id}?title=test"

    assert_equal 200, status
    assert_equal 'test', Rating.last.title
  end

  test 'ratings can be deleted using http' do
    rating = Rating.create(product_id: 1, user_id: 1, title: 'Test', body: 'Test Body')
    delete "/ratings/#{rating.id}"

    assert_equal 200, status
    assert_equal 0, Rating.count
    assert_equal 'Rating Successfully Deleted', response.parsed_body['status']
  end
end
