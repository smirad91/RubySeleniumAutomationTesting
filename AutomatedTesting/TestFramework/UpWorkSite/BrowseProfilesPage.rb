class BrowseProfilesPage
  
  def initialize(driver)
    @@driver = driver
  end
  
  def txt_profile_name(serial_number)
    Log.info("Get profile name for #{serial_number} profile on browser page")
    name = self.get_profile_element(serial_number).find_elements(:css, 'div.m-0-top-bottom')[0]
    return name.text
  end
  
  def txt_title(serial_number)
    Log.info("Get profile title for #{serial_number} profile on browser page")
    title = self.get_profile_element(serial_number).find_elements(:css, 'div.m-0-top-bottom')[1]
    return title.text
  end
  
  def txt_about(serial_number)
    #not implemented
    return ""
  end
  
  def lst_skills(serial_number)
    #Return array of strings for profile at <serial_number> place in opened browser page
    
    Log.debug("Get skills for #{serial_number} profile on browser page")
    skills = Array.new
    profile = self.get_profile_element(serial_number)
    skills_data = profile.find_elements(:css, 'a[class^="o-tag-skill"]')
    for skill in skills_data
      skills.push(skill.text)
    end
    return skills
  end
  
  def number_of_profiles()
    number_of_profiles = self.get_all_profiles_element().length
    Log.debug("Number of profiles opened: #{number_of_profiles}")
    #!!!add check for number of profiles opened
    return number_of_profiles
  end
  
  def get_profile_element(serial_number)
    profile = @@driver.find_element(:xpath, "//*[@id='oContractorResults']/div/section[#{serial_number}]/div")
    return profile
  end
  
  def get_all_profiles_element()
    profiles = @@driver.find_elements(:xpath, '//*[@id="oContractorResults"]/div/section/div')
    return profiles
  end
  
  def get_freelancers_data()
    #From opened browse page puts all data in Freelancer or Agency class
    
    number_of_profiles = self.number_of_profiles()  
    freelancers = Array.new
    for number in 1.step(number_of_profiles)
      freelancers.push(self.get_freelancer_data(number))
    end
    return freelancers
  end
  
  
  def get_freelancer_data(number)
    #From opened browse page puts data from given serial number in Freelancer or Agency class
    #Log error and continue test if some of atributes cannot be found
    #If type of profile cannot be determined test fails
    
    begin
      name = self.txt_profile_name(number)
      title = self.txt_title(number)
      about = self.txt_about(number)
      skills = self.lst_skills(number)
    rescue Exception => ex
      Log.error("Exception happened during getting data: #{ex}")
    end
    info = self.get_profile_element(number)
    if info.attribute("data-log-label") == 'tile_agency'
      agency = Agency.new(name,title,"",about,skills,"")
      return agency
    elsif info.attribute("data-log-label") == 'tile'
      freelancer = Freelancer.new(name,title,"",about,skills,"", "")
      return freelancer
    else
      raise "Test is not working right. Test should be analyzed."
    end
  end
  
  def click_random_profile_title()
    #Create array of random numbers
    #When freelencer is found (not agency) the title will be clicked
    #If profile is not found test fails. Possible reason can be that only 
    #agencies are on opened page.
    
    Log.info("Open random profile from title")
    number_of_profiles = self.number_of_profiles()
    random = Array.new(number_of_profiles) { rand(1..number_of_profiles) }
    for rand in random
      profile = self.get_profile_element(rand)
      if profile.attribute("data-log-label") == 'tile'
        profile.find_elements(:css, 'div.m-0-top-bottom')[1].click()
        Log.info("Opened profile from serial number #{rand}")
        return rand
      end
    end
    raise 'Profile not found in search page'  
  end  
  
  def open_profile_from_profile_browse()
    #After profile is opened from browse page using title, profile browse is opened
    
    Log.info('Open profile from opened profile browser')
    @@driver.find_element(:css, 'a[data-ng-href*="o/profiles/users/"][target="_blank"]').click()
  end
  
  def log_apperance_of_keyword(freelancers, keyword)
    #For forwarded <freelancers> check if every attribute contains <keyword>
    #Information is logged
    
    Log.info("Check existence of keyword: #{keyword} in freelancers")
    for freelancer in freelancers
      Log.info("Check existence of keyword for #{freelancer}")
      for attribute in freelancer.instance_variables
        attribute_value = freelancer.instance_variable_get(attribute)
        if attribute_value.include?(keyword)
          Log.info("#{attribute} contains keyword")
        else
          Log.warn("#{attribute} does not contain keyword")
        end
      end
    end
  end
  
end