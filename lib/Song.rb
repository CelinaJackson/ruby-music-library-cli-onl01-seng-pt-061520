class Song

attr_accessor :name, :artist, :genre, :musicimporter, :musiclibrarycontroller

@@all = []

def initialize(name, artist=nil, genre=nil)
  @name = name
  self.artist=(artist) if artist != nil
  self.genre=(genre) if genre != nil
end

def self.all
  @@all
end

def save
  @@all << self
end

def self.create(song)
  song = self.new(song)
  song.save
  song
end

def self.destroy_all
  @@all.clear
end

def artist
  @artist
end

def genre
  @genre
end

def artist=(artist)
  @artist = artist
  artist.add_song(self)
end

def genre=(genre)
  @genre = genre
  genre.songs << self unless genre.songs.include?(self)
end

def self.find_by_name(name)
  @@all.detect do |song|
    song.name == name
  end
end

def self.find_or_create_by_name
  @@all.detect do |song|
    if song.name == name
      song
    else
      self.create(name)
    end
  end
  self.find_by_name(name) || self.create(name)
end

 def self.new_from_filename(filename)
   song_name = name.split(" - ")[1]
   artist_name = name.split(" - ")[0]
   genre_name = name.split(" - ")[2].chomp(".mp3")
   song = self.find_or_create_by_name(song_name)
   song.artist = Artist.find_or_create_by_name(artist_name)
   song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end

 def self.create_from_filename(filename)
   @@all << self.new_from_filename(filename)
 end


end
