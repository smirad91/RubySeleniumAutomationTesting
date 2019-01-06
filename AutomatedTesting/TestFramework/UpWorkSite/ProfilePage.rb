class ProfilePage
  
  def initialize(driver)
    @driver = driver
  end
  
  def getName
    return @driver.find_element(:css, 'h2[class="m-xs-bottom"]').text
  end
  
  def getTitle
    return @driver.find_element(:css, 'span[data-ng-bind-html*="getProfileTitle"]').text
  end
 
  def getAbout
    return @driver.find_element(:css, 'p[class*="text-pre-line up-active-context"]').text
  end
  
  def getSkills
    skills = []
    skillsDom = @driver.find_elements(:css, 'a[class^="o-tag-skill ng-binding"]')
    for skill in skillsDom
      skills.push(skill.text)
    end
    return skills
  end
  
  def get_freelancer()
    #From opened profile page puts attributes in Freelancer object and returns it
    freelancer = Freelancer.new(self.getName(),self.getTitle(),"",self.getAbout(),
      self.getSkills(),"","")
    return freelancer
  end
  
  def check_freelancer_info(freelancer)
    #Compare Freelancer object info on opened page with forwarded Freelancer object
    #This method should be moved to Freelancer class
    Log.info("Check if forwareded freelancer have same info as currently "\
      "opened profile. Forwarded #{freelancer}")
    #Put current opened profile page data to Freelancer object so it can be compared with forwarded freelancer
    freelancer_from_page = self.get_freelancer()
    Log.info("Opened profile data: #{freelancer_from_page}")
    #go through the forwarded freelancer instance variables 
    for attribute in freelancer.instance_variables
      freelancer_value = freelancer.instance_variable_get(attribute)
      #check is freelancer variable array
      if freelancer_value.class == Array
        current_opened_profile_attribute = freelancer_from_page.instance_variable_get(attribute)
        #check is all array values from forwarded freelancer in values of opened freelancer profile
        if freelancer_value.all? { |e| current_opened_profile_attribute.include?(e) }
          Log.info("Contains all #{attribute}")
        else
          Log.error("Does not contain all #{attribute}. Skills from current opened page: #{current_opened_profile_attribute}. Forwarded values: #{freelancer_value}")
        end
      else
        #freelancer variable is string
        if freelancer_from_page.instance_variable_get(attribute).include?(freelancer.instance_variable_get(attribute))
          Log.info("#{attribute} are the same")
        else
          Log.error("#{attribute} are not the same")
        end
      end
    end
  end
  
end