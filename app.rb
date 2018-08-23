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
        session[:score] = 0
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
        session[:names] = names.shuffle
        slim(:game1, locals:{className: className, names: names})
    end

    get('/game2/:id') do
        names = session[:names]
        className = session[:className]
        score = session[:score]
        id = params[:id]
        p names[id.to_i]
        slim(:game2, locals:{className: className, id: id, names: names, score:score})
    end

    get('/score') do
        score = session[:score]
        slim(:score, locals:{names: session[:names], score:score})
    end

    post('/answer/:id') do
        names = session[:names]
        id = params[:id].to_i
        answer = params[:answer]
        if answer == names[id]
            session[:score] += 1
        end
        if id == names.length-1
            redirect("/score")
        else
            redirect("/game2/"+(id+1).to_s)
        end
    end


    error 404 do
        slim(:error, :layout => false)
    end

    before '/score' do
        if session[:names] == nil
            halt 404
        end
    end

    before '/game1' do
        if session[:className] == nil
            halt 404
        end
    end

    before '/game2/:id' do
        begin
            if params[:id] == nil or params[:id].to_i < 0 or params[:id].to_i > session[:names].length-1
            halt 404 
            end
        rescue
            halt 404
        end
   end