require_relative 'inc_helper'
class Menu

  # Customization of console color
  RED = "\e[31m"
  GREEN = "\e[32m"
  YELLOW = "\e[33m"
  BLUE = "\e[34m"
  MAGENTA = "\e[35m"
  CYAN = "\e[36m"

  def initialize(catalog_management)
    @catalog_management = catalog_management
  end

  MENU_OPTIONS = {
    1 => { label: 'List all books', action: :list_all_books },
    2 => { label: 'List all music Album', action: :list_all_music_albums },
    3 => { label: 'list all games', action: :list_all_games },
    4 => { label: 'list all source', action: :list_all_sources },
    5 => { label: 'list all genres', action: :list_all_genres },
    6 => { label: 'list all authors ', action: :list_all_authors },
    7 => { label: 'add book ', action: :add_book },
    8 => { label: 'add music Album ', action: :add_music_album },
    9 => { label: 'add games ', action: :add_games },
    10 => { label: 'add genre ', action: :add_genre },
    11 => { label: 'Quit ', action: :quit },
  }.freeze

  def display_menu
    puts "\n #{CYAN}Catalog of my Things: "
    MENU_OPTIONS.each do |key, value|
      puts "#{YELLOW} #{key}. #{value[:label]}"
    end
    print "\n#{CYAN}Enter your choice: "
  end

  def handle_choice(choice)
    if MENU_OPTIONS.key?(choice)
      action = MENU_OPTIONS[choice][:action]
      send(action)
    else
      puts "\nInnvalid choice, Please try again !."
    end
  end

  def valid_choice?(choice)
    (1..11).include?(choice)
  end

  def add_music_album

    puts"\nAdding Music Album"
    print 'Enter the Genre name: '
    genre_name= gets.chomp
    genre = @catalog_management.genres.find {|g| g.name == genre_name}
    if genre.nil?
      genre = Genres.new(genre_name)
      @catalog_management.add_genre(genre)
    end

    print "Enter the author: "
    author = gets.chomp
    print "Enter the label: "
    label = gets.chomp
    print "Enter the source: "
    source = gets.chomp
    print "Enter the published date: "
    published_date = gets.chomp
    print "Is it on Spotify? (true/false): "
    on_spotify = gets.chomp.downcase == 'true'

    music_album = Music_album.new(genre, author, label, source, published_date, on_spotify)
    @catalog_management.add_music_album(music_album)

    puts "\n#{GREEN}Music Album added successfully!"
  end

  def add_genre
    puts "\nAdding a Genre"
    print "Enter the name of the Genre: "
    genre_name = gets.chomp

    if @catalog_management.genres.any?{|g| g.name == genre_name}
      puts "#{RED} Genre #{genre_name} is already exist."
    else
     genre = Genres.new(genre_name)
     @catalog_management.add_genre(genre)
     puts "\n #{GREEN} Genres is successfuly created !."
    end
  end

  def list_all_genres
    @catalog_management.genres.each do |genres|
      puts "ID: #{genres.id}, Name: #{genres.name}"
    end
  end

  def list_all_music_albums
    puts "\nList of All Music Albums:"
    if @catalog_management.items.empty?
      puts "No music albums in the catalog."
    else
      @catalog_management.items.each_with_index do |music_album, index|
        puts "#{index + 1}. Title: #{music_album.lebel}"
        puts "   Genre: #{music_album.genre.name}"
        puts "   Author: #{music_album.author}"
        puts "   Source: #{music_album.source}"
        puts "   Published Date: #{music_album.published_date}"
        puts "   On Spotify: #{music_album.on_spotify ? 'Yes' : 'No'}"
      end
    end
  end

  def quit
    puts "\n#{RED}Thank you visiting Catalog, Good bye.."
    exit
  end

end