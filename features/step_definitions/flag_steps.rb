
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given("I see an experience") do
  @experience = FactoryBot.create(:Experience)
  visit expand_path(@experience)
end

Given("I see a comment") do
  @comment = FactoryBot.create(:comment)
  visit comment_path(@comment)
end

When("I press comment_flag") do
  click_button("Comment Flag")
end

And("The flag is not already set") do
  expect(@comment.flagged).to be(false)
end

Then("I should have a comment flag created") do
  @comment.reload
  expect(@comment.flagged).to be(true)
end

Given("I see a comment") do
  @comment = FactoryBot.create(:comment)
  visit comment_path(@comment)
end

When("I press comment_flag") do
  click_button("Comment Flag")
end

And("The flag is already set") do
  @comment.update(flagged: true)
  expect(@comment.flagged).to be(true)
end

Then("I should have a comment flag deleted") do
  @comment.reload
  expect(@comment.flagged).to be(false)
end
