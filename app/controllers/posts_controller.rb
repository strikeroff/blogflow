class PostsController < ResourceController::Base
  before_filter :require_user
  layout "posts"



  new_action.before do
    #    @upload_file = UploadedFile.new
    tag_cloud
  end

  create.before do
    object.author_id = current_user.id

    unless params[:assets].blank?
      @asset_ids = params[:assets].collect{|v|v[0].gsub("asset_", "")}
      @asset_ids.compact.uniq!
    end
    @asset_ids ||= []

  end
  create.after do
    @asset_ids.each do | asset_id|
      @object.assets  << Asset.find(asset_id)
    end
  end

  edit.wants.html do
    tag_cloud
    render :action=> "new"
  end
  update.before do
    unless params[:assets].blank?
      @asset_ids = params[:assets].collect{|v|v[0].gsub("asset_", "")}
      @asset_ids.compact.uniq!
      @asset_ids.each do | asset_id|
        @object.assets  << Asset.find(asset_id)
      end
    end
  end

  show.before do
    tag_cloud
  end
  update.wants.html do
    redirect_to post_url(@object)
  end

  index.before do
    tag_cloud
    @users_in_list = all_users_for_posts_list(@posts)
  end

  def tag
    @posts = Post.find_tagged_with(params[:id], :match_all => true)
    @tag_name = params[:id]
    @users_in_list = all_users_for_posts_list(@posts)
    tag_cloud
    render :action=>'index'
  end

  #  def upload_file_save
  #    @upload_file = UploadedFile.new(params[:uploaded_file]).save
  #    render :text=> @upload_file.to_json
  #  end


  private


  def all_users_for_posts_list(list)
    return [] if list.blank? || !list[0].is_a?(Post)
    users_in_list = list.collect(&:author_id).compact.uniq
    User.find :all, :conditions=>["id IN (?)", users_in_list]
  end

  def tag_cloud
    @tags = Post.tag_counts
  end

end
