class Api::V1::InvoiceSearchController < ApplicationController
  include SearchRenderHelper

  def date_revenue
    if params["start"].present? && params["end"].present?
      revenue = InvoiceItem.find_revenue_between_dates(params["start"], params["end"])
      render json: {data: {id: {}, attributes: {revenue: revenue}}}
    else
      render json: { error: "Merchant(s) Not Found", data: {} }, status: 400
    end
  end
end