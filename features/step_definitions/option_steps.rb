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
  on(OptionsSection).options
  case avoiding
  when 'highways'
    @current_page.highways_element.click
  when 'tolls'
    @current_page.tolls_element.click
  when 'ferries'
    @current_page.ferries_element.click
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
  on(OptionsSection).options unless on(OptionsSection).km_element.present?
  case measurement
  when 'kilometers'
    @current_page.km_element.click
  when 'miles'
    @current_page.miles_element.click
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