require 'rubygems'
require 'zip'
require 'nokogiri'
require 'fileutils'
require 'debugger'

#Given an ebook, unzip it to a given directory
def unzip(ebook, folder=nil)
	Zip::File.open(ebook) do |zipfile|
		zipfile.each do |file|
			if folder == nil
				destination = "./"
			else
				destination = folder
			end

			unzip_path=File.join(destination, file.name)
			FileUtils.mkdir_p(File.dirname(unzip_path))
			zipfile.extract(file, unzip_path) unless File.exist?(unzip_path)
			#puts "Inflating file #{file}"
			end
	end
end

unzip("ThePrince.epub", "./test")

txt = Nokogiri::HTML(open("ThePrince/1232/@public@vhost@g@gutenberg@html@files@1232@1232-h@1232-h-1.htm.html")).text

puts txt

#TODO:
#Use Thor to make it a commandline app like rhc
#Use term-ansicolor for colored output
#Pagination/page numbering: http://bookclubs.barnesandnoble.com/t5/NOOK-Book-Discussion/EPUBs-and-page-numbering/m-p/692216/highlight/true#M13924
#EPUB structure explanation: http://www.hxa.name/articles/content/epub-guide_hxa7241_2007.html
#http://xkcd.com/303/
