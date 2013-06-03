require "sinatra"
require "sinatra/reloader"
require "movies"
require "image_suckr"
require "stock_quote"

#Is it possible to make global methods in Sinatra?
# def img_url
#   suckr = ImageSuckr::GoogleSuckr.new
#   @img_url = suckr.get_image_url({"q" => "#{@image}"})
# end

get "/" do
  erb :index
end

get "/movies" do
  erb :movies
end

get "/movies_results" do
    @title = params[:title]

    begin
      @movie = Movies.find_by_title(@title)
      @movie_title = @movie.title
      @movie_rating = @movie.rating
      @movie_director = @movie.director
      @movie_released = @movie.released
      @movie_plot = @movie.plot

      suckr = ImageSuckr::GoogleSuckr.new
      @img_url = suckr.get_image_url({"q" => "#{@title}"})
      erb :movies_results
    rescue
      erb :movies
    end   
end

get "/stocks" do
  erb :stocks
end

get "/stocks_results" do
  @symbol = params[:symbol]
  begin
    @stock = StockQuote::Stock.quote(@symbol)
    @stock_symbol = @stock.pretty_symbol
    @stock_company = @stock.company
    @stock_high = @stock.high
    @stock_low = @stock.low
    @stock_open = @stock.open
    @stock_volume = @stock.volume

    suckr = ImageSuckr::GoogleSuckr.new
    @img_url = suckr.get_image_url({"q" => "#{@stock_company}"})
    erb :stocks_results
  rescue
    erb :stocks #currently returns to stocks page. may want to bring up error message
  end 
end


get "/images" do
  erb :images
end

get "/images_results" do
  @image = params[:image]
  suckr = ImageSuckr::GoogleSuckr.new
  @img_url = suckr.get_image_url({"q" => "#{@image}"})
  erb :images_results
end

get "/images_random" do
  words = ["peonies", "roses", "lily of the valley", "daffodil", "orchids", "narcissus", "iris", 
  "tulips", "daisies", "gardenias", "anemones flower", "hydrangeas", "lilacs", "sunflowers",
  "begonias", "cala lilly", "carnation", "dahlia", "lavender", "pansy", "oriental lily" ]
  @item = words.sample

  suckr = ImageSuckr::GoogleSuckr.new
  @img_url = suckr.get_image_url({"q" => "#{@item}"})
  erb :images_results
end
