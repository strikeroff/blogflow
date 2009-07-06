class AssetsController < ApplicationController
  def create
    @asset = Asset.new(params[:asset])
    respond_to do |format|
      if @asset.save
        flash[:notice] = 'Asset was successfully created.'
        format.html { redirect_to asset_url(@asset) }
        format.xml  { head :created, :location => asset_url(@asset) }
        format.js do
          responds_to_parent do
            render :update do |page|
              page.insert_html :bottom, "assets", :partial => 'assets/list_item', :object => @asset
              page.visual_effect :highlight, "asset_#{@asset.id}"
            end
          end
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors.to_xml }
        format.js do
          responds_to_parent do
            render :update do |page|
              # update the page with an error message
            end
          end
        end
      end
    end
  end

  def destroy
    asset = Asset.find(params[:id]).destroy
    respond_to do |format|
      format.html do
        render :update do |page|
          # update the page deleting element
          page.replace_html "asset_#{asset.id}", "Удалено"
        end
      end
    end
  end

  def download
    @asset = Asset.find(params[:id])
    send_file("#{RAILS_ROOT}/public/documents/#{@asset.id}/original/#{@asset.document_file_name}",
            :disposition => 'attachment',
            :encoding => 'utf8',
            :type => @asset.document_content_type,
            :filename => URI.encode(@asset.document_file_name))
  end
end
