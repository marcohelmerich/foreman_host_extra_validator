module ForemanHostExtraValidator
  module HostExtensions
    extend ActiveSupport::Concern
    included do
      validate :validate_name_by_regex
    end

    def validate_name_by_regex
      return unless validate_name_regex.present?
      errors.add(:name, _('must match regex /%s/') % validate_name_regex) unless shortname =~ /#{validate_name_regex}/
    end

    private

    def validate_name_regex
      inherited_params_hash.dig('host_name_validation_regex', :value) || Setting[:host_name_validation_regex]
    end
  end
end
