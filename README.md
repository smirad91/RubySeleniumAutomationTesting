Tools:


Ruby >= 2.2
Selenium Webdriver (only this one gem should be used, no other ones)
Git/Github to place your work there

Test case


Run <browser>
Clear <browser> cookies
Go to www.upwork.com
Focus onto "Find freelancers"
Enter <keyword> into the search input right from the dropdown and submit it (click on the magnifying glass button)
Parse the 1st page with search results: store info given on the 1st page of search results as structured data of any chosen by you type (i.e. hash of hashes or array of hashes, whatever structure handy to be parsed).
Make sure at least one attribute (title, overview, skills, etc) of each item (found freelancer) from parsed search results contains <keyword> Log in stdout which freelancers and attributes contain <keyword> and which do not.
Click on random freelancer's title
Get into that freelancer's profile
Check that each attribute value is equal to one of those stored in the structure created in #67
Check whether at least one attribute contains <keyword>

Requirements:


Browser and <keyword> should be configurable. The test should run with any combination of them.
Imagine that this is not such a simple tiny task, but a big scalable project which can be extended. Hence, implement appropriate OOP model/approach.
Prove model/approach chosen.
Every action, every comparison result, etc should be logged accordingly (i.e. to stdout). Goal: when your script passes - detailed test-case steps should be logged into STDOUT, so anybody can read it and repeat exactly the same steps and verifications but manually.
Your code should be well commented, so anybody can easily find out what action is being performed there and what is the purpose of those code blocks/methods/etc.
Names of the elements described in the test case can differ from what you can see on the site. The site is constantly evolving. But the idea and the flow is the same
You may bump against our anti-bot protection in chrome browser. Please switch executing the script on firefox
