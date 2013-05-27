require 'spec_helper'

feature "an admin CRUDing cities" do
  Given { User.create!(email: "admin@railsgirls.co.uk", password: "admin12345") }

  Given do
    visit new_user_session_path

    fill_in "Email", with: "admin@railsgirls.co.uk"
    fill_in "Password", with: "admin12345"
    click_on "Sign in"
  end

  context "creating cities" do
    When do
      expect { find(".cities a") }.to raise_error

      click_link "New city"

      fill_in "Name", with: "London"
      click_on "Create City"
    end

    Then do
      expect(page).to have_content("London")

      visit root_path

      find(".cities a").should have_text "London"
    end
  end
end

