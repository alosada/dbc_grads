require 'linkedin'
require 'csv'

CSV.open('dbc_grad_result.csv', 'wb') do |csv|
  csv << ['name', 'linkedin', 'email', 'location', 'title', 'company', 'start_date']
end

Grad = Struct.new(:name, :linkedin, :email, :location, :title, :company, :start_date)

class Linked_In

  def self.get_linked_in(grad)
    client = LinkedIn::Client.new("key", "sekrit key")
    client.authorize_from_access("user token", "user sekrit")
    begin
      new_info = client.profile(:url => grad.linkedin , :fields => ['location:(name)', 'positions'])
      location = new_info.location.name
      grad.location = location
      grad.title = new_info.positions.all[0].title
      grad.company = new_info.positions.all[0].company.name
      grad.start_date = "#{new_info.positions.all[0].start_date.month}, #{new_info.positions.all[0].start_date.year}"
      p '<<<<<<<<<<- Success ->>>>>>>>>>'
    rescue StandardError => error
      p "Error: #{error}"
    end
    sleep Random.rand(0.3..1.5)
    return grad
  end

end

def add_to_csv(grad)
  CSV.open('dbc_grad_result.csv', 'a+') do |csv|
    csv << [grad.name, grad.linkedin, grad.email, grad.location, grad.title, grad.company, grad.start_date]
  end
end

def fix_url(url)
  unless /http:\/\//.match(url)
    url = 'http://' + url
  end
  url
end

def make_grad(row)
  li_url = fix_url(row[4]
  Grad.new(row[0], li_url, row[5])
end

dbc_grads = CSV.foreach('dbc_test.csv') do |row|
  grad=make_grad(row)
  grad=Linked_In.get_linked_in(grad)
  add_to_csv(grad)
end

