## Rails API and Postman

### API: Application Programming Interface
- allows web applications to communicate with each other
  - transmitting data in the form of JSON (JavaScript Object Notation)
  - API will receive a request from a different application and the API endpoint will respond with the appropriate data

- Generate a resource with appropriate columns and datatypes
  - resource will create a model, controller, view, and routes
  ***NOTE: type is a protected keyword ***
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

**1st Acceptance Criteria**
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

### destroy endpoint
- create branch for the endpoint
- create a controller method
```rb
  def destroy
    cow = CowTipping.find(params[:id])
    cows = CowTipping.all
    cow.destroy
    if cow.valid?
      render json: cows
    else
      render json: cow.errors
    end
  end
```
- Postman to make a request to the endpoint
  #### request
  - `DELETE -> localhost:3000/cow_tippings/4 -> Send`
  #### output
  - `Body -> Pretty -> JSON`


**2nd Acceptance Criteria**

- Create a resource for cow dates with the following information: cow_name, date, match
  - Hint: A cow has_many cow_dates (rails g resource CowDate cow_tipping_id:integer ...)
  - Hint: Date is written in Active Record as `yyyy-mm-dd` (“2022-07-28")

- Establish has many and belongs to relationships

- Stub some entries  
  - > date2 = CowTipping.find 2  
  - > date2.cow_dates.create(cow_name: 'Betsy', date: '2023-09-23', mat
ch: true)  

### index
- create branch for the endpoint
- create a controller method
```rb
  def index
    dates = CowDate.all
    render json: dates
  end
```
- Postman to make a request to the endpoint
  #### request
  - `GET -> localhost:3000/cow_dates -> Send`
  #### output
  - `Body -> Pretty -> JSON`
  - If see some html on the printout, that is an error message
  - `Body -> Preview`

### show endpoint
- create branch for the endpoint
- create a controller method
```rb
  def show
    date = CowDate.find(params[:id])
    render json: date
  end
```
- Postman to make a request to the endpoint
  #### request
  - `GET -> localhost:3000/cow_dates/1 -> Send`
  #### output
  - `Body -> Pretty -> JSON`


### create endpoint
- create branch for the endpoint
- create a controller method
```rb
  def create
    date = CowDate.create(date_params)
    if date.valid?
      render json: date
    else
      render json: date.errors
    end
  end

  private
  def date_params
    # ensure cow tipping id is permitted
    params.require(:cow_date).permit(:cow_tipping_id, :cow_name, :date, :match)
  end
```
- Postman to make a request to the endpoint
  #### request
  - `POST -> localhost:3000/cow_dates`
  - `Body -> raw -> JSON`
```rb
  {
    "cow_tipping_id": 2,
    "cow_name": "Betsy",
    "date": "Belted Galloway",
    "match": true
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
  - `PATCH -> localhost:3000/cow_dates/3`
  - `Body -> raw -> JSON`
```rb
  {
    "cow_tipping_id": 3,
    "cow_name": "Barney",
    "date": "2023-08-28",
    "match": false
  }
```
  -  `-> Send`
  #### output
  - `Body -> Pretty -> JSON`

