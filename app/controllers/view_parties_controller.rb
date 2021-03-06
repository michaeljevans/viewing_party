class ViewPartiesController < ApplicationController
  before_action :require_authenticated_user

  def new
    @movie = MovieFacade.new(params[:movie_id])
  end

  def create
    party = current_user.view_parties.create(view_party_params)
    PartyGuest.create_invites(party.id, params[:view_party][:friend_ids])
    redirect_to dashboard_path
  end

  private

  def view_party_params
    params.permit(:title, :duration, :date, :time, :poster)
  end
end
