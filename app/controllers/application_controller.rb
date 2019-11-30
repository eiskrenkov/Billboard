class ApplicationController < ActionController::Base
  inherit_resources

  include NavigationSupport

  protect_from_forgery with: :null_session
end
