# Introduction

The following code challenge is to take the hardcoded flask application, with a MySQL backend, and create a container based solution that will work for local development as well as customer facing environments in AWS.  The challenge is broken into multiple parts.  Each is designed to test various skills and let you demonstrate your knowledge of good application architecture and development practices.

# Part 1

In order to create a multi environment version of this application we will need to make the following changes:

1. Create a configuration file that holds the mysql connection credentials.
2. Update main.py to import the configuration file and create the database connection from the variables in the configuration file

# Part 2

In order to faclitate local development we want to create 2 docker containers.  One is a mysql container that is seeded with the db_seed.sql file.  The second is a container running the flask application that reads its configuration from the file you created in Part 1.

# Part 3

Define the architecture in AWS that would best support this platform.  During your code review be prepared to discuss your choices and why you believe they are the best approach.

# Bonus 

Create a CI/CD pipeline that will build, version/tag, and deploy the flask container into an ECS cluster in AWS.  You can use AWS Developer Tools or Jenkins as you see fit.



