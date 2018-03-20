class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'figures/edit'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])

    @figure.titles = params[:figure][:title_ids].map{|title| Title.find_by(name: title)} if params[:figure][:title_ids]
    @figure.landmarks = params[:figure][:landmark_ids].map{|landmark| Landmark.find_by(name: landmark)} if
    params[:figure][:landmark_ids]

    @figure.titles << Title.create(name: params[:title][:name]) if !params[:title][:name].empty?
    @figure.landmarks << Landmark.create(name: params[:landmark][:name]) if !params[:landmark][:name].empty?

    @figure.save

    redirect "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.name = params[:figure][:name]

    @figure.titles = params[:figure][:title_ids].map{|title| Title.find_by(name: title)} if params[:figure][:title_ids]
    @figure.landmarks = params[:figure][:landmark_ids].map{|landmark| Landmark.find_by(name: landmark)} if
    params[:figure][:landmark_ids]

    @figure.titles << Title.create(name: params[:title][:name]) if !params[:title][:name].empty?
    @figure.landmarks << Landmark.create(name: params[:landmark][:name]) if !params[:landmark][:name].empty?

    @figure.save

    redirect "/figures/#{@figure.id}"
  end
end
