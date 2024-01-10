require 'time'
require_relative 'photo_data'

# Class to reorganize and rename photos. The run method receives a string of original photos names
# and returns a string with new names in the same input order according to the city and the time
# they were taken.
# The approach is to collect and group all photos from the same city, then sort them according to the
# time taken and then build the string output keeping the same order of the input.

class Organizer
    # Inputs:
    #   photo_names: String with original photos names with the format:
    #   <\<photoname>>.<\<extension>>, <<city_name>>, yyyy-mm-dd, hh:mm:ss"
    # Output:
    #  String with new names of photos in the same input order.

    def self.run(photo_names)
        new(photo_names).send(:run)
    end

    private 

    def initialize(photo_names)
        @photo_names = photo_names
        @original_names = []
        @cities = {} # hash to group photos by city.
        @photos_map = {} # hash to to maintain the initial names position.
    end

    def run
        begin
            parse_string
            group_photos_per_city
            sort_and_assign_name
            prepare_output
        rescue => e
            raise OrganizerError, e.message
        end
    end

   # split string by end line and any white space surrounding.
    def parse_string
        @original_names = @photo_names.split(/\s*\n\s*/)
    end
    
    def group_photos_per_city
        @original_names.each do |original_name|
            begin
                file_name, city, date = original_name.split(", ")
                epoch = Time.strptime(date, '%Y-%m-%d %H:%M:%S').to_i
                ext = file_name.split('.').last
                @cities[city] = Array(@cities[city]) + [PhotoData.new(original_name, ext, epoch)]
            rescue => e
                raise OrganizerError, "Failing parsing date, city and ext from #{original_name}: #{e.message}"
            end
        end
    end

    def sort_and_assign_name
        @cities.each do |city, photos|
            begin
                sorted_photos = photos.sort_by {|p| p.epoch}
                digits = sorted_photos.size.digits.size
                sorted_photos.each_with_index do |photo, i|
                    # store the new photos names to a hash with the original name as key.
                    @photos_map[photo.original_name] = "#{city}#{(i + 1).to_s.rjust(digits, '0')}.#{photo.ext}"
                end
            rescue => e
                raise OrganizerError, "Failed sorting and assigning file name from #{city}: #{e.message}"
            end
        end
    end

    # order the new photos names in the same order or the input string
    def prepare_output
        result = ""
        @original_names.each do |original_name|
            result += "#{@photos_map[original_name]}\n"
        end
        result.chop
    end
end

class OrganizerError < StandardError; end
