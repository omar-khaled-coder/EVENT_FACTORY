require "application_system_test_case"

class SpacesTest < ApplicationSystemTestCase
  setup do
    @space = spaces(:one)
  end

  test "visiting the index" do
    visit spaces_url
    assert_selector "h1", text: "Spaces"
  end

  test "should create space" do
    visit spaces_url
    click_on "New space"

    fill_in "Address", with: @space.address
    fill_in "Amenities", with: @space.amenities
    fill_in "Capacity", with: @space.capacity
    fill_in "City", with: @space.city
    fill_in "Country", with: @space.country
    fill_in "Description", with: @space.description
    fill_in "End date", with: @space.end_date
    check "Is daily available" if @space.is_daily_available
    check "Is hourly available" if @space.is_hourly_available
    fill_in "Owner", with: @space.owner_id
    fill_in "Postal code", with: @space.postal_code
    fill_in "Price per day", with: @space.price_per_day
    fill_in "Price per hour", with: @space.price_per_hour
    fill_in "Space type", with: @space.space_type
    fill_in "Start date", with: @space.start_date
    fill_in "State", with: @space.state
    fill_in "Title", with: @space.title
    click_on "Create Space"

    assert_text "Space was successfully created"
    click_on "Back"
  end

  test "should update Space" do
    visit space_url(@space)
    click_on "Edit this space", match: :first

    fill_in "Address", with: @space.address
    fill_in "Amenities", with: @space.amenities
    fill_in "Capacity", with: @space.capacity
    fill_in "City", with: @space.city
    fill_in "Country", with: @space.country
    fill_in "Description", with: @space.description
    fill_in "End date", with: @space.end_date
    check "Is daily available" if @space.is_daily_available
    check "Is hourly available" if @space.is_hourly_available
    fill_in "Owner", with: @space.owner_id
    fill_in "Postal code", with: @space.postal_code
    fill_in "Price per day", with: @space.price_per_day
    fill_in "Price per hour", with: @space.price_per_hour
    fill_in "Space type", with: @space.space_type
    fill_in "Start date", with: @space.start_date
    fill_in "State", with: @space.state
    fill_in "Title", with: @space.title
    click_on "Update Space"

    assert_text "Space was successfully updated"
    click_on "Back"
  end

  test "should destroy Space" do
    visit space_url(@space)
    click_on "Destroy this space", match: :first

    assert_text "Space was successfully destroyed"
  end
end
