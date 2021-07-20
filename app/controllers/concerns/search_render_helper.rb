module SearchRenderHelper
  def create_render(object, serializer)
    if !object.nil?
      render json: serializer.new(object).serializable_hash.to_json
    else
      render json: {status: 'ERROR', message: 'No Results Found',
        data:nil}, status: 200
    end
  end
end