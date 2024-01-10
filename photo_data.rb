# Class to store collected photo data
class PhotoData
    attr_reader :epoch, :ext, :original_name

    def initialize(original_name, ext, epoch)
        @original_name = original_name
        @ext = ext
        @epoch = epoch
    end
end