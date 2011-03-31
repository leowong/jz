module FriendlyDatetimeHelper
  def friendly_datetime(datetime, opt={:style => false})
    if datetime.today?
      if opt[:style]
        raw('<span class="timestamp today">' + datetime.strftime("%H:%M") + '</span>')
      else
        datetime.strftime("%H:%M")
      end
    elsif datetime >= Time.zone.now.beginning_of_year
      if opt[:style]
        raw('<span class="timestamp this_year">' + datetime.strftime("%m-%d %H:%M") + '</span>')
      else
        datetime.strftime("%m-%d %H:%M")
      end
    else
      if opt[:style]
        raw('<span class="timestamp before_this_year">' + datetime.strftime("%Y-%m-%d %H:%M") + '</span>')
      else
        datetime.strftime("%Y-%m-%d %H:%M")
      end
    end
  end

  def friendly_date(datetime, opt={:style => false})
    if datetime.today?
      if opt[:style]
        raw('<span class="timestamp today">' + datetime.strftime("%m-%d") + '</span>')
      else
        datetime.strftime("%m-%d")
      end
    elsif datetime >= Time.zone.now.beginning_of_year and datetime.to_date < Time.zone.now.to_date
      if opt[:style]
        raw('<span class="timestamp this_year">' + datetime.strftime("%m-%d") + '</span>')
      else
        datetime.strftime("%m-%d")
      end
    elsif datetime < Time.zone.now.beginning_of_year
      if opt[:style]
        raw('<span class="timestamp before_this_year">' + datetime.strftime("%Y-%m-%d") + '</span>')
      else
        datetime.strftime("%Y-%m-%d")
      end
    elsif datetime > Time.zone.now.to_date and datetime.to_date < Time.zone.now.next_year.beginning_of_year.to_date
      if opt[:style]
        raw('<span class="timestamp this_year_but_beyond_today">' + datetime.strftime("%m-%d") + '</span>')
      else
        datetime.strftime("%m-%d")
      end
    else
      if opt[:style]
        raw('<span class="timestamp">' + datetime.strftime("%Y-%m-%d") + '</span>')
      else
        datetime.strftime("%Y-%m-%d")
      end
    end
  end
end
