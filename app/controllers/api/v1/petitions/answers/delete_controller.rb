class Api::V1::Petitions::Answers::DeleteController < ApplicationController

  # DELETE /:enterprise_subdomain/v1/petition/answer/delete/:id
  def destroy
    ::AnswersPetitions::DeleteService.new(answer: answer, user: current_user).call

    render json: {success: true, message: I18n.t('services.answers_petitions.delete.success')}
  end

  private

  def answer
    current_user.answers_petitions.find_by!(id: params[:id])
  end
end
