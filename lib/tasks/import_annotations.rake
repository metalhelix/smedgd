
def parse_annotation_file filename
  lines = File.open(filename,'r').read.split("\n")
  header = lines.shift.split("\t")
  data = []
  lines.each do |line|
    fields = line.split("\n")
    d = Hash[header.zip(fields)]
    data << d
  end
  data
end

namespace :import do
  desc "Import annotations file"
  task :annotations => :environment do
    filename = File.join(File.dirname(__FILE__), "..", "data", "Smed_combined_annotation_20130220.txt")
    annotation_data = parse_annotation_file filename
    genome = Genome.new(:organism => "smed_transcriptome", :version => "0.1")
    swiss_prot = DataSet.find_or_create_by_name("Swiss-Prot")
    genome.save!
    annotation_data.each do |annotation|
      feature = Feature.find_or_create_by_name(annotation["seq_id"])
      annotation = Annotation.new(:type => "protein_homology", :description => annotation["sp_description"], :value => annotation["sp_symbol"])
      swiss_prot.annotations << annotation
      if annotation["sp_evalue"]
        annotation.score = annotation["sp_evalue"]
      end
      annotation.save!

    end
  end
end
