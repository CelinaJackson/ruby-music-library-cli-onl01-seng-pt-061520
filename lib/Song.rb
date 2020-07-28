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

def self.new_from_filename(song)
    song_parts = song.split(" - ")
    song_name = song_parts[1]
    artist = Artist.find_or_create_by_name(song_parts[0])
    genre = Genre.find_or_create_by_name(song_parts[2].split('.')[0])
    self.create(song_name, artist, genre)
  end

 def self.create_from_filename(filename)
   self.new_from_filename(filename).save
 end


end
