class Api::V1::BaseController < ApplicationController
  layout 'api.v1'
  include Pundit

  rescue_from ::Pundit::NotAuthorizedError, with: :not_found
  rescue_from ::ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ::ActiveRecord::RecordInvalid, with: :invalid

  private

  def invalid(exception)
    @exception = exception
    render 'api/v1/shared/errors/invalid', status: :unprocessable_entity
  end

  def not_found
    render 'api/v1/shared/errors/not_found', status: :not_found
  end
end
