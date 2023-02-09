#!/bin/bash

if [ -z "$C9_HOSTNAME" ]; then
    read -p $'\033[1;33mWARNING:This project was designed to run through an Amazon Cloud9 Environment. Some aspects of the development server may not be fully fuctional otherwise. Are you sure you want to continue? [y/N]: \033[0m' answer
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

# Update the rvm to the latest version 
echo -e "\033[32mInstalling latest rvm version...\033[0m"
rvm get stable --auto
if [ $? -eq 0 ]; then
  echo -e "\033[32mLatest rvm installed successfully\033[0m"
else
  echo -e "\033[31mFailed to install rvm.\033[0m"
  exit 1
fi

# Load use Ruby 3.1.3 with either RVM or RBENV
if source "$HOME/.rvm/scripts/rvm" ; then
  echo -e "\033[32mRVM detected, installing Ruby 3.1.3 with RVM...\033[0m"
  if rvm install ruby-3.1.3 ; then
    echo -e "\033[32mRuby 3.1.3 installed successfully with RVM!\033[0m"
    if rvm use ruby-3.1.3 --default ; then
      echo -e "\033[32mUsing Ruby 3.1.3 as the default with RVM.\033[0m"
    else
      echo -e "\033[31mFailed to set Ruby 3.1.3 as default with RVM.\033[0m"
    fi
  else
    echo -e "\033[31mFailed to install Ruby 3.1.3 with RVM.\033[0m"
  fi
else
  echo -e "\033[32mRVM not detected, installing Ruby 3.1.3 with rbenv...\033[0m"
  if command -v rbenv &>/dev/null ; then
    if rbenv install 3.1.3 ; then
      echo -e "\033[32mRuby 3.1.3 installed successfully with rbenv!\033[0m"
      if rbenv global 3.1.3 ; then
        echo -e "\033[32mUsing Ruby 3.1.3 as the global version with rbenv.\033[0m"
      else
        echo -e "\033[31mFailed to set Ruby 3.1.3 as global version with rbenv.\033[0m"
      fi
    else
      echo -e "\033[31mFailed to install Ruby 3.1.3 with rbenv.\033[0m"
    fi
  else
    echo -e "\033[31mNeither RVM nor rbenv detected. Please install either of them first.\033[0m"
  fi
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

echo -e "\033[32mInstalling SQLite3 and its dependencies with yum...\033[0m"
sudo amazon-linux-extras install postgresql10
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

# Start the Rails server
rails server