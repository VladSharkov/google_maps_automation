class DirectionDetails

  include PageObject

  button :details, {'aria-labelledby' => 'section-directions-trip-details-msg-0'}
  div :trip_details, class: 'section-trip-details'
  div :trip_summary, class: 'section-trip-summary noprint'
  div :details_section, class: 'section-directions-trip-description'

  def check_for_details
    self.trip_details_element.present?
    self.trip_summary_element.text.include? 'Your destination is in a different time zone'
  end

  #----------------------------------DRIVING SECTION-----------------------------------------

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

  def check_bus_routes
    until self.bus_details_element.present?
      sleep 0.5
    end
    $number_of_routes = @browser.divs(id: /section-directions-trip-travel-mode-/).length
    route_index = 0
    $directions_array = []
    while route_index < $number_of_routes
      until @browser.div(class: 'transit-mode-body').present?
        @browser.div(id: /section-directions-trip-travel-mode-#{route_index}/).click
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

  #------------------------------------WALKING SECTION---------------------------------------

  div :walking_warnings, {xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[2]'}

  #------------------------------------BIKING SECTION----------------------------------------

  div :biking_warnings, {xpath: '//*[@id="pane"]/div/div[1]/div/div/div[5]/div/div/div[1]/div/div[2]/div[2]/div[1]/div[1]'}

end