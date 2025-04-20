namespace :import do
  desc 'Generate XLSX template for properties import'
  task xlsx: :environment do
    tenant_name = 'altos-de-berlin'

    begin
      Apartment::Tenant.switch!(tenant_name)
      puts "Switched to tenant: #{tenant_name}"

      user = User.first
      puts "Using user: #{user.email}"

      structure = Properties::Template::StructureService.new(user: user).call
      xlsx_service = Properties::Template::XlsxService.new(structure: structure)
      xlsx_content = xlsx_service.call.to_stream.read

      # Guardar el archivo en tmp
      filename = "properties_import_template_#{Time.current.strftime('%Y%m%d_%H%M%S')}.xlsx"
      filepath = Rails.root.join('tmp', filename)

      File.binwrite(filepath, xlsx_content)

      puts "XLSX template generated successfully at: #{filepath}"
    rescue StandardError => e
      puts "Error generating XLSX template for tenant #{tenant_name}: #{e.message}"
    end
  end
end
