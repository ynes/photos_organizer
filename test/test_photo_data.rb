require 'test/unit'
require_relative '../photo_data'

class TestPhotoData < Test::Unit::TestCase

    def test_initialize
        assert_nothing_raised(Exception) { PhotoData.new('c.jpg, Krakow, 2016-01-02 14:34:30', 'jpg', '12343') }
        assert_raise(ArgumentError, "wrong number of arguments (given 2, expected 3") { PhotoData.new('jpg', '12343') }

    end

    def test_access_methods
        photo_data = PhotoData.new('c.jpg, Krakow, 2016-01-02 14:34:30', 'jpg', '12343')
        assert_equal "c.jpg, Krakow, 2016-01-02 14:34:30", photo_data.original_name
        assert_equal "jpg", photo_data.ext
        assert_equal "12343", photo_data.epoch
    end
end