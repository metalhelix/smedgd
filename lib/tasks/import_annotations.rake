
def parse_annotation_file filename
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

namespace :import do
  desc "Import annotations file"
  task :annotations => :environment do
    # filename = File.join(File.dirname(__FILE__), "..", "data", "Smed_combined_annotation_20130220.txt")
    filename = File.join(File.dirname(__FILE__), "..", "data", "really_short.txt")
    annotation_data = parse_annotation_file filename
    genome = Genome.new(:organism => "smed_transcriptome", :version => "0.1")
    # genome = Genome.find_or_create_by_organism("smed_transcriptome")
    # genome.version = "0.1"
    swiss_prot = DataSet.find_or_create_by_name("Swiss-Prot")

    ncbi = DataSet.find_or_create_by_name("NCBI")
    genome.save!
    annotation_data.each_with_index do |annotation_line, index|

      feature = Feature.find_or_create_by_name(annotation_line["seq_id"])
      genome.features << feature

      if annotation_line['sp_symbol'] != "0"
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

      if annotation_line["reciprocal_id"] != "0"
        annotation = Annotation.new(:category => "ncbi_annotation", :description => annotation_line["smed_ncbi_description"], :value => annotation_line["reciprocal_id"], :score => annotation_line["score"].to_f)

        ncbi.annotations << annotation
        feature.annotations << annotation

        annotation.save!
      end

      length = FeatureAttribute.new(:name => "length", :category => "length", :value => annotation_line["length"].to_f)

      gc_percentage = FeatureAttribute.new(:name => "gc_percentage", :category => "gc_percentage", :value => annotation_line["gc_percentage"])

      longest_orf = FeatureAttribute.new(:name => "longest_orf", :category => "longest_orf", :value => annotation_line["longest_orf_length"])

      longest_orf_strand = FeatureAttribute.new(:name => "longest_orf_strand", :category => "longest_orf_strand", :value => annotation_line["longest_orf_strand"])

      feature.feature_attributes.concat([length, gc_percentage, longest_orf, longest_orf_strand])

      if index % 100 == 0
        puts feature.name
      end
    end
  end
end
