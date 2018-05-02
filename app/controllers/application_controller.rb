class ApplicationController < ActionController::Base
  attr_reader :current_user
  before_action :set_current_user

  def root; end

  private

  def set_current_user
    authenticate_with_http_token do |token|
      @current_user = User.find_by_verified_token(token)
    end
  end
end
