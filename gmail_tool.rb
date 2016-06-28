require '../global_utils/global_utils'
require 'gmail'

class GmailTool
  attr_reader :gmail
  def initialize
    @gmail = connect_to_gmail
  end

  def connect_to_gmail
    Gmail.connect(CredService.creds.user.gmail.username, CredService.creds.user.gmail.password)
  end

  def report_bad_file(file_name:, parent_id:, problems: )
    body = "File: #{file_name}\n ParentId: #{parent_id}\n Problems:"
    problems.each do |problem|
      body << "\n"
      body << problem
    end
    email         = @gmail.compose
    email.to      = 'doug+report@reedhein.com'
    email.subject = 'Ground Controll: Bad File discovered'
    email.body    = body
    email.deliver
  end

  def compose(gmail)
    email = gmail.compose
    email.to = @email_destination
    email.subject @subject || "query to csv"
    email.body "query results as csv for query: \n#{@query}"
    email.add_file @filename
    email.deliver
  end
end
