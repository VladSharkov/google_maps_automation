Given(/^I am on Google Maps$/) do
  @browser.goto 'www.google.com/maps'
end

And(/^I input Philadelphia as my starting point and San Fransisco as my destination$/) do
  @browser.text_field(id: 'searchboxinput').set 'Philadelphia to San Fransisco'
  @browser.button(id: 'searchbox-searchbutton').double_click
end

Then(/^directions should appear on screen$/) do
  @browser.div(id: 'section-directions-trip-travel-mode-0').present?
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

Then(/^I can see the direction details section$/) do
  on(DirectionDetails).check_for_details
end

When(/^I click the details button$/) do
  on(DirectionDetails).details
end

And(/^I can click on arrows to see more specifics$/) do
  on(DirectionDetails).see_specifics
end

And(/^I can click the arrows to remove the specifics$/) do
  on(DirectionDetails).hide_specifics
end

When(/^I click through the details of various routes$/) do
  on(DirectionDetails).check_bus_routes
end

Then(/^I will see different results$/) do
  expect($directions_array.reject {|c| c.empty?}.uniq.length).to eq $number_of_routes
end

Then(/^I will see direction details associated with (.*)$/) do |movement_type|
  on(DirectionDetails).trip_details_element.present?
  @current_page.trip_summary_element.text.include? 'Your destination is in a different time zone'
  case movement_type
  when 'walking'
    @current_page.walking_warnings_element.text.include? 'walking directions may not always'
  when 'biking'
    @current_page.biking_warnings_element.text.include? 'bicycling directions may not always'
  end
  # @browser.div(class: 'section-trip-details').present?
  # @browser.div(class: 'section-trip-summary noprint').text.include? 'Your destination is in a different time zone'
  # case movement_type
  # when 'walking'
  #   @browser.div(xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[2]').text.include? 'walking directions may not always'
  # when 'biking'
  #   @browser.div(xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[1]').text.include? 'bicycling directions may not always'
  # end
end

And(/^(.*) are a part of the initial directions$/) do |option|
  case option
  when 'highways'
    expect(on(DirectionDetails).details_section_element.text.include? 'via I-').to eq true
  when 'tolls'
    expect(on(DirectionDetails).details_section_element.text.include? 'This route has tolls').to eq true
  when 'ferries'
    expect(on(DirectionDetails).details_section_element.text.include? 'This route includes a ferry').to eq true
  end
end


When(/^I click avoid (.*) from the direction options$/) do |avoiding|
  @browser.button(class: 'section-directions-options-link').click
  case avoiding
  when 'highways'
    @browser.label(text: 'Highways').click
  when 'tolls'
    @browser.label(text: 'Tolls').click
  when 'ferries'
    @browser.label(text: 'Ferries').click
  end
end

Then(/^the direction details will not include (.*)$/) do |option|
  case option
  when 'highways'
    expect(on(DirectionDetails).details_section_element.text.include? 'via I-').to eq false
  when 'tolls'
    expect(on(DirectionDetails).details_section_element.text.include? 'This route has tolls').to eq false
  when 'ferries'
    expect(on(DirectionDetails).details_section_element.text.include? 'This route includes a ferry').to eq false
  end
end

When(/^I switch to distance in (.*)$/) do |measurement|
  @browser.button(class: 'section-directions-options-link').click unless @browser.label(text: 'km').present?
  case measurement
  when 'kilometers'
    @browser.label(text: 'km').click
  when 'miles'
    @browser.label(text: 'miles').click
  end
end

Then(/^(.*) will show up in the directions$/) do |measurement|
  case measurement
  when 'kilometers'
    expect(@browser.div(class: 'section-directions-trip-description').text.match /\d km/).to_not eq nil
    expect(@browser.div(class: 'section-directions-trip-description').text.match /\d miles/).to eq nil
  when 'miles'
    expect(@browser.div(class: 'section-directions-trip-description').text.match /\d miles/).to_not eq nil
    expect(@browser.div(class: 'section-directions-trip-description').text.match /\d km/).to eq nil
  end
end