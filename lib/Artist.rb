class Artist

attr_accessor :name, :song, :musiclibrarycontroller, :musicimporter
extend Concerns::Findable
@@all = []

def initialize(name)
  @name = name
  @songs = [ ]
end

def self.all
  @@all
end

def save
  @@all << self
end

def self.create(artist)
  artist = self.new(artist)
  artist.save
  artist
end

def self.destroy_all
  @@all.clear
end

def songs
  @songs
end

def add_song(song)
  if song.artist == nil
    song.artist = self
  else
    nil
  end
  if @song.include?(song)
    nil
  else
    @songs << song
  end
  song
end

def genres
  genres = @songs.collect do |song|
    song.genre
  end
  genres.uniq
end
end
