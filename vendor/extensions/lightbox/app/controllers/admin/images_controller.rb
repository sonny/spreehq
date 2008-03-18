class Admin::ImagesController < ApplicationController
  def new
    @image = Image.new
    render :layout => false
  end

  def delete
    image = Image.find(params[:id])
    viewable = image.viewable
    image.destroy
    render :partial => 'shared/images', :locals => {:viewable => viewable}
  end
end
