Given(/^I am on Google Maps$/) do
  @browser.goto 'www.google.com/maps'
  on(MainNavigation).wait_for_search
end

And(/^I input Philadelphia as my starting point and San Fransisco as my destination$/) do
  on(MainNavigation).search_input_element.set 'Philadelphia to San Fransisco'
  @current_page.search_element.double_click
end

Then(/^directions should appear on screen$/) do
  on(DirectionDetails).directions_section_element.present?
end

Given(/^I am using (.*) directions$/) do |movement_type|
  case movement_type
  when 'driving'
    on(MainNavigation).driving_element.click
  when 'public transport'
    on(MainNavigation).public_transport_element.click
  when 'biking'
    on(MainNavigation).biking_element.click
  when 'walking'
    on(MainNavigation).walking_element.click
  when 'flying'
    on(MainNavigation).flying_element.click
  end
end