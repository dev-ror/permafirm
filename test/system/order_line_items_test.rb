require "application_system_test_case"

class OrderLineItemsTest < ApplicationSystemTestCase
  setup do
    @order_line_item = order_line_items(:one)
  end

  test "visiting the index" do
    visit order_line_items_url
    assert_selector "h1", text: "Order Line Items"
  end

  test "creating a Order line item" do
    visit order_line_items_url
    click_on "New Order Line Item"

    click_on "Create Order line item"

    assert_text "Order line item was successfully created"
    click_on "Back"
  end

  test "updating a Order line item" do
    visit order_line_items_url
    click_on "Edit", match: :first

    click_on "Update Order line item"

    assert_text "Order line item was successfully updated"
    click_on "Back"
  end

  test "destroying a Order line item" do
    visit order_line_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order line item was successfully destroyed"
  end
end
