require 'pry'

class MusicLibraryController

    attr_accessor :path

    def initialize(path = './db/mp3s')
        @path = path
        MusicImporter.new(@path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."

        puts  "What would you like to do?"
        input = gets
        until input == 'exit'
            puts  "What would you like to do?"
            input = gets
        end
    end

    def list_songs
        song_sort_array = Song.all.collect.sort{|x,y| x.name <=> y.name}
        count = 1
        song_sort_array.each do |song|
            puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            count +=1
            #binding.pry
        end

    end

    def list_artists
        artist_array = Artist.all.collect do |artist|
            artist.name
        end
        artist_sort = artist_array.sort.uniq

        count = 1
        artist_sort.each do |artist|
            puts "#{count}. #{artist}"
            count +=1
        end
    end

    def list_genres

        genre_array = Song.all.collect do |song|
            song.genre.name
        end
        genre_sort = genre_array.sort.uniq

        count = 1
        #binding.pry
        genre_sort.each do |genre|
            puts "#{count}. #{genre}"
            count +=1
        end
    end


    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets
        art = Artist.find_by_name(input)
        if art != nil
            count = 1
            array_songs = art.songs.collect do |s|
                 "#{s.name} - #{s.genre.name}"
            end
            final = array_songs.sort
            final.each do |song|
                 puts "#{count}. #{song}"
                count += 1
            end
        end
    end


    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets
        genre = Genre.find_by_name(input)
        if genre != nil
            count = 1
            array_songs = genre.songs.collect do |s|
                 "#{s.artist.name} - #{s.name}"
            end
            #binding.pry
            # final = array_songs.sort
            array_songs.each do |song|
                 puts "#{count}. #{song}"
                count += 1
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        var =self.list_songs
        var
        input = gets
        number = input.to_i
          binding.pry
         if number > 0 && number <= self.list_songs.length

           self.list_songs.to_a[input + 1].split(" - ").each do |song|
              puts "Playing #{song[0]} by #{song[1]}"
            end

        end
    end
end
