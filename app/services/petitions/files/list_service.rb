# frozen_string_literal: true

class Petitions::Files::ListService
  attr_accessor :user, :petition, :enterprise

  def initialize(enterprise:, user:, petition:)
    @enterprise = enterprise
    @user = user
    @petition = petition
  end

  def call
    petition.files.map do |file|
      {
        name: file.filename.to_s,
        ext: File.extname(file.filename.to_s),
        url: petition.file_url(file, enterprise.subdomain)
      }
    end
  end
end
