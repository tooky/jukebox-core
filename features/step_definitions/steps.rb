Given /^the following song exists in the Jukebox's catalogue$/ do |table|
  @song = create_song(table.hashes.first)
  catalogue.add_song @song
end

When /^I search for "(.*?)"$/ do |search_term|
  jukebox.search(search_term)
end

Then /^I should see the song in the results$/ do
  ui.should be_displaying_result(@song)
end
