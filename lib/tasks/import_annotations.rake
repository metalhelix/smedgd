
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
    annotation_data.each do |annotation|

    end
  end
end
