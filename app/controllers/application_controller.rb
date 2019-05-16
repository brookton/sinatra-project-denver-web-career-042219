class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  require 'yelp/fusion'
  set(:views, 'app/views')
  client = Yelp::Fusion::Client.new(API_KEY)


  get '/' do
    #binding.pry
  @restaurants = Restaurant.all
  @users = User.all
  @reviews = Review.all
  erb :index
  end

  get '/restaurants' do
    @restaurants = Restaurant.all
    erb :'restaurants/index'
  end

  get '/restaurants/new' do
    erb :'restaurants/new'
  end

  post '/restaurants' do
    Restaurant.create(params)
    redirect '/restaurants'
  end

  get "/restaurants/:id" do
    @restaurant = Restaurant.find(params[:id])
    @user = User.all
    @review = Review.all
    erb :'restaurants/show'
  end

  post '/restaurants/api/new' do
    response = client.search(params["city"], term: params["term"])
    arr = []
    response.businesses.each do |value|
        add = {}
        add[:name] = value.name
        add[:rating] = value.rating
        add[:address] = value.location.display_address.join(", ")
        arr << add
    end
    arr
    arr.each do |param|
      Restaurant.create(param)
    end
    redirect '/restaurants'
  end

  put "/restaurants/:id" do
    #binding.pry
    Review.create(restaurant_id: params[:id],user_id:  params["user_id"], rating: nil)
    #@user = User.find(params[:user_id])
    restaurant = Restaurant.find(params[:id])
      #binding.pry
    redirect "/restaurants/#{restaurant.id}"
  end

  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get "/users/new" do
    erb :"users/new"
  end

  get "/users/:id" do
    @user = User.find(params[:id])
    @restaurant = Restaurant.all
    @review = Review.all
    erb :"users/show"
  end

  post "/users" do
    @user = User.create(params)
    redirect "/users/#{@user.id}"
  end

  delete "/users/:id" do
    user = User.find(params[:id])
    user.destroy
    redirect "/users"
  end

  delete "/restaurants/:id" do
    restaurant = Restaurant.find(params[:id])
    restaurant.destroy
    redirect "/restaurants"
  end

end
