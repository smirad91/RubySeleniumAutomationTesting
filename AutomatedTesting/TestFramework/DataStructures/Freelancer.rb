class FreelancerData
  def initialize(name, title, location, about, skills)
    @name = name
    @title = title
    @location = location
    @about = about
    @skills = skills
  end
  def containKeyword(keyword, attribute)
    return attribute.include?(keyword)
  end
end

class Freelancer < FreelancerData
  attr_reader :name, :title, :location, :about, :skills, :tests, :portfolios
  def initialize(name, title, location, about, skills, tests, portfolios)
    freelancerD = super(name,title,location,about,skills)
    @tests = tests
    @portfolios = portfolios
  end
  def to_s
      "Freelancer: \nname: #@name, \ntitle: #@title, \nlocation: #@location, "\
   "\nabout:#@about, \nskills:#@skills, \ntests: #@tests, \nportfolios: #@portfolios."
  end
end

class Agency < FreelancerData
  attr_reader :name, :title, :location, :about, :skills, :relevantAgencyMember
  def initialize(name, title, location, about, skills, relevantAgencyMember)
    freelancerD = super(name,title,location,about,skills)
    @relevantAgencyMember = relevantAgencyMember
  end
  def to_s
      "Agency: name: #@name, \ntitle: #@title, \nlocation: #@location, \nabout: #@about, "\
    "\nskills: #@skills, \nrelevantAgencyMember: #@relevantAgencyMember."
  end
end
