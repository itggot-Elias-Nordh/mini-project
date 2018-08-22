require 'sinatra'
require 'sqlite3'
require 'byebug'
require 'slim'
require './ClassFix.rb'

require_relative 'modules.rb'
	
	enable:sessions

	get('/') do
		slim(:index)
    end

    post('/start') do
        session[:className] = params[:className]
        session[:difficulty] = params[:difficulty]
        redirect('/game1')
    end

    get('/game1') do
        className = session[:className]
        difficulty = session[:difficulty]
        slim(:game1)
    end