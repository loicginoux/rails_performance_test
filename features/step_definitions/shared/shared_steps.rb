When(/^I click on "(.*?)"$/) do |button|
	click_on button
end

Then(/^I see "(.*?)" in "(.*?)"$/) do |text, selector|
  begin
		find(selector).should have_content text
	rescue => e
		sleep 5
		find(selector).should have_content text
	end
end

Then(/^I set "(.*?)" in "(.*?)"$/) do |text, selector|
  find(selector).set text
end


Then(/^I see the message "(.*?)"$/) do |message|
  begin
		find(".flash-error").should have_content message
	rescue => e
		sleep 5
		find(".flash-error").should have_content message
	end
end