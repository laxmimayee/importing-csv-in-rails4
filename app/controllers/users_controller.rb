class UsersController < ApplicationController
  
  def index(new_user_errors=nil)
    @new_user = new_user_errors
    @user = User.all  
  end
  def new
  	@user = User.new
  end

def create
  @user = User.new(user_params)
  @user.save
  redirect_to @user
end


 def import
if params[:file]
  @new_user_errors=User.import(params[:file])
else
  redirect_to root_url , notice: "Please Select CSV Files TO IMPORT....."
return
end
if @new_user_errors
index(@new_user_errors)
render :action => 'index'
else
      redirect_to root_url , notice: "Products imported."
end
    #end
  end
def user_params
    params.require(:user).permit(:name, :age, :favorite_food)
  end

end
