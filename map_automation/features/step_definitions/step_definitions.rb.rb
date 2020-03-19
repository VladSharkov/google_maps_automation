Given(/^I am on Google Maps$/) do
  @browser.goto 'www.google.com/maps'
end

And(/^I input Philidelphia and San Fransisco as my starting point and destination$/) do
  @browser.text_field(id: 'searchboxinput').set 'Philidelphia to San Fransisco'
  @browser.button(id: 'searchbox-searchbutton').click
end

Then(/^directions should appear on screen$/) do
  pending
end

Given /^hello$/ do
  ninja = binja
end