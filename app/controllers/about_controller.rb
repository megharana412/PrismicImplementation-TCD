class AboutController < ApplicationController

  def index
    response = api.query(
      Prismic::Predicates.at("document.type", "about")
      )
    @documents = response.results
    render '/about/index'
  end
end
