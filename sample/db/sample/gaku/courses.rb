# encoding: utf-8

codes = ['Spring2012', 'Fall2012', 'Spring2013', 'Fall2013']

say "Creating #{codes.size} courses ...".yellow

codes.each do |code|
  Gaku::Course.where(code: code).first_or_create!
end
