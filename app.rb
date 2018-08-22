require 'sinatra'
require 'sqlite3'
require 'byebug'
require 'bcrypt'

require_relative 'modules.rb'
	include ...

	enable:sessions

	get('/') do
		
    end