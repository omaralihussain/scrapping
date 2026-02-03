class Crawl < Struct.new(:web_url, :user_email, :user_pass, :row)

	
	def perform
	  driver = Selenium::WebDriver.for :phantomjs, :args =>  ['--ignore-ssl-errors=true']
	  
	  wait = Selenium::WebDriver::Wait.new(:timeout => 50)
	  
	  driver.navigate.to web_url
	  
	  input = driver.find_element(:id, 'EMAIL')
	  input.send_keys user_email
	  
	  input =  driver.find_element(:id, 'PASSWORD')
	  input.send_keys user_pass
	  
	  button = driver.find_element(:id, 'submitButton')
	  button.click

	  wait.until{ driver.find_element(:id, 'authQuestiontextLabelId').displayed? }

	  label = driver.find_element(:id, 'authQuestiontextLabelId')

	  answer = get_security_answer(label['innerHTML'].squish)

	  input = driver.find_element(:class, 'challengeSecurityUserAnswerInput')
	  input.send_keys answer

	  button = driver.find_element(:id, 'authQuestionSubmitButton')
	  button.click

	  response = driver.find_element(:tag_name, 'body').attribute('innerHTML')

	  driver.quit
	  
	  row.update(raw: response)
  end

  
  def get_security_answer(q)
    security_arr = {'What is the city and state of your birth?' => 'Chicago', 'What is the name of the company of your first job?' => 'northwest', 
                    "What is your best friend's name?" => 'Jesal' }

    security_arr[q]
  end
end