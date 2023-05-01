require 'csv'

class Gossip
  attr_accessor :name, :content
  
  def initialize(user_name, user_content) #constructeur de la classe Gossip, prend deux arguments
    @name = user_name
    @content = user_content
  end

  def save #sauvegarde l'objet actuel dans un fichier CSV
    data = [@name, @content]
    CSV.open("db/gossip.csv", "ab"){|content|content << data} #ouvre le fichier CSV en mode append, ajoute les données de l'objet Gossip dans le fichier
  end

  def self.all #lit le fichier CSV et renvoie toutes les entrées sous forme de tableau
    return CSV.parse(File.read('db/gossip.csv'), headers: false)
  end
  
  def self.find(index) #prend un argument index, renvoie un tableau contenant l'indice, le nom et le contenu du Gossip correspondant à cet indice
    data_all = all() #récupère toutes les données du fichier CSV
    if index.to_i + 1 > data_all.length || index.to_i < 0 #vérifie si l'indice est valide
      return [nil, nil, nil] #renvoie un tableau vide s'il n'est pas valide
    else
      return [index, data_all[index.to_i][0], data_all[index.to_i][1]] #renvoie le tableau contenant l'indice, le nom et le contenu correspondant à l'indice
    end
  end

  def self.find_index(name, value) #prend deux arguments name et value, renvoie l'indice de l'entrée correspondante dans le fichier CSV
    i = 0
    CSV.foreach('db/gossip.csv'){|tab_index|
      if tab_index[0] == name && tab_index[1] == value #vérifie si l'entrée correspond à l'argument name et value
        return i #renvoie l'indice de l'entrée si elle correspond à l'argument name et value
      end
      i += 1
    }
  end
end