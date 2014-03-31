class StaticController < ApplicationController
  def show
    # Works with nested subfolders
    # binding.pry
    template = File.join(params[:controller], params[:page])
    render template
    rescue ActionView::MissingTemplate => e
      if e.message =~ %r{Missing template #{template}}
      raise ActionController::RoutingError, 'Not Found'
    else
      raise e
    end
  end
end