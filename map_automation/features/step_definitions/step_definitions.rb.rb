Given(/^I am on Google Maps$/) do
  @browser.goto 'www.google.com/maps'
end

And(/^I input Philadelphia as my starting point and San Fransisco as my destination$/) do
  @browser.text_field(id: 'searchboxinput').set 'Philadelphia to San Fransisco'
  @browser.button(id: 'searchbox-searchbutton').click
end

Then(/^directions should appear on screen$/) do
  @browser.div(id: 'section-directions-trip-travel-mode-0').present?
end

Given /^hello$/ do
  @ninja = binjacrinja
  @browser.button.click
end

Given(/^I am using (.*) directions$/) do |movement_type|
  case movement_type
  when 'driving'
    @browser.div('aria-label' => 'Driving').click
  when 'public transport'
    @browser.div('aria-label' => 'Transit').click
  when 'biking'
    @browser.div('aria-label' => 'Cycling').click
  when 'walking'
    @browser.div('aria-label' => 'Walking').click
  when 'flying'
    @browser.div('aria-label' => 'Flights').click
  end
end

Then(/^I can see the direction details section$/) do
  @browser.div(class: 'section-trip-details').present?
  @browser.div(class: 'section-trip-summary noprint').text.include? 'Your destination is in a different time zone'
end

When(/^I click the details button$/) do
  @browser.button('aria-labelledby' => 'section-directions-trip-details-msg-0').click
end

And(/^I can click on arrows to see more specifics$/) do
  until @browser.div(class: 'directions-text-waypoint first-waypoint').text.include? 'Philadelphia'
    sleep 0.1
  end
  number_of_arrows = @browser.buttons('aria-labelledby' => /directions-mode-group-title/).length
  arrow_index = 0
  while arrow_index < number_of_arrows
    until @browser.div(id: /hideable_nontransit_0_#{arrow_index}/, style: /visibility: visible/).present?
      @browser.button('aria-labelledby' => /directions-mode-group-title_0_#{arrow_index}/).click
      sleep 0.5
    end
    arrow_index += 1
  end
end

And(/^I can click the arrows to remove the specifics$/) do
  number_of_arrows = @browser.buttons('aria-labelledby' => /directions-mode-group-title/).length
  arrow_index = 0
  while arrow_index < number_of_arrows
    until @browser.div(id: /hideable_nontransit_0_#{arrow_index}/, style: /visibility: hidden/).exists?
      @browser.button('aria-labelledby' => /directions-mode-group-title_0_#{arrow_index}/).click
      sleep 0.5
    end
    arrow_index += 1
  end
end

When(/^I click through the details of various routes$/) do
  until @browser.div(class: 'section-directions-trip-description').text.include? 'Philadelphia'
    sleep 0.5
  end
  $number_of_routes = @browser.divs(id: /section-directions-trip-travel-mode-/).length
  route_index = 0
  $directions_array = []
  while route_index < $number_of_routes
    until @browser.div(class: 'transit-mode-body').present?
      @browser.div(id: /section-directions-trip-travel-mode-#{route_index}/).click
      # @browser.span(id: "section-directions-trip-details-msg-#{route_index}").click
      # @browser.button('aria-labelledby' => /section-directions-trip-details-msg-#{route_index}/).click
      sleep 0.5
    end
    $directions_array << @browser.div(class: 'transit-mode-body').text
    @browser.button('aria-label' => ' Back ').click
    sleep 3
    route_index += 1
    # 3.times {@browser.send_keys :tab}
    @browser.div(id: "section-directions-trip-travel-mode-#{route_index}").click if route_index < $number_of_routes
  end

end

Then(/^I will see different results$/) do
  expect($directions_array.reject {|c| c.empty?}.uniq.length).to eq $number_of_routes
end

Then(/^I will see direction details associated with (.*)$/) do |movement_type|
  @browser.div(class: 'section-trip-details').present?
  @browser.div(class: 'section-trip-summary noprint').text.include? 'Your destination is in a different time zone'
  case movement_type
  when 'walking'
    @browser.div(xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[2]').text.include? 'walking directions may not always'
  when 'biking'
    @browser.div(xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[1]').text.include? 'bicycling directions may not always'
  end
end

And(/^(.*) are a part of the initial directions$/) do |option|
  case option
  when 'highways'
    expect(@browser.div(class: 'section-directions-trip-description').text.include? 'via I-').to eq true
  when 'tolls'
    expect(@browser.div(class: 'section-directions-trip-description').text.include? 'This route has tolls').to eq true
  when 'ferries'
    expect(@browser.div(class: 'section-directions-trip-description').text.include? 'This route includes a ferry').to eq true
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
    expect(@browser.div(class: 'section-directions-trip-description').text.include? 'via I-').to eq false
  when 'tolls'
    expect(@browser.div(class: 'section-directions-trip-description').text.include? 'This route has tolls').to eq false
  when 'ferries'
    expect(@browser.div(class: 'section-directions-trip-description').text.include? 'This route includes a ferry').to eq false
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