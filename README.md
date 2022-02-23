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
- [Visual studio code](https://code.visualstudio.com/) and [Android Studio](https://developer.android.com/studio) (Or any IDE)
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

## Installation

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