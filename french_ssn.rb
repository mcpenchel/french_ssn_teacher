require 'yaml'

SSN_REGEX = /(?<gender>^[12])(?<birth_year>\d{2})(?<birth_month>\d{2})(?<birth_department>\d{2})(?<digits>\d{6})(?<security>\d{2})/

def french_ssn_info(ssn)
  ssn.gsub!(/\s/, '')
  return "The number is invalid" unless ssn =~ SSN_REGEX

  gender          = ssn.match(SSN_REGEX)[:gender]
  birth_year      = ssn.match(SSN_REGEX)[:birth_year]
  birth_month     = ssn.match(SSN_REGEX)[:birth_month]
  birth_dpt       = ssn.match(SSN_REGEX)[:birth_department]
  digits          = ssn.match(SSN_REGEX)[:digits]
  security        = ssn.match(SSN_REGEX)[:security]

  return "The number is invalid" unless (97 - ssn[0..-3].to_i) % 97 == security.to_i
  departments = YAML.load_file('data/french_departments.yml')
  department  = departments[birth_dpt]

  gender_string = gender.to_i == 1 ? "man" : "woman"
  month_string  = Date::MONTHNAMES[birth_month.to_i]

  "a #{gender_string}, born in #{month_string}, 19#{birth_year} in #{department}."
end

ssn = "1 84 12 76 451 089 46"
puts french_ssn_info(ssn)
