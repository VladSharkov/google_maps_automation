class DirectionDetails

  include PageObject

  button :details, {'aria-labelledby' => 'section-directions-trip-details-msg-0'}
  button :back, {'aria-label' => ' Back '}
  div :directions_section, id: 'section-directions-trip-travel-mode-0'
  div :trip_details, class: 'section-trip-details'
  div :trip_summary, class: 'section-trip-summary noprint'
  div :details_section, class: 'section-directions-trip-description'

  def check_for_details
    self.trip_details_element.present?
    self.trip_summary_element.text.include? 'Your destination is in a different time zone'
  end

  #----------------------------------DRIVING SECTION-----------------------------------------

  #This method clicks on each arrow on the page to show the direction specifics and checks to see that the particular
  #expected sections under each arrow show up.
  def see_specifics
    until self.trip_details_element.text.include? 'Philadelphia'
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

  #This method clicks on all arrows on the page to hide the specific directions beneath and validates that those
  #sections are indeed hidden.
  def hide_specifics
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

  #------------------------------------BUS SECTION-----------------------------------------

  div :bus_details, class: 'section-directions-trip-description'
  div :bus_route_specifics, class: 'transit-mode-body'

  #This method clicks into each bus route, grabs the text from each route and places it in an array, and, in the end,
  #compares text objects in the array to make sure none are empty and all are unique.
  def check_bus_routes
    until self.bus_details_element.present? and self.details_element.present?
      sleep 0.1
    end
    $number_of_routes = @browser.divs(id: /section-directions-trip-travel-mode-/).length
    route_index = 0
    $directions_array = []
    while route_index < $number_of_routes
      until self.bus_route_specifics_element.present?
        @browser.div(id: /section-directions-trip-travel-mode-#{route_index}/).click
        sleep 0.5
      end
      $directions_array << @browser.div(class: 'transit-mode-body').text
      self.back
      until self.details_section_element.present?
        sleep 0.1
      end
      route_index += 1
      @browser.div(id: "section-directions-trip-travel-mode-#{route_index}").click if route_index < $number_of_routes
    end
  end

  #------------------------------------WALKING SECTION---------------------------------------

  div :walking_warnings, {xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[2]'}

  #------------------------------------BIKING SECTION----------------------------------------

  div :biking_warnings, {xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[1]'}

end