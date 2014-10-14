feature "url redirection" do
  scenario "when the url exists" do
    ShortenedUrl.create! full_url: "http://www.google.com"
    visit "/7WRqMzT"
    expect(current_url).to eq("http://www.google.com/")
  end

  scenario "when the url is not registered" do
    visit "/foobar"
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end