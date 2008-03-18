class Admin::GalleryController < ApplicationController
  def index
    @galleries = Gallery.find(:all)
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      flash[:notice] = 'Gallery was successfully created.'
      redirect_to :action => 'index'
    else
      flash[:error] = 'Unable to create gallery.'
      render :action => 'new'
    end
  end

  def destroy
    Gallery.destroy(params[:id])
    flash[:notice] = "Gallery was successfully removed."
    redirect_to :action => 'index'
  end  
  
  def edit
    @gallery = Gallery.find(params[:id])
    #session[:slideshow] = @slideshow
    #@photos = unused_photos(@slideshow)
  end
  
  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      if params[:image]
        @gallery.images << Image.new(params[:image])
        @gallery.save!
      end
      flash[:notice] = 'Gallery was successfully updated.'
      redirect_to :action => 'edit', :id => @gallery and return
    else
      render :action => 'edit', :id => @gallery
    end
  end    
end
