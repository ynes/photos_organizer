require 'test/unit'
require_relative '../organizer'

class TestOrganizer < Test::Unit::TestCase
    def setup
        @input = "photo.jpg, Krakow, 2013-09-05 14:08:15
                Mike.png, London, 2015-06-20 15:13:22
                myFriends.png, Krakow, 2013-09-05 14:07:13
                Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
                pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
                BOB.jpg, London, 2015-08-05 00:02:03
                notredame.png, Florianopolis, 2015-09-01 12:00:00
                me.jpg, Krakow, 2013-09-06 15:40:22
                a.png, Krakow, 2016-02-13 13:33:50
                b.jpg, Krakow, 2016-01-02 15:12:22
                c.jpg, Krakow, 2016-01-02 14:34:30
                d.jpg, Krakow, 2016-01-02 15:15:01
                e.png, Krakow, 2016-01-02 09:49:09
                f.png, Krakow, 2016-01-02 10:55:32
                g.jpg, Krakow, 2016-02-29 22:13:11"
                .gsub(/\s*\n\s*/, "\n") # removing spaces around end line
        @output = "Krakow02.jpg
                London1.png
                Krakow01.png
                Florianopolis2.jpg
                Florianopolis1.jpg
                London2.jpg
                Florianopolis3.png
                Krakow03.jpg
                Krakow09.png
                Krakow07.jpg
                Krakow06.jpg
                Krakow08.jpg
                Krakow04.png
                Krakow05.png
                Krakow10.jpg"
                .gsub(/\s*\n\s*/, "\n") # removing spaces around end line
    end

    def test_output
        assert_equal Organizer.run(@input), @output
    end

    def test_size_output
        assert_equal Organizer.run(@input).split(/\n/).size, 15
    end

    def test_output_type
        assert_equal Organizer.run(@input).class.name, 'String'
    end

    def test_empty_input
        assert_equal Organizer.run(""), ""
    end

    def test_spaces_around_end_line
        assert_equal Organizer.run("c.jpg, Krakow, 2016-01-02 14:34:30 \n
                                   d.jpg, Krakow, 2016-01-02 15:15:01"), "Krakow1.jpg\nKrakow2.jpg"
    end

    def test_single_input
        assert_equal Organizer.run("notredame.png, Florianopolis, 2015-09-01 12:00:00"), "Florianopolis1.png"
    end

    def test_photos_sort_and_position
        assert_equal Organizer.run("d.jpg, Krakow, 2016-01-02 15:15:01\n" \
                                    "e.png, Krakow, 2016-01-02 09:49:09"), "Krakow2.jpg\nKrakow1.png"
    end

    def test_failed_to_parse_errors
        assert_raise(OrganizerError.new("Failing parsing date, city and ext from photo.jpg, Krakow, 2013-09-05: " \
                                        "invalid date or strptime format - `2013-09-05' `%Y-%m-%d %H:%M:%S'")) { 
                                             Organizer.run("photo.jpg, Krakow, 2013-09-05\nlala") }

    end
end