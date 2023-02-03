#!/bin/bash

if [ -z "$C9_HOSTNAME" ]; then
    read -p "WARNING: This project was designed to run through an Amazon Cloud9 Environment. Some aspects of the development server may not be fully fuctional otherwise. Are you sure you want to continue? [y/N]: " answer
    answer=${answer,,} # convert the answer to lowercase
    if [ "$answer" != "y" ]; then
        echo "Exiting."
        exit 1
    fi
fi

echo -e "\033[32mInstalling Yarn with npm...\033[0m"
npm install -g yarn
if [ $? -eq 0 ]; then
  echo -e "\033[32mYarn installed successfully!\033[0m"
else
  echo -e "\033[31mFailed to install Yarn.\033[0m"
  exit 1
fi

# Load RVM environment
source "$HOME/.rvm/scripts/rvm"

echo -e "\033[32mInstalling Ruby 3.1.3 with RVM...\033[0m"
rvm install ruby-3.1.3
if [ $? -eq 0 ]; then
  echo -e "\033[32mRuby 3.1.3 installed successfully with RVM!\033[0m"
  rvm use ruby-3.1.3 --default
  if [ $? -eq 0 ]; then
    echo -e "\033[32mUsing Ruby 3.1.3 as the default with RVM.\033[0m"
  else
    echo -e "\033[31mFailed to set Ruby 3.1.3 as default with RVM.\033[0m"
    exit 1
  fi
else
  echo -e "\033[31mFailed to install Ruby 3.1.3 with RVM.\033[0m"
  exit 1
fi

echo -e "\033[32mSetting environment to development...\033[0m"

export RAILS_ENV=development
echo $RAILS_ENV

echo -e "\033[32mInstalling Rails with gem...\033[0m"
gem install rails
if [ $? -eq 0 ]; then
  echo -e "\033[32mRails installed successfully!\033[0m"
else
  echo -e "\033[31mFailed to install Rails.\033[0m"
  exit 1
fi

echo -e "\033[32mInstalling SQLite3 and its dependencies with apt-get...\033[0m"
sudo apt-get install sqlite3 libsqlite3-dev
if [ $? -eq 0 ]; then
  echo -e "\033[32mSQLite3 and its dependencies installed successfully!\033[0m"
else
  echo -e "\033[31mFailed to install SQLite3 and its dependencies.\033[0m"
  exit 1
fi

echo -e "\033[32mInstalling Bundler with gem...\033[0m"
gem install bundler
if [ $? -eq 0 ]; then
  echo -e "\033[32mBundler installed successfully!\033[0m"
else
  echo -e "\033[31mFailed to install Bundler.\033[0m"
  exit 1
fi

echo -e "\033[32mInstalling gems with bundle install...\033[0m"
bundle install
if [ $? -eq 0 ]; then
  echo -e "\033[32mGems installed successfully with bundle install!\033[0m"
else
  echo -e "\033[31mFailed to install gems with bundle install.\033[0m"
  exit 1
fi

echo -e "\033[32mInstalling Yarn packages with yarn install...\033[0m"
yarn install
if [ $? -eq 0 ]; then
  echo -e "\033[32mYarn packages installed successfully!\033[0m"
else
  echo -e "\033[31mFailed to install Yarn packages.\033[0m"
  exit 1
fi

echo -e "\033[32mRunning rails db:migrate...\033[0m"
rails db:migrate
if [ $? -eq 0 ]; then
  echo -e "\033[32mRails database migrated successfully!\033[0m"
else
  echo -e "\033[31mFailed to migrate Rails database.\033[0m"
  exit 1
fi

echo -e "\033[1;33mThe Rails server is about to run in order to get the port forwarded URL."
echo -e "Please copy paste the link from the popup that appears on top right"
echo -e "Then wait for the prompt and paste it with CTRL-V into the shell."
echo -e "If you understood, press any key to continue...\033[0m"

# Start the Rails server in the background
rails server &
# Get the PID of the rails server process
pid=$!

sleep 5

# Prompt the user for the host URL
echo -n "Enter the host URL: "
read host_url

# Remove the trailing "/" from the host URL if it exists
host_url=${host_url%/}

# Remove the "https://" from the host URL if it exists
host_url=${host_url#https://}

# Write the host URL to the .env file
echo "AWS_HOST=$host_url" >> .env

# Kill the rails server
kill $pid

# Restart the Rails server
rails server