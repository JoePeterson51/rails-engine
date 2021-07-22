module ItemValidationHelper
  def valid_name?(params)
    params["name"].present? && !params["min_price"].present? && !params["max_price"].present?
  end

  def valid_price_range?(params)
    params["min_price"].present? && params["max_price"].present? && params["min_price"].to_f < params["max_price"].to_f
  end

  def valid_min_price?(params)
    params["min_price"].present? && !params["max_price"].present? && !params["name"].present? && !params["min_price"].to_f.negative?
  end

  def valid_max_price?(params)
    params["max_price"].present? && !params["min_price"].present? && !params["name"].present? && !params["max_price"].to_f.negative?
  end
end