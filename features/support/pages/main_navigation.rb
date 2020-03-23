class MainNavigation

  include PageObject

  text_field :search_input, id: 'searchboxinput'
  button :search, id: 'searchbox-searchbutton'
  button :satellite, {'aria-labelledby' => 'widget-minimap-caption'}

  div :driving, {'aria-label' => 'Driving'}
  div :public_transport, {'aria-label' => 'Transit'}
  div :biking, {'aria-label' => 'Cycling'}
  div :walking, {'aria-label' => 'Walking'}
  div :flying, {'aria-label' => 'Flights'}

  def wait_for_search
    until elements_present?
      sleep 0.1
    end
  end

  #Rescue for Selenium issue on macs
  def elements_present?
    begin
      present = (self.search_input_element.present? and self.satellite_element.present?)
    rescue Selenium::WebDriver::Error::UnknownError
      present = false
    end
    present
  end

end