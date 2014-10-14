feature "creating an url" do
  def create_url(url)
    visit "/"
    fill_in "Full url", with: url
    click_button "Create Shortened url"
  end

  scenario "create a correct url" do
    create_url("http://www.google.com")
    expect(page).to have_content("http://www.example.com/7WRqMzT")
  end

  scenario "create an incorrect url" do
    create_url("foobar")
    expect(page).to have_content("should be a valid URL")
  end
end