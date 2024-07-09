require "test_helper"

class SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = spaces(:one)
  end

  test "should get index" do
    get spaces_url
    assert_response :success
  end

  test "should get new" do
    get new_space_url
    assert_response :success
  end

  test "should create space" do
    assert_difference("Space.count") do
      post spaces_url, params: { space: { address: @space.address, amenities: @space.amenities, capacity: @space.capacity, city: @space.city, country: @space.country, description: @space.description, end_date: @space.end_date, is_daily_available: @space.is_daily_available, is_hourly_available: @space.is_hourly_available, owner_id: @space.owner_id, postal_code: @space.postal_code, price_per_day: @space.price_per_day, price_per_hour: @space.price_per_hour, space_type: @space.space_type, start_date: @space.start_date, state: @space.state, title: @space.title } }
    end

    assert_redirected_to space_url(Space.last)
  end

  test "should show space" do
    get space_url(@space)
    assert_response :success
  end

  test "should get edit" do
    get edit_space_url(@space)
    assert_response :success
  end

  test "should update space" do
    patch space_url(@space), params: { space: { address: @space.address, amenities: @space.amenities, capacity: @space.capacity, city: @space.city, country: @space.country, description: @space.description, end_date: @space.end_date, is_daily_available: @space.is_daily_available, is_hourly_available: @space.is_hourly_available, owner_id: @space.owner_id, postal_code: @space.postal_code, price_per_day: @space.price_per_day, price_per_hour: @space.price_per_hour, space_type: @space.space_type, start_date: @space.start_date, state: @space.state, title: @space.title } }
    assert_redirected_to space_url(@space)
  end

  test "should destroy space" do
    assert_difference("Space.count", -1) do
      delete space_url(@space)
    end

    assert_redirected_to spaces_url
  end
end
