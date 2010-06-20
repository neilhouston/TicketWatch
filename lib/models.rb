require 'rubygems'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-aggregates'
require 'dm-serializer'


class payment
	include DataMapper::Resource
	
	property :id,			Serial
	property :created_at, 	DateTime
	property :updated_at, 	DateTime
	
	#property :council_id,	Interger	:required => true
	property :ticket_id,	Interger	:required => true
	property :ceo_id,		Interger	:required => true
	property :paid_info,	String, 	:length => 255,
	property :amount,		BigDecimal	:precision => 10, :scale => 2, :required => true
	
	#belongs_to 	:council #Associated with council info
	belongs_to	:ceo	 #Associated to the actual officer
	belongs_to	:ticket	 #Actual Ticket Info
	

#class council
#	include DataMapper::Resource
#	
#	property :id,			Serial
#	property :created_at, 	DateTime
#	property :updated_at, 	DateTime
#	property :name,			String, 	:length => 255, :required => true
#	property :slug,			String, 	:length => 255,
#	
#	before :save, :slugify #aka let's make it look pretty, 
#
#	def slugify
#	@slug = @name.gsub(/[^\w\s-]/, '').gsub(/\s+/, '-').downcase
#	end 
	
	
class ceo
	include DataMapper::Resource
	
	property :id,			Serial
	property :created_at, 	DateTime
	property :updated_at, 	DateTime
	
	property :ceo			String, 	:length => 255, :required => true #Even if we weren't provided one, we will issue a constant string
	
	
class ticket
	include DataMapper::Resource
	
	property :id,			Serial
	property :created_at, 	DateTime
	property :updated_at, 	DateTime
	
	property :ticket 		String, 	:length => 255, :required => true #Even if we weren't provided one, we will issue a constant string
	
class contravention
	include DataMapper::Resource
	
	property :id,			Serial
	property :created_at, 	DateTime
	property :updated_at, 	DateTime
	
	property :cecontravention String, 	:length => 255, :required => true #Even if we weren't provided one, we will issue a constant string
	
