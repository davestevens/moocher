require "faraday"

class ProxiesController < ActionController::Base
  def create
    response = connection.send(method) do |request|
      request.url path
      request.headers = headers
      request.body = body
    end
    # TODO: return all headers + request details
    render json: response.body
  end

  private

  def connection
    Faraday.new(url: endpoint) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def endpoint
    proxy_params[:endpoint]
  end

  def method
    proxy_params[:method].downcase.to_sym
  end

  def path
    proxy_params[:path]
  end

  def headers
    proxy_params.fetch(:headers, {})
  end

  def body
    proxy_params[:parameters]
  end

  def proxy_params
    params[:proxy]
  end
end
