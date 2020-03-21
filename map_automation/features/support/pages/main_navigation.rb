class MainNavigation

  include PageObject

  div :driving, {'aria-label' => 'Driving'}
  div :public_transport, {'aria-label' => 'Transit'}
  div :biking, {'aria-label' => 'Cycling'}
  div :walking, {'aria-label' => 'Walking'}
  div :flying, {'aria-label' => 'Flights'}


end