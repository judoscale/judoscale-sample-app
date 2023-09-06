class ReqsController < ApplicationController
  before_action { @nav_current = :reqs }

  def new
    @req = Req.new
  end

  def create
    @req = Req.new(params.require(:req).permit!)
    @req.save!

    # render layout: false
    head :ok
  end

  def headers
    render plain: request.headers.to_h.sort.to_h.filter { |k,v| v.is_a? String }.to_yaml
  end

  def debug
    raise
  end
end
