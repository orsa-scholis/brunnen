# frozen_string_literal: true

require 'administrate/field/has_many'

class ScopedHasManyField < Administrate::Field::HasMany
  def associated_resource_options
    custom_candidate_resources.map do |resource|
      [display_candidate_resource(resource), resource.send(primary_key)]
    end
  end

  private

  def custom_candidate_resources
    first_data = data&.first

    if options[:scope]
      options[:scope].call(first_data)
    else
      associated_class.all
    end
  end
end
