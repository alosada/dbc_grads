require 'linkedin'
require 'csv'

CSV.open('dbc_grad_result.csv', 'wb') do |csv|
  csv << ['column1', 'column2'] #etc

Grad = Struct.new(:name, :linkedin, :email, :location, :current)

class LinkedIn

  def self.get_linked_in(grad)
    client = LinkedIn::Client.new("KEY", "SECRETKEY")
    client.authorize_from_access("USER_TOKEN","USER_SECRET")
    begin
      new_info = client.profile(:url => grad.linkedin , :fields => ['location:(name)', 'positions'])
      location = clean_location(new_info.location.name)
      grad.location = location
      grad.current = new_info.positions.current

      p '<<<<<<<<<<- Success ->>>>>>>>>>'
    rescue StandardError => error
      p "Error: #{error}"
    end
    #sleep Random.rand(300..1500)
    return grad
  end

end

ale=Grad.new('Ale', 'http://linkedin.com/in/alosada', 'a@a.com')
ale=LinkedIn.get_linked_in(ale)
p ale.current
p ale.location

# dbc_grads = CSV.foreach('dbc_test.csv') do |row|
#   grad=Grad.new(row[0], row[4], row[5])
#   p grad.name
#   p grad.linkedin
#   p grad.email
# end

