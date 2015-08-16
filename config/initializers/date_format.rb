# => "April 25th, 2007"
Date::DATE_FORMATS[:release_date] = lambda { |date| day_format = ActiveSupport::Inflector.ordinalize(date.day); date.strftime("%B #{day_format}, %Y") }