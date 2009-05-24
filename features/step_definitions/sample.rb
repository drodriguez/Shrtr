When /^I go home$/ do
  get '/'
end

Then /^I enjoy the app$/ do
  last_response.ok?
end
