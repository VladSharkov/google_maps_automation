# google_maps_automation
Ruby Cucumber automation tests for Google Maps

Required to run:
1. Ruby: https://rubyinstaller.org/downloads/ (basic download and install)
2. ChromeDriver: https://chromedriver.chromium.org/downloads (download the correct version for your current version of Chrome, and place
the file anywhere in your system's PATH. A restart may be required)
3. Bundler: Once ruby is installed, run 'gem install bundler' in your command line
4. Cucumber + other required gems: Once bundler is installed, go to your command line and navigate to the main project directory, which
contains the Gemfile, and run 'bundle install'

Optional (if Firefox is preffered to Chrome) -> GeckoDriver: https://github.com/mozilla/geckodriver/releases (download the correct version
for your current version of Firefox, place the file anywhere in your system's PATH + go into the 'hooks.rb' file in the project and
change ":chrome" to ":firefox" on line 5. A restart may be required)

Use the following command to run the tests from the main project directory:
cucumber --init --color -r features -f pretty -f html -o reports/last_run.html
