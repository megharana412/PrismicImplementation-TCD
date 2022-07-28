class AboutController < ApplicationController
  def index
    api = Prismic.api('https://tcd-project2.prismic.io/api/v1')
    
    response = api.all({
        "page" => params[:page] ? params[:page] : "1",
        "page_size" => params[:page_size] ? params[:page_size] : "20",
        "ref" => ref})
    @documents = response.results[0]
  end

  # Single-document page action: mostly, setting the @document instance variable, and checking the URL
  def document
    id = params[:id]
    slug = params[:slug]

    @google_id = api.experiments.current
    @document = api.getByID(id, {"ref" => ref})

    # This is how an URL gets checked (with a clean redirect if the slug is one that used to be right, but has changed)
    # Of course, you can change slug_checker in prismic_service.rb, depending on your URL strategy.
    @slug_checker = PrismicService.slug_checker(@document, slug)
    if !@slug_checker[:correct]
      render inline: "Document not found", status: :not_found if !@slug_checker[:redirect]
      redirect_to document_path(id, @document.slug), status: :moved_permanently if @slug_checker[:redirect]
    end
  end

  # Search result: querying all documents containing the q parameter
  def search
    @google_id = api.experiments.current
    @documents = api.form('everything')
                    .query(Prismic::Predicates.fulltext('document', params[:q]))
                    .page(params[:page] ? params[:page] : '1')
                    .page_size(params[:page_size] ? params[:page_size] : '20')
                    .submit(ref)
  end


  # For writers to preview a draft with the real layout
  def preview
    api = Prismic.api('https://tcd-project2.prismic.io/api/v1')
    preview_token = params[:token]
    redirect_url = api.preview_session(preview_token, link_resolver(), '/')
    cookies[Prismic::PREVIEW_COOKIE] = { value: preview_token, expires: 30.minutes.from_now }
    redirect_to redirect_url
  end

end