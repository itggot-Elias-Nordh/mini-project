require 'sinatra'
require 'byebug'
require 'slim'
require './ClassFix.rb'

require_relative 'modules.rb'
	
	enable:sessions

    get('/') do
        groups = getList()[1]
		slim(:index, locals:{groups: groups})
    end

    post('/start') do
        session[:className] = params[:className]
        session[:difficulty] = params[:difficulty]
        redirect('/game1')
    end

    get('/game1') do
        className = session[:className]
        difficulty = session[:difficulty].to_i
        names = getList()[0][className].shuffle
        if difficulty == 2
        elsif difficulty == 1
            size = (names.length/2).to_i
            names = names[0...size]
        else
            size = (names.length/4).to_i
            names = names[0...size]
        end
        session[:names] = names
        slim(:game1, locals:{className: className, names: names})
    end

    get('/game2/:id') do
        names = session[:names]
        className = session[:className]
        id = params[:id]
        slim(:game2, locals:{className: className, id: id, names: names})
    end