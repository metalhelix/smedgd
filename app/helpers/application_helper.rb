module ApplicationHelper

  def link_to_protein(protein_id)
    link_to(protein_id, "http://www.uniprot.org/uniprot/#{protein_id}", :target => "_blank")
  end

  def link_to_go(go_name, go_id)
    go_name ||= go_id
    link_to(go_name, "http://flybase.org/cgi-bin/cvreport.html?id=#{go_id}", :target => "_blank")
  end

  def link_to_pfam(name, id = name)
    link_to(name, "http://pfam.sanger.ac.uk/family/#{id}", :target => "_blank")
  end

  def link_to_gbrowse(reference_name)
    link_to(reference_name.gsub("_", " "), "/cgi-bin/gb2/gbrowse/#{reference_name}")
  end
end
