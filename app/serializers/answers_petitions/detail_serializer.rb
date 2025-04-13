# frozen_string_literal: true

module AnswersPetitions
  class DetailSerializer < ActiveModel::Serializer
    attributes :id,
               :message,
               :updated_at,
               :created_at

    attribute :user
    attribute :files
    attribute :setting

    def user
      ::Users::BasicProfileSerializer.new(object.user,
                                          enterprise_subdomain: enterprise_subdomain)
    end

    def date_at
      object.created_at
    end

    def files
      temps = object.files || []

      temps.map do |file|
        {
          name: file.filename.to_s,
          ext: File.extname(file.filename.to_s),
          url: object.file_url(file, enterprise_subdomain)
        }
      end
    end

    def setting
      {
        delete: {
          action: can_delete?,
          description: 'Only can delete answer if the user is owner and status is different to resolved and reviewing'
        }
      }
    end

    private

    def enterprise_subdomain
      instance_options[:enterprise_subdomain]
    end

    def current_user
      instance_options[:current_user]
    end

    def can_delete?
      current_user.id.eql?(object.user_id) &&
        !object.petition.resolved? &&
        !object.petition.reviewing?
    end
  end
end
