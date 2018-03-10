class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.openstruct_accessor(column, *fields)
    fields.each do |field_name|
      define_method(field_name) do
        return instance_variable_get("@#{field_name}") if instance_variable_get("@#{field_name}")

        struct = JSON.parse(send(column).to_json, object_class: OpenStruct)

        instance_variable_set(
          "@#{field_name}",
          struct.send(field_name),
        )
      end
    end
  end
end
