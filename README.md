# PAYGO (PEGAFRICA CASE STUDY - FULLSTACK)
## Overview
PAYGO is a RestAPI Django application linked to an android device which will aide in keeping track of customer’s payment into a PostgreSQL database. PEG, is an asset finance institution that provides loans to customers at no interest. So, we need to register the users pay into the system. As such the Agents will be able to view and search these customers from a mobile application. Where they could see their laon and payment details.

## User story
 In this section we are going to identify the actors and the actions and how they are related.

 <img src='docs/umls/Agent_user_stry.PNG' width='1000' height='600'>

 ### Class Diagram
  <img src='docs/umls/class_diagram.jpg' width='1000' height='600'>

### Use case
   <img src='docs/umls/use_case.jpg' width='1000' height='600'>

### Sequence Diagram
#### web Sequence diagram(RestAPI)
<img src='docs/umls/admin_sequence diagrram.jpg' width='1000' height='600'>

#### mobile Sequence diagram(RestAPI)
<img src='docs/umls/mobile_sequence diagram.jpg' width='1000' height='600'>

## Techology
- [Python3](https://www.python.org/download/releases/3.0/)
- [Visual studio code](https://code.visualstudio.com/) and [Android Studio](https://developer.android.com/studio)[https://www.django-rest-framework.org/] (Or any IDE)
- [Djano Rest framwork] for restful APi
- [Django](https://www.djangoproject.com/) for backend
- Microsoft visio for creating UML Diagrams
- [Postgres](https://www.postgresql.org/) for database
- [Pytet](https://docs.pytest.org/en/7.0.x/) for test
- [Postman](https://www.postman.com) for testing api
- [Heroku](https://www.heroku.com) for hosting
- [git](https://git-scm.com) for verion control
- [Githup](https://github.com) for code storage
- [AdobeXD](https://www.adobe.com/products/xd.html) for mockup design
- [Flutter](https://flutter.dev/) for creation of mobile application


## Endpoints
Our API provides the following endpoints
- `/api/v1/customers/`: Used for CRUD on the customer using `POST`, `GET`, `PATCH`, `DELETE`. 
- `/api/v1/dj-rest-auth/login/` For login.
- `/api/v1/dj-rest-auth/logout/` For logout.

## Deployment
The backend Django API application is hosted on heroku with the url: `https://paygoapp.herokuapp.com`

## Tests
I have implemented tests to test the customer apis. It can be run with the command

`$ python manage.py test `

[run and add image here]

## Installation PAYGO Server Side

## SET UP A USER AND DATABASE with POSTGRE
### Create new user with password
- Here, we first login with the default user postgres: `psql -U postgres`
**NB**, when the `-d` is not provided as above, it will use the same name of the `-U` field for the `-d` argument: So, the above code is: `psql -d postgres -U postgres`

- create the user: `CREATE USER <user-name> WITH PASSWORD '<password>';`
- Give some preveleges(CREATEDB) to user: `ALTER USER <user-name> WITH <preveledge>;`
- Login to the default database with newly created user: 
    - `\q`
    - `psql -d postgres -U <new-user>`
- Create new database: `CREATE DATABASE <database>;`
- switch to connect to the newly created database: `\c <new-database>`

### Download Python
- Get python from the offcial website as [Python](https://www.python.org/downloads/)
This all is built with django which is a framework built with python

### Download Django
After installing python we can now install [Django](https://docs.djangoproject.com/en/4.0/topics/install/)
-The run
  - `py -m pip install Django`
### Install virtual environment
 - This [Virtual environment](https://help.dreamhost.com/hc/en-us/articles/215317948-How-to-install-Django-using-virtualenv) allows custom version of python and it's different packages whish are not  connected globally on the server to be installed.
 - The vitual device can be install anywahere but it's preferable to install it in the project's directory for easy reference
 - Go he the all folder and run  
    - `pip install virtualenv`
 - the create a virtual environment 
    - `python -m venv my_env`
 - Custom installation of Django contains [`pip`](https://pypi.org/project/pip/) at installation.


 ### Instaling depedencies
  - Before you can use the virtual environment, you need to activate it by running the activate executable file in the my_env/bin folder. Then you can dive into the virtual environment. 
  So run
    - `my_env/bin/activate`
  - for the next step we can now install the depedencies wuing the `pip` command

    - `pip install -r requirements.txt`
  * NB: make sure you are still in the root folder.
### Creating Admin User
- To create a supeUser, you need provide the Username, Email and Password after running the command
   - `python manage.py createsuperuser`

### Run server
- At last we need to run a command to make our site available for use.
  - `python manage.py runserver`


Now our project is ready to be used. 

## Installation PAYGO Mobile application
PAYGO mobile application is built with [Flutter](https://flutter.dev/). This Mobile application fo meant for PEG Agent who are registred bu the admin on the Server web application.
The Agent are suppose to view and monitor the customer monetory situation using the application while on the field.
The Mobile application is linked ot the server through rest API. as of now the applicaiotn if linked to Heroku where the server side was uploaded.
### Installing flutter 
Flutter can be installed using the instructions from [here](https://docs.flutter.dev/get-started/install)
### Runing the application on the phone
after setting up Flutter check if all requirement are ready by running
 - ` Flutter Doctor` 

 if all good then run

    - `Flutter Build apk` 

To build an apk that will be installed on the phone after building. OR connect an android phone directly on the pc then when you phone is on debug mode run
  - `Flutter run apk`