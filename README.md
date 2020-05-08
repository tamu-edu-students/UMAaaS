# Marina Bay SaaS
## TripAgvisor
### Project Description
***Experience Recommendation / Review System:*** This was a legacy project. We turned it into a system for Texas A&M students who have studied abroad to leave tips and experiences for future study abroad students to learn from.

### Team Members
1. Justin Hong
2. Bernard Jirka
3. Allison Kinnamore
4. Paige Raun

## Installation Instructions
Our team developed on Cloud9, we recommend you use that platform also. 

1. Create new Cloud9 environment  
   Keep everything default except switch Platform to Ubuntu
2. Increase the size of you Cloud9 to 20gb, instructions here: https://docs.aws.amazon.com/cloud9/latest/user-guide/move-environment.html
3. Run these commands in Cloud9 terminal (obviously, change the github address to your own fork):

npm install -g yarn  
rvm install 2.6.5  
rvm use 2.6.5 --default  
gem install rails  
sudo apt-get install postgresql postgresql-client libpq5 libpq-dev  
git clone https://github.com/MarinaBaySaaS/tripAgvisor.git  
cd tripAgvisor  
gem install bundler  
bundle install  
yarn install  
rails db:migrate  
rails server  
  
4. Click the address in the window that pops up in the upper right corner of the terminal window
5. You will get an error message telling you to add a line to your environment configuration. Copy the given line and paste it in /tripAgvisor/config/environments/development.rb (replace line 2 with the given line)
6. In the terminal press Ctrl+c to stop the server, then type 'rails server' to start it again. Refresh the page that had the error and it should be working now. (Normally, you don't have to stop and restart the server after changes, just refresh your page)
7. Click the 'Login' link in the menu. You'll get an error message, it gives you the URL that you need to give https://console.developers.google.com/ (go to the Credentials part and create a new 'OAuth client ID') to make the login work. The given URL (from https:// all the way to /callback) is what you need to put in the 'Authorized redirect URIs', just the domain name (from https:// to .com) is what you need to put in the 'URIs'. If each person on your team has their own Cloud9 then you'll need to put the addresses for each of them into your Google console.
8. You'll want to change the admin email address in /tripAgvisor/config/application.rb so you can login as an administrator for the first time

Setup your Heroku account to automatically sync with the master branch of your github. That's much easier than trying to push to Heroku from your Cloud9.

## Additional Notes
The initial project was mostly just the Reviews model/controller and database table, but we have mostly abandoned the concept of Reviews. However, the Reviews stylesheet still has a lot of active styles! So that is why all the Reviews stuff hasn't been deleted yet.  
Email me at bjirka@tamu.edu if you have any questions or problems.
