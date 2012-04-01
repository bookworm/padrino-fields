require 'mongo_mapper'
module PadrinoFields
  module MongoMapperWrapper  
    module ClassMethods
      attr_reader :reflection

      def form_attribute_validators  
        validators   
      end

      def form_validators_on(attribute)      
        validators.find_all {|v| v.attributes.include?(attribute) }
      end

      def form_attribute_is_required?(attribute)
        form_validators_on(attribute).find_all {|v| v.class == ActiveModel::Validations::PresenceValidator }.any?
      end
       
      # TODO
      def form_reflection_validators(reflection=nil)   
        return nil
      end

      def form_has_required_attributes?(reflection=nil)
        validators = form_attribute_validators
        validators += reflection_validators(reflection) if reflection
        validators.find_all {|v| v.class == ActiveModel::Validations::PresenceValidator }.any?
      end

      def form_column_type_for(attribute)     
        klass = keys.find_all {|p| p[0].to_sym == attribute}[0][1].type
        if klass == String
          :string    
        elsif klass == Text
          :text
        elsif [Integer,Float].include?(klass)
          :number
        elsif klass == Boolean
          :boolean
        elsif [Date,Time,Timestamp].include?(klass)
          :date
        elsif klass == ObjectId
          :serial
        else
          nil
        end
      end               
    end
  end # Datamapper
end # PadrinoFields
 
MongoMapper::Plugins::Document::ClassMethods.send(:include, PadrinoFields::MongoMapperWrapper::ClassMethods)