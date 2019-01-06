class DriverAction
  
  def initialize(browser)
    Log.info("Start browser #{browser}")
    @driver = Selenium::WebDriver.for(browser.to_sym)
  end
  
  def get_driver()
    #returns driver
    return @driver
  end
  
  def close_browser()
    Log.info("Close browser")
    @driver.quit
  end
  
  def clear_cookies()
    Log.info("Delete cookies from browser")
    @driver.manage().delete_all_cookies()
  end
  
  def navigate_to(url)
    Log.info("Navigate to #{url}")
    @driver.navigate.to(url)
  end
  
end