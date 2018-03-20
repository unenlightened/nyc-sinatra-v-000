class LandmarksController < ApplicationController
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'landmarks/edit'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name])

    @landmark.titles = params[:landmark][:title_ids].map{|title| Title.find_by(name: title)} if params[:landmark][:title_ids]
    @landmark.landmarks = params[:landmark][:landmark_ids].map{|landmark| Landmark.find_by(name: landmark)} if
    params[:landmark][:landmark_ids]

    @landmark.titles << Title.create(name: params[:title][:name]) if !params[:title][:name].empty?
    @landmark.landmarks << Landmark.create(name: params[:landmark][:name]) if !params[:landmark][:name].empty?

    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    @landmark.name = params[:landmark][:name]

    @landmark.titles = params[:landmark][:title_ids].map{|title| Title.find_by(name: title)} if params[:landmark][:title_ids]
    @landmark.landmarks = params[:landmark][:landmark_ids].map{|landmark| Landmark.find_by(name: landmark)} if
    params[:landmark][:landmark_ids]

    @landmark.titles << Title.create(name: params[:title][:name]) if !params[:title][:name].empty?
    @landmark.landmarks << Landmark.create(name: params[:landmark][:name]) if !params[:landmark][:name].empty?

    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end
end
