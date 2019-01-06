class IndexPage
  
  def initialize(driver)
    @@driver = driver
  end
  
  def inp_search
    return @@driver.find_element(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/input[2]')
  end
  
  def btn_zoom
    return @@driver.find_element(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/div/button[1]')
  end
  
  def btn_dropdown_search
    return @@driver.find_element(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/div/button[2]')
  end
  
  def lst_dropdown_search
    return @@driver.find_elements(:xpath, '//*[@id="layout"]/nav/div/div[2]/div[1]/form/div[3]/div/ul/*')
  end
  
  def search(keyword, freelancers=true)
    #Execute search of freelancers or jobs with <keyword>.
    #Check if current search is for what we want to search for
    #If current search type (freelancers or jobs) should be changed, change it
    #Enter keyword and clicks on zoom for search.
    
    search_for = freelancers ? "Freelancers" : "Jobs"
    Log.info("Search #{search_for} with keyword: #{keyword}")
    find_option = self.inp_search.attribute("placeholder")
    if ! find_option.include?(search_for)
      Log.info("Select drop-down menu from search")
      self.btn_dropdown_search.click()
      Log.info("Select #{search_for}")
      choices = self.lst_dropdown_search()
      for c in choices
        if c.attribute("data-label") == search_for
          c.click()
        end
      end
    else
      Log.info("Search #{search_for} already selected")
    end
    Log.info("Enter keyword")
    self.inp_search.send_keys(keyword)
    Log.info("CLick on zoom for search")
    self.btn_zoom.click()
    #!!! check for action is succeeded should be added
  end

  
end