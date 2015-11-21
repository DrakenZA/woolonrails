class WoolentriesController < ApplicationController


def searchmap
  @search = params[:searchinput]


  respond_to do |format|

   format.js
  format.html
  end

end

def showpopupmodal


  respond_to do |format|

   format.js
  format.html
  end
end



  def edit

  @cwool = Woolentry.find_by_id(params[:id])

  respond_to do |format|

   format.js
  format.html
  end


  end

  def listall
  @wools = Woolentry.all
  respond_to do |format|

   format.js
  format.html
end

  end


  def destroy

    @deletewool = Woolentry.find_by_id(params[:id])
    @deletewoolid = @deletewool.id
    @deletewool.destroy

    respond_to do |format|

     format.js
    format.html
  end



  end

  def index
    @posts = Woolentry.all
        @hash = Gmaps4rails.build_markers(@posts) do |wool, marker|
          marker.lat wool.lat
          marker.lng wool.long
          marker.json({ :id => wool.id })
          marker.json({ :person => wool.person })

          marker.infowindow render_to_string(:partial => "markertext", :locals => { :p => wool})
          marker.picture({
   "url" => 'https://static.maplewiki.net/6/6a/Red_Ball_of_Yarn.gif',
   "width" =>  '16',
   "height" => '16'
   })
        end
  end



def update

  @inputphonenum = params[:phonenum]
  @inputpointname = params[:pointname]
  @inputpointwhere = params[:pointwhere]
  @inputpointwhat = params[:pointwhat]
  @mapinfo = Geocoder.search(@inputpointwhere)
  @savable = true

  if @mapinfo == []
    @error = "couldnt find location"
    @savable = false
  end

  if @inputphonenum == ""
    @error = "phone number is empty"
    @savable = false

  end

  if @inputpointname == ""
    @error = "name number is empty"
    @savable = false

  end

  if @inputpointwhat == ""
    @error = "wool was empty"
    @savable = false

  end

  if @savable
  @newwool = Woolentry.find_by_id(params[:id])
  @newwool.lat = @mapinfo[0].latitude
  @newwool.long = @mapinfo[0].longitude
  @newwool.desc = @inputpointwhat
  @newwool.person = @inputpointname
  @newwool.phonenum = @inputphonenum
  @newwool.save

  end
  # redirect_to '#index', notice: "Record updated"
   respond_to do |format|
     format.js
     format.html
   end


end

  def create
    @inputphonenum = params[:phonenum]
    @inputpointname = params[:pointname]
    @inputpointwhere = params[:pointwhere]
    @inputpointwhat = params[:pointwhat]
    @mapinfo = Geocoder.search(@inputpointwhere)
    @savable = true

    if @mapinfo == []
      @error = "couldnt find location"
      @savable = false
    end

    if @inputphonenum == ""
      @error = "phone number is empty"
      @savable = false

    end

    if @inputpointname == ""
      @error = "name number is empty"
      @savable = false

    end

    if @inputpointwhat == ""
      @error = "wool was empty"
      @savable = false

    end

    if @savable
    @newwool = Woolentry.new
    @newwool.lat = @mapinfo[0].latitude
    @newwool.long = @mapinfo[0].longitude
    @newwool.desc = @inputpointwhat
    @newwool.person = @inputpointname
    @newwool.phonenum = @inputphonenum
    @newwool.save
    end

    # redirect_to '#index', notice: "Record added"
     respond_to do |format|
       format.js
       format.html
     end


  end

end
