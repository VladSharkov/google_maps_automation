Given(/^I am on Google Maps$/) do
  @browser.goto 'www.google.com/maps'
end

And(/^I input Philidelphia and San Fransisco as my starting point and destination$/) do
  @browser.text_field(id: 'searchboxinput').set 'Philidelphia to San Fransisco'
  @browser.button(id: 'searchbox-searchbutton').click
end

Then(/^directions should appear on screen$/) do
  @browser.div(id: 'section-directions-trip-travel-mode-0').present?
end

Given /^hello$/ do
  @ninja = binjacrinja
  @browser.button.click
end

Given(/^I am using driving directions$/) do
  @browser.div('aria-label' => 'Driving').click
end

Then(/^I can see the direction details section$/) do
  @browser.div(class: 'section-trip-details').present?
end

When(/^I click the details button$/) do
  @browser.button('aria-labelledby' => 'section-directions-trip-details-msg-0').click
end

And(/^I can click on arrows to see more specifics$/) do
  number_of_arrows = @browser.buttons('aria-labelledby' => /directions-mode-group-title/).length
  arrow_index = 0
  while arrow_index < number_of_arrows
    @browser.button('aria-labelledby' => /directions-mode-group-title_0_#{arrow_index}/).click
    @browser.div(id: /hideable_nontransit/).present?
    arrow_index += 1
  end
end

# directions-mode-group-title_0_0
# hideable_nontransit_0_0