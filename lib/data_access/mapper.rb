module DataAccess
  module Mapper

    private

      def map_parameters_with_data(param_mappings:, data:)
        Hash.new.tap do |parameter_list| 
          param_mappings.each { |obj_attribute, data_key| parameter_list.merge!( obj_attribute.to_sym => data_values(data, data_key) ) }
        end
      end

      def data_values(data, key)
        value = data[key.to_s] || data[key.to_sym]

        return value.map { |array_data| store_array_data(array_data) } if value.is_a? Array
        value
      end

      def store_array_data(data)
        return convert_hash_to_object(data) if data.is_a? Hash
        data
      end

      def convert_hash_to_object(hash_data)
        OpenStruct.new(hash_data)
      end
  end
end