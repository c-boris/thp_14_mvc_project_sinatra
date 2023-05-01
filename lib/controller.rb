require 'gossip'

class ApplicationController < Sinatra::Base

  get '/' do #page d'accueil qui affiche tous les gossips
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do #page pour créer un nouveau gossip
    erb :new_gossip
  end

  post '/gossips/new/' do #enregistre un nouveau gossip et redirige vers la page d'accueil
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  
  get '/gossips/:id/' do #affiche le gossip correspondant à l'ID donné dans l'URL
    gossip_tab = Gossip.find(params[:id])
    if !gossip_tab[0] && !gossip_tab[1]  && !gossip_tab[2] 
      redirect '/' #si l'ID ne correspond pas à un gossip existant, redirige vers la page d'accueil
    else
      erb :show, locals: {gossip_tab: Gossip.find(params[:id])}
    end
  end
end