# Marina Bay SaaS
## TripAgvisor
### Project Description
***Experience Recommendation / Review System:*** This was a legacy project. We turned it into a system for Texas A&M students who have studied abroad to leave tips and experiences for future study abroad students to learn from.

### Team Members
1. Justin Hong
2. Bernard Jirka
3. Allison Kinnamore
4. Paige Raun

## Installation Help
Our team developed on Cloud9, we recommend you use that platform also. Be sure to increase the size of your Cloud9 immediately so you don't run into space problems later.

npm install -g yarn  
rvm install 2.6.5  
rvm use 2.6.5 --default  
gem install rails  
bundle exec rake db:setup  

There are configuration settings in /config/application.rb  
You'll want to at least change the admin email address there.

You also need to setup Google API credentials to make the login work  
https://console.developers.google.com (I think you'll have to login with a person gmail account, tamu.edu won't work)  
Click the Credentials section, then create an "OAuth client ID"  
Application type will be "Web Application"  
Give it any name you want.  
For the Authorized JavaScript Origins, give it your heroku address and the address of all your Cloud9 devs up to the .com part  
For the Authorized Redirect URIs, try to login on your app with these blank, you'll get an error message that has the correct value to put in here. It starts with the same addresses as you put in the Authorized JavaScript Origins parts, but with more URL past the .com. The URL should end with 'callback'
## Additional Notes
The initial project was mostly just the Reviews model/controller and database table, but we have mostly abandoned the concept of Reviews. However, the Reviews stylesheet still has a lot of active styles! So that is why all the Reviews stuff hasn't been deleted yet.  
Email me at bjirka@tamu.edu if you have any questions or problems.
