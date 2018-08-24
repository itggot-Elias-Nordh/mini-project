require 'sinatra'
require 'byebug'
require 'slim'
require './ClassFix.rb'

require_relative 'modules.rb'
	
	enable:sessions

    get('/') do
        session[:start] = false 
        groups = getList()[1]
		slim(:index, locals:{groups: groups})
    end

    post('/start') do
        session[:start] = true 
        session[:times] = 0
        session[:cheat] = 0
        session[:className] = params[:className]
        session[:difficulty] = params[:difficulty]
        session[:score] = 0
        redirect('/game1')
    end

    get('/game1') do
        session[:times] += 1
        if session[:start] == nil or session[:start] == false
            redirect('/')
        end
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
        if names.length < 4
            session[:error] = "Too few students"
			session[:back] = "/"
			halt 404
        end
        if session[:times] > 1
            session[:error] = "You are not allowed to view this page"
            if session[:times] > names.length
                session[:back] = "/score"
            else
                session[:cheat] += 1
                session[:times] = session[:times] - 2
                session[:back] = "/game2/#{session[:times] - 1}"
            end
            halt 404
        end
        session[:names] = names.shuffle
        slim(:game1, locals:{className: className, names: names})
    end

    get('/game2/:id') do
        session[:times] += 1
        if session[:start] == nil or session[:start] == false
            redirect('/')
        end
        names = session[:names]
        className = session[:className]
        score = session[:score]
        id = params[:id]
        slim(:game2, locals:{className: className, id: id, names: names, score:score})
    end

    get('/score') do
        session[:times] += 1
        if session[:start] == nil or session[:start] == false
            redirect('/')
        end
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
        error = session[:error]
		back = session[:back]
        slim(:error, locals:{error: error, back: back})
    end