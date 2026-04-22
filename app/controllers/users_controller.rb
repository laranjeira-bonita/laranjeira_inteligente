class UsersController < ApplicationController
  def update
    current_user.update(user_params)
  end

  private
    def user_params
      params.require(:user).permit(:full_name, :document_cpf, :pix_key)
    end
end
