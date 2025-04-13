ActiveRecord::Base.transaction do

  tenancy = Tenant.find_by(subdomain: "altos-de-berlin")
  Apartment::Tenant.switch!(tenancy.subdomain)

  enterprise = Enterprise.find_by(token: tenancy.token, subdomain: tenancy.subdomain)
  aparament = 0
  floor = 1

  10.times do
    aparament += 1

    if aparament == 9
      aparament = 1
      floor += 1
    end

    reference =  "T1-P#{floor}-A#{floor}0#{aparament}"
    cc = "#{20 + Random.rand(100000)}#{20 + Random.rand(100000)}"

    allowed_params = {
      name: FFaker::Name.first_name,
      lastname: FFaker::Name.last_name,
      identifier: cc,
      email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
      reference: reference,
      phone: cc,
      password: 'test123',
      password_confirmation: 'test123'
    }

    puts allowed_params

    ::Users::SignUpService.new(enterprise: enterprise, data: allowed_params).call
  end
end
