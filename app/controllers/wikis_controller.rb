class WikisController < AuthenticatedController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, except: [:index, :new, :create]

  #Comments format
  #HTTP Verb  url
  # GET /wikis
  def index
    authorize Wiki
    @wikis = policy_scope(Wiki)
    # if current_user.role == 'admin' || current_user.role == 'premium'
    #   @wikis = Wiki.all
    # else
    #   @wikis = Wiki.where(private: false)
    # end
  end

  # GET /wikis/1
  def show
    if current_user.present?
      collaborators = []
      @wiki.collaborators.each do |collaborator|
        collaborators << collaborator.email
      end
      unless (@wiki.private == false) || @wiki.user == current_user || collaborators.include?(current_user.email) || current_user.admin? || current_user.premium?
        flash[:alert] = "You are not authorized to view this wiki."
        redirect_to new_charge_path
      end
    else
      flash[:alert] = "You are not authorized to view this wiki."
      redirect_to new_user_registration_path
    end
  end

  # GET /wikis/new
  def new
    authorize Wiki
    @wiki = Wiki.new
  end

  # GET /wikis/1/edit
  def edit
  end

  # POST /wikis
  def create
    authorize Wiki
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators])
      redirect_to @wiki, notice: 'Wiki was successfully created.'
    else
      render :new, alert: 'There was an error creating the wiki. Please try again.'
    end
  end

  # PATCH/PUT /wikis/1
  def update
    @wiki.assign_attributes(wiki_params)

    if @wiki.save && (@wiki.user == current_user || current_user.admin?)
      @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators])
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    elsif @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  # DELETE /wikis/1
  def destroy
    if @wiki.destroy
      redirect_to wikis_url, notice: "\"#{@wiki.title}\" was successfully destroyed."
    else
      render :show, alert: 'There was an error deleting the post.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private, :user_id)
    end

    def authorize_user
      authorize @wiki
    end
end
