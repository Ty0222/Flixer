class Genre
  include ActiveModelNaming
  include DataAccess::Builder

  attr_reader :id, :name

  builds_object :genre_list, mappings: {id: "id", name: "name"}

  def self.all
    build_genre_list_with genre_list_source.call
  end

  
  private

    def self.genre_list_source
      @genre_list_source ||= GenreAdapter.singleton_method(:all_genres)
    end

    def self.genre_list_source=(source)
      @genre_list_source = source
    end
	
end
