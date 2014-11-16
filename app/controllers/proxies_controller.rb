require "faraday"

class ProxiesController < ActionController::Base
  def create
    response = connection.send(method) do |request|
      request.headers = headers
      request.body = body
    end
    # TODO: return all headers + request details
    render json: response.body, status: response.status
  end

  private

  def connection
    Faraday.new(url: url) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def url
    proxy_params[:url]
  end

  def method
    proxy_params[:type].downcase.to_sym
  end

  def headers
    proxy_params.fetch(:headers, {})
  end

  def body
    proxy_params[:data]
  end

  def proxy_params
    params
  end
end
