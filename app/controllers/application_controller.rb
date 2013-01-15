class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :get_organism

  def get_organism
    organism_key = session[:organism_current]
      # @issuer = Issuer.find_by_name(request.subdomain)
      # if !@issuer
      #   redirect_to new_issuer_path()
      #   return
      # end
    @organism = Organism.find_by_key(organism_key)
    if !@organism
      @organism = Organism.find(1)
    end
    @organism
  end

end
