class AttendancesController < ApplicationController
  before_action :authenticate_user!


  def create
    @event = Event.find(attendance_params[:attended_event_id])
    if already_signed_up
      @attendance = Attendance.find_by(attendee_id: attendance_params[:user_id],
                                       attended_event_id: attendance_params[:attended_event_id])
      if (attendance_params[:status].to_s.downcase == 'true') == @attendance.status
        if @attendance.status
          flash[:notice] = "You already marked that you're attending #{@event.title}!"
        else
          flash[:notice] = "You already marked you're attending #{@event.title}!"
        end
      else
        flash[:notice] = "You changed your attendance to #{@event.title}!"

        @attendance.update(status: attendance_params[:status])
      end
    else
      @attendance = @event.attendances.build(attended_event_id: attendance_params[:attended_event_id], attendee_id: attendance_params[:user_id], status: attendance_params[:status])
      if @attendance.save!
        flash[:notice] = "You are now signed up to attend #{@event.title}"
      else
        flash[:alert] = 'Error'
      end
    end
    redirect_to root_path
  end

  def destroy
    @attendance = Attendance.find_by(attendee_id: attendance_params[:user_id],
                                     attended_event_id: attendance_params[:event_id])
    @attendance.destroy
    redirect_to root_path

  end

  private

  def attendance_params

    params.permit(:utf8, :authenticity_token, :commit, :event_id, :format, :user_id, :attended_event_id, :status)
  end

  def already_signed_up
    Attendance.exists?(attendee_id: attendance_params[:user_id], attended_event_id: attendance_params[:attended_event_id])
  end
end
