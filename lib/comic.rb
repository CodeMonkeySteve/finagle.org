require 'open-uri'

class Comic
  attr_accessor :name, :link, :page, :image

  def initialize( name, link, image, page = nil )
    @name, @link, @image, @page = name, link, image, page
  end

  def short_name
    name.downcase.gsub %r{\s+}, '_'
  end

  def fetch( date )
    time = date.to_time
    img_url = time.strftime self.image
    if self.page
      page_url = URI.parse time.strftime(self.page)
      img_url = open(page_url) { |io| io.read.match(img_url)[0] }
      img_url = URI.parse img_url
      img_url.scheme ||= page_url.scheme
      img_url.host ||= page_url.host
    else
      page_url = self.link
    end

#puts "Fetch: #{img_url}"
    data = open(img_url.to_s, 'Referer' => page_url.to_s) { |io|  io.read }
    Magick::Image.from_blob(data).first
  end

end
