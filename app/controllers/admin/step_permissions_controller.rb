class Admin::StepPermissionsController < AdminController
  
  def index
    @step = Step.find(params[:step_id])
    @step_permissions = @step.step_permissions.order('created_at DESC').page(params[:page])
  end

  def create
     @step = Step.find(params[:step_id])
     @step_permission = @step.step_permissions.build(filter_params)

     if @step_permission.save
       render layout: false
     else
       render text: @step_permission.errors.full_messages.first, status: 403
     end
  end

  def destroy
    @step_permission = Step.find(params[:step_id]).step_permissions.find(params[:id])
    if(@step_permission.destroy)
      head :ok
    else
      render nothing: true, status: 403
    end

  end

  def filter_params
    params.permit(:user_id, :user_email)
  end

end