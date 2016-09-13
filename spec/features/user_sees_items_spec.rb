require 'rails_helper'

RSpec.feature "User sees all the items" do
  context "when items already exist" do
    scenario "User visits items page with one item" do
      # Given an item exists
      # As a User
      # when I visit the items page
      # Then I expect to see the item
      Item.create(title: "Yak", description: "It is a yak", price: "150")

      visit items_path

      expect(page).to have_content "Yak"
    end

    scenario "User visits items page with many items" do
      # Given items exist
      # As a User
      # when I visit the items page
      # Then I expect to see all the items
      Item.create(title: "Yak", description: "It is a yak", price: "150")
      Item.create(title: "Silk Yarn", description: "For all your silk making needs", price: "23")
      Item.create(title: "Yo-Yo", description: "It goes away, and comes back!", price: "5")

      visit items_path

      expect(page).to have_content "Yak"
      expect(page).to have_content "Silk Yarn"
      expect(page).to have_content "Yo-Yo"
    end
  end
end
