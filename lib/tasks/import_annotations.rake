
# expected headers:
# seq_id reciprocal_id reciprocal_rank sp_symbol sp_evalue sp_description pfam_ids go_ids

def parse_annotation_file filename
  lines = File.open(filename,'r').read.split("\n")
  puts lines.size
  bad_header = lines.shift.split("\t")
  header = %w'seq_id reciprocal_id reciprocal_rank sp_symbol sp_evalue sp_description pfam_ids go_ids'
  data = []
  lines.each do |line|
    fields = line.split("\t")
    fields = fields.collect {|f|  (f == "#N/A") ? nil : f}
    d = Hash[header.zip(fields)]
    d['pfam_ids'] = (d['pfam_ids']) ? d['pfam_ids'].split(";") : []

    d['go_ids'] = (d['go_ids']) ? d['go_ids'].split(";") : []
    data << d
  end
  data
end

def load_go_terms filename
  lines = File.open(filename,'r').read.split("\n")
  puts lines.size
  header = lines.shift.split("\t")
  terms = {}
  lines.each do |line|
    fields = line.split("\t")
    d = Hash[header.zip(fields)]
    terms[d['Accession']] = d
  end
  terms
end

def parse_old_annotation_file filename
  lines = File.open(filename,'r').read.split("\n")
  header = lines.shift.split("\t")
  data = []
  lines.each do |line|
    fields = line.split("\t")
    d = Hash[header.zip(fields)]
    data << d
  end
  data
end

def merge_go_terms annotations, go_terms
  annotations.each do |annotation|
    annotation['go_ids'] = annotation['go_ids'].collect do |t|
      go = go_terms[t]
      if !go
        puts "ERROR: no go term for #{t}"
        go = {'Accession'=> t}
      else
        puts "FOUND: #{t}"
      end
      go
    end
  end
  annotations
end

namespace :import do

  task :test => :environment do
    filename = File.join(File.dirname(__FILE__), "..", "data", "S1_Smed_maker_annotations_sexual.txt")
    annotation_data = parse_annotation_file filename
    puts annotation_data[0].inspect
  end

  desc "Import annotations file"
  task :annotations => :environment do
    filename = File.join(File.dirname(__FILE__), "..", "data", "final_sexual_short.txt")
    # filename = File.join(File.dirname(__FILE__), "..", "data", "S1_Smed_maker_annotations_sexual.txt")

    go_term_filename = File.join(File.dirname(__FILE__), "..", "data", "smed_go.txt")

    go_terms = load_go_terms(go_term_filename)
    annotation_data = parse_annotation_file filename

    annotation_data = merge_go_terms(annotation_data, go_terms)
    genome = Genome.new(:organism => "smed_transcriptome_sexual_s1", :version => "0.1")
    # genome = Genome.find_or_create_by_organism("smed_transcriptome")
    # genome.version = "0.1"
    swiss_prot = DataSet.find_or_create_by_name("Swiss-Prot")

    ncbi = DataSet.find_or_create_by_name("NCBI")

    go = DataSet.find_or_create_by_name('GO')
    genome.save!
    annotation_data.each_with_index do |annotation_line, index|

      feature = Feature.find_or_create_by_name(annotation_line["seq_id"])
      genome.features << feature

      if annotation_line['sp_symbol']
        annotation = Annotation.new(:category => "protein_homology", :description => annotation_line["sp_description"], :value => annotation_line["sp_symbol"])
        swiss_prot.annotations << annotation
        if annotation_line["sp_evalue"]
          annotation.score = annotation_line["sp_evalue"].to_f
        end
        # feature.save!
        feature.annotations << annotation
        # annotation.feature = feature
        annotation.save!
      end

      if annotation_line["reciprocal_id"]
        annotation = Annotation.new(:category => "ncbi_annotation", :description => annotation_line["smed_ncbi_description"], :value => annotation_line["reciprocal_id"], :score => annotation_line["reciprocal_rank"].to_f)

        ncbi.annotations << annotation
        feature.annotations << annotation

        annotation.save!
      end

      annotation_line['go_ids'].each do |go_object|
        annotation = Annotation.new(:category => 'go_term', :description => go_object['Term'], :value => go_object['Accession'])

        go.annotations << annotation
        feature.annotations << annotation
        annotation.save!
      end

      annotation_line['pfam_ids'].each do |pfam_id|
        annotation = Annotation.new(:category => 'pfam', :value => pfam_id)
        feature.annotations << annotation
        annotation.save!
      end


      # length = FeatureAttribute.new(:name => "length", :category => "length", :value => annotation_line["length"].to_f)

      # gc_percentage = FeatureAttribute.new(:name => "gc_percentage", :category => "gc_percentage", :value => annotation_line["gc_percentage"])

      # longest_orf = FeatureAttribute.new(:name => "longest_orf", :category => "longest_orf", :value => annotation_line["longest_orf_length"])

      # longest_orf_strand = FeatureAttribute.new(:name => "longest_orf_strand", :category => "longest_orf_strand", :value => annotation_line["longest_orf_strand"])

      # feature.feature_attributes.concat([length, gc_percentage, longest_orf, longest_orf_strand])

      if index % 100 == 0
        puts feature.name
      end
    end
  end
end
