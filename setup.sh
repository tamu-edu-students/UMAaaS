#!/bin/bash

# Check if the user is on Cloud9
if [ ! -d "$HOME/c9" ]; then
    echo "Warning: This program is designed to run on Amazon Cloud9."
    echo "If you are not using Cloud9, the development server may not work correctly."
    echo "Do you still want to continue? [y/N]"
    read -r response
    if [ "$response" != "y" ]; then
        exit 1
    fi
fi

echo "Installing Yarn with npm..."
npm install -g yarn
if [ $? -eq 0 ]; then
  echo "Yarn installed successfully!"
else
  echo "Failed to install Yarn."
  exit 1
fi

echo "Installing Ruby 3.1.3 with RVM or rbenv..."
if [ -x "$(command -v rvm)" ]; then
  rvm install ruby-3.1.3
  if [ $? -eq 0 ]; then
    echo "Ruby 3.1.3 installed successfully with RVM!"
    rvm use ruby-3.1.3 --default
    if [ $? -eq 0 ]; then
      echo "Using Ruby 3.1.3 as the default with RVM."
    else
      echo "Failed to set Ruby 3.1.3 as default with RVM."
      exit 1
    fi
  else
    echo "Failed to install Ruby 3.1.3 with RVM."
    exit 1
  fi
elif [ -x "$(command -v rbenv)" ]; then
  rbenv install 3.1.3
  if [ $? -eq 0 ]; then
    echo "Ruby 3.1.3 installed successfully with rbenv!"
    rbenv global 3.1.3
    if [ $? -eq 0 ]; then
      echo "Using Ruby 3.1.3 as the default with rbenv."
    else
      echo "Failed to set Ruby 3.1.3 as default with rbenv."
      exit 1
    fi
  else
    echo "Failed to install Ruby 3.1.3 with rbenv."
    exit 1
  fi
else
  echo "Neither RVM nor rbenv is installed. Exiting..."
  exit 1
fi

echo "Installing Rails with gem..."
gem install rails
if [ $? -eq 0 ]; then
  echo "Rails installed successfully!"
else
  echo "Failed to install Rails."
  exit 1
fi

echo "Installing SQLite3 and its dependencies with apt-get..."
sudo apt-get install sqlite3 libsqlite3-dev
if [ $? -eq 0 ]; then
  echo "SQLite3 and its dependencies installed successfully!"
else
  echo "Failed to install SQLite3 and its dependencies."
  exit 1
fi

echo "Installing Bundler with gem..."
gem install bundler
if [ $? -eq 0 ]; then
  echo "Bundler installed successfully!"
else
  echo "Failed to install Bundler."
  exit 1
fi

echo "Installing gems with bundle install..."
bundle install
if [ $? -eq 0 ]; then
  echo "Gems installed successfully with bundle install!"
else
  echo "Failed to install gems with bundle install."
  exit 1
fi

echo "Installing Yarn packages with yarn install..."
yarn install
if [ $? -eq 0 ]; then
  echo "Yarn packages installed successfully!"
else
  echo "Failed to install Yarn packages."
  exit 1
fi

echo "Running rails db:migrate..."
rails db:migrate
if [ $? -eq 0 ]; then
  echo "Rails database migrated successfully!"
else
  echo "Failed to migrate Rails database."
  exit 1
fi

echo "Starting Rails server with rails server..."
rails server &
sleep 5

# Extract the URL from the output
url=$(tail -n 2 <(rails server) | grep -Eo "https://.*.vfs.cloud9.us-east-2.amazonaws.com")

# Write the URL to the .env file
echo "AWS_HOST=$url" > .env

echo "The URL has been saved to the .env file as AWS_HOST."

# Kill the Rails server
kill $!

rails server
