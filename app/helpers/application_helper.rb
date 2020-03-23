module ApplicationHelper
    def bs4_bgcolor_for(flash_key)
      case flash_key
      when "success"
        "alert-success"
      when "alert"
        "alert-danger"
      when "error"
       "alert-warning"
      when "notice"
       "alert-info"
      else
       flash_key.to_s
      end
    end
end

