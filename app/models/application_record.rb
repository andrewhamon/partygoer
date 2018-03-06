class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.openstruct_accessor(column, *fields)
    fields.each do |field_name|
      define_method(field_name) do
        return instance_variable_get("@#{field_name}") if instance_variable_get("@#{field_name}")

        instance_variable_set(
          "@#{field_name}",
          JSON.parse(
            send(column).with_indifferent_access[field_name].to_json,
            object_class: OpenStruct,
          ),
        )
      end
    end
  end
end
