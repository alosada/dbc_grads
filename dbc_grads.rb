require 'linkedin'
require 'csv'

CSV.open('dbc_grad_result.csv', 'wb') do |csv|
  csv << ['column1', 'column2'] #etc

Grad = Struct.new(:name, :linkedin, :email, :location, :current, :past)








dbc_grads = CSV.foreach('dbc_test.csv') do |row|
  grad=Grad.new(row[0], row[4], row[5])
  p grad.name
  p grad.linkedin
  p grad.email
end

