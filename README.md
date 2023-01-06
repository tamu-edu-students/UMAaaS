
# TripAgvisor
### Project Description
***Experience Recommendation / Review System:*** This was a legacy project. We turned it into a system for Texas A&M students who have studied abroad to leave tips and experiences for future study abroad students to learn from.

### Team Members
1. Justin Hong
2. Bernard Jirka
3. Allison Kinnamore
4. Paige Raun

Setup your Heroku account to automatically sync with the master branch of your github. That's much easier than trying to push to Heroku from your Cloud9.

Good luck

## Additional Notes
The initial project was mostly just the Reviews model/controller and database table, but we have mostly abandoned the concept of Reviews. However, the Reviews stylesheet still has a lot of active styles! So that is why all the Reviews stuff hasn't been deleted yet.  
Email me at bjirka@tamu.edu if you have any questions or problems.

---

# 2022-23


### Project Description
***Experience Recommendation / Review System:*** This was a legacy (legacy project). We worked on this as part of the 2022-2023 wintermester in Singapore.

### Team Members
1. Arka Bose
2. Molly Frost
3. Anuj Ketkar
4. Abhishek More
5. Uma Sarkar
6. Sarah Sotelo


## Installation Instructions

Create a [AWS Cloud9 instance](https://aws.amazon.com/cloud9/), which automatically creates an EC2 instance. We found that this was the easiest way to get this bloated legacy project up and running quickly. Cloud9 comes installed with rvm and some other cool dependencies. This is the way to go, I promise.

Complete the following steps to get your environment up and running:
```
npm install -g yarn  
rvm install ruby-3.1.3 (or rbenv install 3.1.3)
rvm use ruby-3.1.3 --default (or rbenv global 3.1.3) 
gem install rails  
sudo apt-get install postgresql postgresql-client libpq5 libpq-dev  
git clone https://github.com/tamu-edu-students/UMAaaS.git
cd UMAaaS
gem install bundler
bundle install
yarn install
rails db:migrate
rails server
```

- Click the address in the window that pops up in the upper right corner of the terminal window
- You will get an error message telling you to add a line to your environment configuration. Copy the given line and paste it in /tripAgvisor/config/environments/development.rb (replace line 2 with the given line)
- In the terminal press Ctrl+c to stop the server, then type 'rails server' to start it again. Refresh the page that had the error and it should be working now. (Normally, you don't have to stop and restart the server after changes, just refresh your page)
- To set up Google auth, Go to the [Google Cloud Console](https://console.developers.google.com/). You may need to create a new project. Create credentials for a new OAuth Client ID. In the consent screen, select 'External' as the user type. Fill in the remaining info (the authorized domain and all that jazz can be changed later, if you don't know it currently).
- After completing the consent screen (if you had to), create credentials for a new OAuth Client ID once again. Choose web application as the application type.
- Insert your hosted site URL under the Authorized JavaScript origins. Example:
```
https://999663bc4eee4a0cb47c75a9aaa9268b.vfs.cloud9.us-east-1.amazonaws.com
AND/OR
https://tripagvisor.herokuapp.com
```
- Insert your hosted site URL + "/auth/google_oauth2/callback" as Authorized redirect URIs. Example:
```
https://999663bc4eee4a0cb47c75a9aaa9268b.vfs.cloud9.us-east-1.amazonaws.com/auth/google_oauth2/callback
AND/OR
https://tripagvisor.herokuapp.com/auth/google_oauth2/callback
```
- Change the admin email address in /tripAgvisor/config/application.rb so you can login as an administrator for the first time
- Create a .env file in the root directory. This ensures that your secrets are not exposed. Try not to commit this :)\
Insert the following:
```
GOOGLE_CLIENT_ID=[INSERT GOOGLE CLIENT ID HERE (NO QUOTES)]
GOOGLE_CLIENT_SECRET=[INSERT GOOGLE CLIENT SECRET HERE (NO QUOTES)]
```

Your app should be up and running after this. Apologies for any technical atrocities you may encounter and good luck! 

### Useful Resources
- [Connecting VSCode to Cloud9](https://medium.com/@mahantya/access-your-aws-cloud9-ec2-instance-from-vs-code-over-ssh-ee1f5ea259ff)
- [Prevent EC2 from randomizing IP on shutdown](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#using-instance-addressing-eips-allocating)

