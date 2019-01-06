class BrowseProfilesPage
  
  def initialize(driver)
    @@driver = driver
  end
  
  def profile_name(serial_number)
    Log.info("Get profile name for #{serial_number} profile on browser page")
    name = self.get_profile_element(serial_number).find_elements(:css, 'div.m-0-top-bottom')[0]
    return name.text
  end
  
  def title(serial_number)
    Log.info("Get profile title for #{serial_number} profile on browser page")
    title = self.get_profile_element(serial_number).find_elements(:css, 'div.m-0-top-bottom')[1]
    return title.text
  end
  
  def about(serial_number)
    #not implemented
    return ""
  end
  
  def skills(serial_number)
    #Return array of strings for profile at <serial_number> place in browser page
    Log.info("Get skills for #{serial_number} profile on browser page")
    skills = Array.new
    #get profile Element
    profile = self.get_profile_element(serial_number)
    #find skills in profile for serial_number 
    skills_data = profile.find_elements(:css, 'a[class^="o-tag-skill"]')
    for skill in skills_data
      skills.push(skill.text)
    end
    return skills
  end
  
  def number_of_profiles()
    number_of_profiles = self.get_all_profiles_element().length
    Log.info("Number of profiles opened: #{number_of_profiles}")
    #add check for number of profiles opened
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
    #from opened browse page puts data in Freelancer or Agency class
    number_of_profiles = self.number_of_profiles()  
    freelancers = Array.new
    #use get_freelancer_data for every profile on browse page
    for number in 1.step(number_of_profiles)
      freelancers.push(self.get_freelancer_data(number))
    end
    return freelancers
  end
  
  def get_freelancer_data(number)
    begin
      #get values for profile at <number> at opened browse page
      name = self.profile_name(number)
      title = self.title(number)
      about = self.about(number)
      skills = self.skills(number)
    rescue Exception => ex
      #log error and continue test if some of atributes cannot be found
      Log.error("Exception happened during getting data: #{ex}")
    end
    info = self.get_profile_element(number)
    #check if profile is freelancer or agency
    if info.attribute("data-log-label") == 'tile_agency'
      agency = Agency.new(name,title,"",about,skills,"")
      return agency
    elsif info.attribute("data-log-label") == 'tile'
      freelancer = Freelancer.new(name,title,"",about,skills,"", "")
      return freelancer
    else
      #test is stopped if type of profile cannot be determined
      raise "Test is not working right. Test should be analyzed."
    end
  end
  
  def click_random_profile_title()
    Log.info("Open random profile from title")
    #Create array of random numbers
    #When freelencer is found (not agency) the title will be clicked
    random = Array.new(self.number_of_profiles()) { rand(1..self.number_of_profiles()) }
    for rand in random
      profile = self.get_profile_element(rand)
      if profile.attribute("data-log-label") == 'tile'
        profile.find_elements(:css, 'div.m-0-top-bottom')[1].click()
        Log.info("Opened profile from serial number #{rand}")
        return rand
      end
    end
    #If profile is not found test fails
    raise 'Profile not found in search page'  
  end  
  
  def open_profile_from_profile_browse()
    #after profile is opened from browse page using title, profile browse is opened
    Log.info('Open profile from opened profile browser')
    @@driver.find_element(:css, 'a[data-ng-href*="o/profiles/users/"][target="_blank"]').click()
  end
  
  def log_apperance_of_keyword(freelancers, keyword)
    #For forwarded <freelancers> check if every attribute containe <keyword>
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