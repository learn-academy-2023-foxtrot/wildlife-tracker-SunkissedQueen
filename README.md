## Rails API and Postman

### API: Application Programming Interface
- allows web applications to communicate with each other
  - transmitting data in the form of JSON (JavaScript Object Notation)
  - API will receive a request from a different application and the API endpoint will respond with the appropriate data

- Generate a resource with appropriate columns and datatypes
  - resource will create a model, controller, view, and routes
  ***NOTE: type***
  - $ rails g resource CowTipping name:string breed:string farm:string
  - $ rail db:migrate

- Stub some data entries
  - $ rails c
  - > CowTipping.create(name: 'Lucy', breed: 'heifer', farm: 'Old McDonald')

- Disable the authenticity token
```rb
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
```

- Create API endpoints
### Workflow
- create branch for the endpoint
- create a controller method
- Postman to make a request to the endpoint

### index
- create branch for the endpoint
- create a controller method
```rb
  def index
    # instance variables are not needed because we don't have views
    # active record query to return all the instances within our database 
    cows = CowTipping.all
    # because we do not have views, we will render the instances stored in the cows variable as json
    render json: cows
  end
```
- Postman to make a request to the endpoint
  #### request
  - `GET -> localhost:3000/cow_tippings -> Send`
  #### output
  - `Body -> Pretty -> JSON`
  - If see some html on the printout, that is an error message
  - `Body -> Preview`
