require 'lib/comic'

Comics = {
  :bizarro => Comic.new(
    'Bizarro', 'http://www.kingfeatures.com/features/comics/bizarro/about.htm', 'http://est.rbma.com/content/Bizarro?date=%Y%m%d'
  ),
  :non_sequitur => Comic.new(
    'Non Sequitur', 'http://non-sequitur.com', 'http://images.ucomics.com/comics/nq/%Y/nq%y%m%d.gif'
  ),
  :zits => Comic.new(
    'Zits', 'http://www.kingfeatures.com/features/comics/zits/about.htm', 'http://est.rbma.com/content/Zits?date=%Y%m%d'
  ),
  :user_friendly => Comic.new(
    'User Friendly', 'http://www.userfriendly.org', 'http://www.userfriendly.org/cartoons/archives/%y.../uf\d+\.gif', 'http://ars.userfriendly.org/cartoons/?id=%Y%m%d'
  )
}.freeze

set :views, File.dirname(__FILE__) + '/views'

helpers do
  def host_url
    url = "http://#{request.host}"
    url += ":#{request.port}"  if request.port != 80
    url
  end

  def image_url( comic, date, format = 'png' )
    "#{host_url}/comics/#{comic.short_name}-#{date.strftime '%Y%m%d'}.#{format}"
  end
end

get %r{^/comics/(\w+)-(\d+)\.(\w+)$}  do |comic, date, format|
  halt 404  unless @comic = Comics[comic.downcase.to_sym]
  @date = Date.parse date

  response['Cache-Control'] = "public, max-age=#{1.year}"
  return haml(:comic)  if format == 'html'

  format = case format
    when 'png' then  'png'
    when 'jpg' then  'jpeg'
    else  halt 404
  end

  content_type "image/#{format}"
  response['Content-Disposition'] = "inline; filename=\"#{@comic.short_name}-#{@date.to_formatted_s :number}.#{format}\""
  img = @comic.fetch @date
  halt 404  unless img

  img.format = format.upcase
  body img.to_blob
end

get '/comics/:comic.:format' do
  unless @comic = Comics[params['comic'].downcase.to_sym]
    status 404
    return 'Not found'
  end

  if params[:format].downcase != 'rss'
    redirect image_url( @comic, Date.today, params[:format] )
    return
  end

  headers['Cache-Control'] = "public, max-age=#{1.hour}"
  content_type 'application/rss+xml', :charset => 'utf-8'
  haml :'comics.rss', :layout => false
end

get '/comics' do
  haml :comics
end
