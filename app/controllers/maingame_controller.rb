class MaingameController < ApplicationController
  #require_dependency 'bot'

  def index
    @posts = Woolentry.all
        @hash = Gmaps4rails.build_markers(@posts) do |wool, marker|
          marker.lat wool.lat
          marker.lng wool.long
          marker.json({ :id => wool.id })
          marker.infowindow render_to_string(:partial => "markertext", :locals => { :p => wool})
          marker.picture({
   "url" => 'https://static.maplewiki.net/6/6a/Red_Ball_of_Yarn.gif',
   "width" =>  '16',
   "height" => '16'
   })
        end
  end



  def create

    @inputpointname = params[:pointname]
    @inputpointwhere = params[:pointwhere]
    @inputpointwhat = params[:pointwhat]
    @mapinfo = Geocoder.search(@inputpointwhere)
    @newwool = Woolentry.new
    @newwool.lat = @mapinfo[0].latitude
    @newwool.long = @mapinfo[0].longitude
    @newwool.desc = @inputpointname
    @newwool.save
    respond_to do |format|
      format.js

    end


  end
end
