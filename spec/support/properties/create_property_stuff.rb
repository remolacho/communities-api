shared_context 'create_property_stuff' do
  include RequestHelpers

  let(:user) { current_user }

  let(:data_error_name){
    [
      {
        name: nil,
        attributes: [
          {
            name: {es: "Torre"},
            min_range: 1,
            max_range: 4
          },
          {
            name: {es: "Piso"},
            min_range: 1,
            max_range: 16
          },
          {
            name: {es: "Número"},
            min_range: 1,
            max_range: 8,
            prefix: 0
          },
        ]
      }
    ]
  }

  let(:data_error_name_attr){
    [
      {
        name: {es: "Apartamento"},
        attributes: [
          {
            name: {es: "Torre"},
            min_range: 1,
            max_range: 4
          },
          {
            name: nil,
            min_range: 1,
            max_range: 16
          },
          {
            name: {es: "Número"},
            min_range: 1,
            max_range: 8,
            prefix: 0
          },
        ]
      }
    ]
  }

  let(:data_success){
    [
      {
        name: {es: "Apartamento"},
        attributes: [
          {
            name: {es: "Torre"},
            min_range: 1,
            max_range: 4
          },
          {
            name: {es: "Piso"},
            min_range: 1,
            max_range: 16
          },
          {
            name: {es: "Número"},
            min_range: 1,
            max_range: 8,
            prefix: 0
          },
        ]
      }
    ]
  }
end
