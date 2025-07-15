class Ownerships::ApplicationController < ApplicationController
  before_action :set_ownership

  def set_ownership
    @ownership = current_user.ownerships.find(params[:ownership_id])
  end
end
