module ApplicationHelper
  def active_by_path(link_path)
    current_page?(link_path) ? 'bg-secondary' : ""
  end

  def active_by_text(text)
    if request.path_info.include?(text)
      "active"
    end
  end

  def animated_check_icon
    '<svg viewBox="-10 -10 500 500" class="animated-success-circle">
      <path class="animated-success-circle circle" d="M877.28,335.72a203.17,203.17,0,0,1,37.86,118.1C915.14,565.26,823.44,657,712,657s-203.14-91.7-203.14-203.14S600.56,250.68,712,250.68a203.21,203.21,0,0,1,144.67,60.53" transform="translate(-508.86 -250.68)"/><polyline class="check animated-success-circle" points="78.54 229.94 179.32 300.74 347.98 60.67"/>
    </svg>'.html_safe
  end

  def distance_of_time_in(unit, from, to)
    diff = to - from

    if 1.respond_to? unit
      distance = diff / 1.send(unit)
      distance.abs.round
    else
      raise ArgumentError, "#{unit.inspect} is not supported as unit"
    end
  end

  def start_year_selection
    Date.today.year - 90
  end

  def end_year_selection
    Date.today.year - 12
  end

  def gender_selection_array
    [
      ["Male", :male],
      ["Female", :female],
      ["Non-binary/Other", :non_binary]
    ]
  end

  def states_list
    [
      ["Alabama", "AL"],
      ["Alaska", "AK"],
      ["Arizona", "AZ"],
      ["Arkansas", "AR"],
      ["California", "CA"],
      ["Colorado", "CO"],
      ["Connecticut", "CT"],
      ["Delaware", "DE"],
      ["District of Columbia", "DC"],
      ["Florida", "FL"],
      ["Georgia", "GA"],
      ["Hawaii", "HI"],
      ["Idaho", "ID"],
      ["Illinois", "IL"],
      ["Indiana", "IN"],
      ["Iowa", "IA"],
      ["Kansas", "KS"],
      ["Kentucky", "KY"],
      ["Louisiana", "LA"],
      ["Maine", "ME"],
      ["Maryland", "MD"],
      ["Massachusetts", "MA"],
      ["Michigan", "MI"],
      ["Minnesota", "MN"],
      ["Mississippi", "MS"],
      ["Missouri", "MO"],
      ["Montana", "MT"],
      ["Nebraska", "NE"],
      ["Nevada", "NV"],
      ["New Hampshire", "NH"],
      ["New Jersey", "NJ"],
      ["New Mexico", "NM"],
      ["New York", "NY"],
      ["North Carolina", "NC"],
      ["North Dakota", "ND"],
      ["Ohio", "OH"],
      ["Oklahoma", "OK"],
      ["Oregon", "OR"],
      ["Pennsylvania", "PA"],
      ["Puerto Rico", "PR"],
      ["Rhode Island", "RI"],
      ["South Carolina", "SC"],
      ["South Dakota", "SD"],
      ["Tennessee", "TN"],
      ["Texas", "TX"],
      ["Utah", "UT"],
      ["Vermont", "VT"],
      ["Virginia", "VA"],
      ["Washington", "WA"],
      ["West Virginia", "WV"],
      ["Wisconsin", "WI"],
      ["Wyoming", "WY"],
      ["-------", "--"],
      ["Australia", "Australia"],
      ["Canada", "Canada"],
      ["France", "France"],
      ["Germany", "Germany"],
      ["Mexico", "Mexico"],
      ["New Zealand", "New Zealand"],
      ["South Africa", "South Africa"],
      ["United Kingdom", "United Kingdom"],
    ]
  end

  def animated_thumbs_up_icon
    "
      <div class='thumbsup-icon'>
        <svg id='stripes' class='stripes' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 187 109'>
            <path  d='M4 35h83a4 4 0 0 1 4 4 4 4 0 0 1-4 4H4a4 4 0 0 1-4-4 4 4 0 0 1 4-4zM100 51h83a4 4 0 0 1 4 4 4 4 0 0 1-4 4h-83a4 4 0 0 1-4-4 4 4 0 0 1 4-4zM20 67h131a4 4 0 0 1 4 4 4 4 0 0 1-4 4H20a4 4 0 0 1-4-4 4 4 0 0 1 4-4zM92 91h51a4 4 0 0 1 4 4 4 4 0 0 1-4 4H92a4 4 0 0 1-4-4 4 4 0 0 1 4-4zM92 19h51a4 4 0 0 1 4 4 4 4 0 0 1-4 4H92a4 4 0 0 1-4-4 4 4 0 0 1 4-4z'/>
        </svg>

        <svg class='stars star1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 187 109'>
            <path d='M68.1 17.4l-4.3-.6-1.9-3.9c-.2-.3-.5-.5-.9-.5s-.7.2-.9.5l-1.9 3.9-4.3.6c-.4.1-.7.3-.8.7-.1.4 0 .8.3 1l3.1 3-.7 4.3c-.1.4.1.8.4 1 .3.2.7.3 1.1.1l3.9-2 3.9 2c.3.2.7.1 1.1-.1s.5-.6.4-1l-.7-4.3 3.1-3c.3-.3.4-.7.3-1-.5-.3-.8-.6-1.2-.7z'/>
        </svg>

        <svg class='stars star2' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 187 109'>
            <path d='M133.1 8.1l-6.6-1-2.9-6c-.3-.5-.8-.8-1.4-.8s-1.1.3-1.4.8l-2.9 6-6.6 1c-.6.1-1.1.5-1.2 1-.2.6 0 1.2.4 1.6l4.8 4.6-1.1 6.6c-.1.6.1 1.1.6 1.5.5.3 1.1.4 1.6.1l5.9-3.1 5.9 3.1c.5.3 1.1.2 1.6-.1s.7-.9.6-1.5l-1.1-6.6 4.8-4.6c.4-.4.6-1 .4-1.6-.4-.5-.8-.9-1.4-1z'/>
        </svg>


        <svg class='stars star3' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 187 109'>
            <path d='M92.9 97.7l-4.6-.7-2-4.1c-.2-.3-.6-.5-.9-.5a1 1 0 0 0-.9.5l-2 4.1-4.5.7c-.4.1-.7.3-.8.7-.1.4 0 .8.3 1.1l3.3 3.2-.8 4.5c-.1.4.1.8.4 1s.8.3 1.1.1l4-2.1 4 2.1c.4.2.8.2 1.1-.1.3-.2.5-.6.4-1l-.8-4.5 3.3-3.2c.3-.3.4-.7.3-1.1-.2-.4-.5-.7-.9-.7z'/>
        </svg>


        <svg class='stars star4' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 187 109'>
            <path d='M45.8 62l-5.7-.8-2.5-5.1c-.2-.4-.7-.7-1.2-.7s-.9.3-1.2.7l-2.5 5.1-5.6.8c-.5.1-.9.4-1.1.9-.2.5 0 1 .3 1.3l4.1 4-1 5.6c-.1.5.1 1 .5 1.3.4.3.9.3 1.4.1l5.1-2.7 5.1 2.7c.4.2 1 .2 1.4-.1.4-.3.6-.8.5-1.3l-1-5.6 4.1-4c.4-.3.5-.9.3-1.3-.1-.5-.5-.8-1-.9z'/>
        </svg>

        <svg class='stars star5' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 187 109'>
            <path d='M142.9 63.7l-2.8-.4-1.3-2.6c-.1-.2-.3-.3-.6-.3s-.5.1-.6.3l-1.3 2.6-2.8.4c-.2 0-.5.2-.5.4-.1.2 0 .5.2.7l2 2-.5 2.8c0 .2.1.5.3.6.2.1.5.2.7 0l2.5-1.3 2.5 1.3h.7c.2-.1.3-.4.3-.6l-.5-2.8 2-2c.2-.2.2-.4.2-.7 0-.2-.2-.4-.5-.4z'/>
        </svg>

        <svg class='thumbsup' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 187 109'>
            <path d='M55 66H33c-4.3 0-8.7-1-12.5-2.9l-7.1-3.5c-.5-.3-.9-.8-.9-1.4v-22c0-.4.1-.7.4-1l15.3-18.4v-12A4.7 4.7 0 0 1 35.3.7c5.4 3.1 5.6 11.1 5.6 16.6v7.9h17.3c4.3 0 7.9 3.5 7.9 7.8v.2L63 58.3a8.1 8.1 0 0 1-8 7.7z'
                fill='#0095ff' transform='translate(58 19)' />
            <path d='M14.1 66H1.6C.7 66 0 65.3 0 64.4V29.9c0-.9.7-1.6 1.6-1.6h12.6c.9 0 1.6.7 1.6 1.6v34.6c-.1.8-.8 1.5-1.7 1.5z' fill='#17c'
                transform='translate(58 19)' />
        </svg>
      </div>
    ".html_safe
  end
end
