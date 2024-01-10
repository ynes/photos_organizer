# Photos Organizer

This is a simple application to reorganize and rename photos. The Organizer 'run' method receives a string
of original photo names and returns a string with new names in the same input order according
to the city and the time they were taken.
The approach is to collect and group all photos from the same city, then sort them according to the
time they were taken, and then build the string output keeping the same order of the input.

Examples of inputs and outputs can be found in the [test/test_organizer.rb](https://github.com/ynes/photos_organizer/blob/main/test/test_organizer.rb) file.

## Technologies and Dependencies

- Ruby (3.2.2)

## How to run the test suite

```bash
cd photos_organizer
```

```bash
ruby test/test_organizer.rb
```

```bash
ruby test/test_photo_data.rb
```
