# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #preforms a pluralize call but removes the number and space
  def pluralize2(count, singular, plural = nil)
    pluralize(count, singular, plural).gsub("#{count} ","")
  end
  
  def submit_button(obj)
    if obj.new_record?
      submit_tag("Create")
    else
      submit_tag("Update")
    end
  end
  
end
