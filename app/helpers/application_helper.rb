module ApplicationHelper

  def format_time(datetime_object)
    datetime_object.strftime("%m/%d/%Y at %I:%M%p")
  end

end
