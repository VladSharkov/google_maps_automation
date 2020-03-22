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
end