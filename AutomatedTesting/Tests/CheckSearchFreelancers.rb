require 'selenium-webdriver'
require 'rubygems'
require 'DataStructures/Freelancer'
require 'UpWorkSite/IndexPage'
require 'UpWorkSite/BrowseProfilesPage'
require 'NonAppSpecific/DriverAction'
require 'NonAppSpecific/Config'
require 'NonAppSpecific/Log'
require 'UpWorkSite/ProfilePage'

conf = Config.new()
keyword = conf.get("keyword")
browser = conf.get("browser")

driver_action = DriverAction.new(browser)

driver_action.clear_cookies()

driver_action.navigate_to("https://www.upwork.com/")

driver = driver_action.get_driver()
index_page = IndexPage.new(driver)
index_page.search(keyword)

browse_profiles = BrowseProfilesPage.new(driver)
freelancers = browse_profiles.get_freelancers_data()

browse_profiles.log_apperance_of_keyword(freelancers,keyword)

random_number = browse_profiles.click_random_profile_title()

browse_profiles.open_profile_from_profile_browse()

profile_page = ProfilePage.new(driver)
profile_page.check_freelancer_info(freelancers[random_number-1])

driver_action.close_browser()
