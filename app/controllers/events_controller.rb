require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

class EventsController < ApplicationController
  def create
    party = ViewParty.find(params[:party_id])
    event = GoogleCalendarService.new.add_to_calendar(current_user, party)
    if event.status == 'confirmed'
      redirect_to dashboard_path
      flash[:success] = 'Event added to your Google Calendar!'
    else
      redirect_to dashboard_path
      flash[:error] = 'Error - event NOT added to your calendar.'
    end
  end
end
