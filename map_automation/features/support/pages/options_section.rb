class OptionsSection

  include PageObject

  button :options, class: 'section-directions-options-link'
  label :highways, text: 'Highways'
  label :tolls, text: 'Tolls'
  label :ferries, text: 'Ferries'
  label :miles, text: 'miles'
  label :km, text: 'km'

end