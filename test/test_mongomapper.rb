require 'helper'

class TestMongoMapper < Test::Unit::TestCase

  include PadrinoFields
  include PadrinoFields::MongoMapperWrapper   
  Personm.form_attribute_validators 
  
  
  context "for #form_attribute_is_required? method" do  
    should "return true if attribute is required" do    
      assert Personm.form_attribute_is_required?(:name)
    end
    should "return false if attribute is not required" do
      assert_equal false, Personm.form_attribute_is_required?(:string)
    end
  end 
  
  context "for #form_has_required_attributes? method" do
    should "return true if any attributes are required" do
      assert Personm.form_has_required_attributes?
    end    
    
    should "return false if no attributes are required" do
      assert_equal false, Cat.form_has_required_attributes?
    end
  end   
  
  # TODO
  context "for #form_reflection_validators method" do
    should "return validations for an associated model" do
      expected = [
        ActiveModel::Validations::NumericalityValidator,
        ActiveModel::Validations::LengthValidator,
        ActiveModel::Validations::NumericalityValidator
      ]
      assert_equal expected, Personm.form_reflection_validators(:cats)
    end
  end           
      
  # TODO
  # context "for #form_attribute_validators method" do
  #   should "return validations for a model" do
  #     expected = [
  #     ]
  #     assert_equal expected, Personm.form_attribute_validators.map(&:class)
  #   end
  #   
  # end
  
  context 'for #form_column_type_for method' do
    should "return :string for String columns" do
      assert_equal :string, Personm.form_column_type_for(:name)
    end 
                         
    should "return :number for Float columns" do
      assert_equal :number, Personm.form_column_type_for(:float)
    end   
             
    should "return :number for Integer columns" do
      assert_equal :number, Personm.form_column_type_for(:integer)
    end   
             
    should "return :date for Date columns" do
      assert_equal :date, Personm.form_column_type_for(:date)
    end   
             
    should "return :boolean for Boolean columns" do
      assert_equal :boolean, Personm.form_column_type_for(:boolean)
    end
  end
end