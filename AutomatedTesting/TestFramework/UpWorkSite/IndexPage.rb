class IndexPage
  
  def initialize(driver)
    @@driver = driver
  end
  
  def search(keyword, freelancers=true)
    #Execute search of freelancers or jobs with <keyword>
    search_for = freelancers ? "Freelancers" : "Jobs"
    Log.info("Search #{search_for} with keyword: #{keyword}")
    #check if current search is for what we want to search for
    find_option = @@driver.find_element(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/input[2]').attribute("placeholder")
    #if current search type (freelancers or jobs) should be changed, change it
    if ! find_option.include?(search_for)
      Log.info("Select drop-down menu from search")
      @@driver.find_element(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/div/button[2]').click()
      Log.info("Select #{search_for}")
      choices = @@driver.find_elements(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/div/ul/*')
      for c in choices
        if c.attribute("data-label") == search_for
          c.click()
        end
      end
    else
      Log.info("Search #{search_for} already selected")
    end
    #enter keyword
    Log.info("Enter keyword")
    @@driver.find_element(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/input[2]').send_keys(keyword)
    #click on zoom for search
    Log.info("CLick on zoom for search")
    @@driver.find_element(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/div/button[1]').click()
  end

  
end