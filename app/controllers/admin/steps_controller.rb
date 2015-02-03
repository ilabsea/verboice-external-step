class Admin::StepsController < AdminController

  def index
    @steps = Step.all
  end

  private

  def protected_project_params
    params.require(:step).permit(:project_id)
  end

end
