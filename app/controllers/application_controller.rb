class ApplicationController < ActionController::API
  # If something goes wrong, it could be because of an invalid preview token
  include PrismicService
  include ApplicationHelper

  def api
    @api = Prismic.api('https://tcd-project2.prismic.io/api/v1')
  end

  def ref
    @ref ||= preview_ref || experiment_ref || api.master_ref.ref
  end

  def preview_ref
    if request.cookies.has_key?(Prismic::PREVIEW_COOKIE)
      request.cookies[Prismic::PREVIEW_COOKIE]
    else
      nil
    end
  end

  def experiment_ref
    if request.cookies.has_key?(Prismic::EXPERIMENTS_COOKIE)
      api.experiments.ref_from_cookie(request.cookies[Prismic::EXPERIMENTS_COOKIE])
    else
      nil
    end
  end

end
