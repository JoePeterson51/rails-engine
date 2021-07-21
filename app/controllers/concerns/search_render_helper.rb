module SearchRenderHelper
  def create_render(object, serializer)
    if !object.nil?
      render json: serializer.new(object).serializable_hash.to_json
    else object.nil?
      render json: { data: {} }, status: :ok
    end
  end
end