require 'sinatra/base'
require 'mongo_mapper' 
require 'mongomapper_ext'
require 'haml'   

class MongoMapperDemo < Sinatra::Base
  register Padrino::Helpers
  configure do
    set :environment, :test
    set :root, File.dirname(__FILE__)
  end
  MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)    
  MongoMapper.database = 'test_padrinofields'
end     

class Personm
  include MongoMapper::Document   
  
  key :name,     String
  key :string,   String   
  key :text,     Text
  key :integer,  Integer
  key :boolean,  Boolean
  key :float,    Float
  key :string,   String
  key :date,     Date
  #$ key :time,     Time
  #$ key :email,    String
  #$ key :phone,    String
  #$ key :tel,      String
  #$ key :url,      String
  #$ key :search,   String
  #$ key :website,  String   
  
  validates_presence_of :name 
  
  has_many :cats
end

class Cat
  include MongoMapper::Document 
  
  key :name, String    
  
  belongs_to :personm
end