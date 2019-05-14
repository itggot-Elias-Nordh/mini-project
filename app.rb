require 'sinatra'
require 'byebug'
require 'slim'

require_relative 'modules.rb'
	
	enable:sessions

    get('/') do
        session[:start] = false 
        groups = getList()[1]
        slim(:index)
        # , locals:{groups: groups}
    end