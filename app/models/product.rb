class Product < ApplicationRecord
	require 'roo'
	before_save :fn1

	REGEX0=/[A-Z]{3}[0-9]{4}/i
	REGEX1=/[0-9]{15}/
	 validates :item_type, presence: true 
	 validates :sku, presence: true,format: {with: REGEX0}
	 validates :Title, presence: true
	 validates :serial_number, presence: true, numericality: true, length: {is:15}, format: {with: REGEX1}
	 validates :quantity, presence: true
	 validates :price, presence: true
	 validates :organization, presence: true
	 validates :Length, presence: true
	 validates :Breadth, presence: true
	 validates :Height, presence: true
	 validates :Weight, presence: true
	 validates :description, presence: true
	 validates :short_description, presence: true
	 validates :asset_code, presence: true
	 validates :grade, presence: true
	 validates :category, presence: true
	 validates :brand, presence: true

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |product|
				csv << product.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header,spreadsheet.row(i)].transpose]
			product = Product.find_by_id(row["id"]) || new
			product.attributes = row.to_hash
			if product.valid?
				product.save!
			else
			end
		end	
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
		when ".xls" then Roo::Excel.new(file.path,packed: nil,file_warning: :ignore)
		when ".xlsx" then Roo::Excelx.new(file.path, nil,file_warning: :ignore)
		else	raise "Unknown file type: #{file.original_filename}"
		end
	end

	def fn1
		self.volume = self.Length * self.Breadth * self.Height
	end

end
