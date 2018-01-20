module DataAccess
  module Builder

    module ClassMethods

      def builds_object(object_name, class_name: self, mappings: {})
        new_object = OpenStruct.new(object_name: object_name, class_name: class_name, mappings: mappings)

        define_builder_method_with(new_object)
      end

      private 

        def define_builder_method_with(new_object)
          define_singleton_method "build_#{new_object.object_name}_with" do |data| 
            build(new_object, data)
          end
        end

        def build(new_object, data)
          data.is_a?(Array) ? data.map { |d| instantiate(new_object, d) } : instantiate(new_object, data)
        end

        def instantiate(new_object, data)
          object_class = object_class_for(new_object)

          object_class.new(map_parameters_with_data(param_mappings: new_object.mappings, data: data)) unless data.empty?
        end

        def object_class_for(new_object)
          const_get(new_object.object_name.to_s.singularize.camelize) rescue const_get(new_object.class_name.to_s)
        end

    end

    module InstanceMethods

      def initialize(attributes = {})
        attributes.each { |k, v| instance_variable_set("@#{k}", v) }
      end

    end

    def self.included(receiver)
      receiver.extend         DataAccess::Mapper
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end

  end
end