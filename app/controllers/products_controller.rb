class ProductsController < ApplicationController
	def import
		Product.import(params[:file])
		redirect_to root_url, notice: "Products imported"
	end

	def index
		@products = Product.all
	 	respond_to do |format|
	 		format.html
	 		format.csv { send_data @products.to_csv}
	 		format.xls { send_data @products.to_csv(col_sep:"\t")}
	 	end
	 end

	 def initialize
    	@errors = ActiveModel::Errors.new(self)
  	end
end
