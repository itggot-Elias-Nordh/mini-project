require 'sinatra'
require 'sqlite3'
require 'byebug'
require 'bcrypt'

require_relative 'modules.rb'
	include ...

	enable:sessions

	get('/') do
		slim(:index)
    end

    post('/') do
        session[:className] = params[:className]
        session[:difficulty] = params[:difficulty]
        redirect('/start')
    end

    get('/start') do
        className = session[:className]
        difficulty = session[:difficulty]
        slim(:start)
    end