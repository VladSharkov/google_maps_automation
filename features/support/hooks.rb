require 'watir'

Before do |scenario|
  DataMagic.load_for_scenario(scenario)
  @browser = Watir::Browser.new :chrome
end

After do |_scenario|
  if _scenario.failed?
    screenshot_filename = "#{_scenario.name.gsub(" ", "_")}_#{Time.now.to_s.gsub(" ", "_").gsub(":", "-")}"
    @browser.screenshot.save "screenshots/#{screenshot_filename}.png"
    embed 'screenshot.png', 'image/png'
  end
  @browser.close
end