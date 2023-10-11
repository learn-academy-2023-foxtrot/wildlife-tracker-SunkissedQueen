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
- create branch for the index, show, create endpoint (stretch goals: update and delete). New and edit will require user interactions on the views. We don't views here.
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

### show endpoint
- create branch for the endpoint
- create a controller method
```rb
  def show
    cow = CowTipping.find(params[:id])
    render json: cow
  end
```
- Postman to make a request to the endpoint
  #### request
  - `GET -> localhost:3000/cow_tippings/1 -> Send`
  #### output
  - `Body -> Pretty -> JSON`

### create endpoint
- create branch for the endpoint
- create a controller method
```rb
  def create
    cow = CowTipping.create(cow_params)
    if cow.valid?
      render json: cow
    else
      render json: cow.errors
    end
  end

  private
  def cow_params
    params.require(:cow_tipping).permit(:name, :breed, :farm)
  end
```
- Postman to make a request to the endpoint
  #### request
  - `POST -> localhost:3000/cow_tippings`
  - `Body -> raw -> JSON`
```rb
  {
    "name": "Betsy",
    "breed": "Belted Galloway",
    "farm": "Where's the Beef"
  }
```
  -  `-> Send`
  #### output
  - `Body -> Pretty -> JSON`

### update endpoint
- create branch for the endpoint
- create a controller method
```rb
  def update
    cow = CowTipping.find(params[:id])
    cow.update(cow_params)
    if cow.valid?
      render json: cow
    else
      render json: cow.errors
    end
  end
```
- Postman to make a request to the endpoint
  #### request
  - `PATCH -> localhost:3000/cow_tippings/4`
  - `Body -> raw -> JSON`
```rb
  {
    "name": "Betsy",
    "breed": "Black Baldy",
    "farm": "Where's the Beef"
  }
```
  -  `-> Send`
  #### output
  - `Body -> Pretty -> JSON`

### Wildlife Tracker Challenge

The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

**Story 1**: In order to track wildlife sightings, as a user of the API, I need to manage animals.

**Branch**: animal-crud-actions

**Acceptance Criteria**

- Create a resource for animal with the following information: common name and scientific binomial
- Can see the data response of all the animals
- Can create a new animal in the database
- Can update an existing animal in the database
- Can remove an animal entry in the database

**Story 2**: In order to track wildlife sightings, as a user of the API, I need to manage animal sightings.

**Branch**: sighting-crud-actions

**Acceptance Criteria**

- Create a resource for animal sightings with the following information: latitude, longitude, date
  - Hint: An animal has_many sightings (rails g resource Sighting animal_id:integer ...)
  - Hint: Date is written in Active Record as `yyyy-mm-dd` (“2022-07-28")
- Can create a new animal sighting in the database
- Can update an existing animal sighting in the database
- Can remove an animal sighting in the database

**Story 3**: In order to see the wildlife sightings, as a user of the API, I need to run reports on animal sightings.

**Branch**: animal-sightings-reports

**Acceptance Criteria**

- Can see one animal with all its associated sightings
  - Hint: Checkout [this example](https://github.com/learn-co-students/js-rails-as-api-rendering-related-object-data-in-json-v-000#using-include) on how to include associated records
- Can see all the all sightings during a given time period
  - Hint: Your controller can use a range to look like this:

```ruby
class SightingsController < ApplicationController
  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
  end
end
```

- Hint: Be sure to add the start_date and end_date to what is permitted in your strong parameters method
- Hint: Utilize the params section in Postman to ease the developer experience
- Hint: [Routes with params](./controllers-routes-views.md)

### Stretch Challenges

**Story 4**: In order to see the wildlife sightings contain valid data, as a user of the API, I need to include proper specs.

**Branch**: animal-sightings-specs

**Acceptance Criteria**  
Validations will require specs in `spec/models` and the controller methods will require specs in `spec/requests`.

- Can see validation errors if an animal doesn't include a common name and scientific binomial
- Can see validation errors if a sighting doesn't include latitude, longitude, or a date
- Can see a validation error if an animal's common name exactly matches the scientific binomial
- Can see a validation error if the animal's common name and scientific binomial are not unique
- Can see a status code of 422 when a post request can not be completed because of validation errors
  - Hint: [Handling Errors in an API Application the Rails Way](https://blog.rebased.pl/2016/11/07/api-error-handling.html)

**Story 5**: In order to increase efficiency, as a user of the API, I need to add an animal and a sighting at the same time.

**Branch**: submit-animal-with-sightings

**Acceptance Criteria**

- Can create new animal along with sighting data in a single API request
  - Hint: Look into `accepts_nested_attributes_for`