photo_list = <<-EOF
photo.jpg, Krakow, 2013-09-05 14:08:15
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
g.jpg, Krakow, 2016-02-29 22:13:11
EOF

renamed_photo_list = <<-EOF
Krakow02.jpg
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
Krakow10.jpg
EOF

def how_many_photos_in_city(city, photos_arr)
  cities_of_photos = photos_arr.map { |photo| photo.split(", ")[1] }
  cities_of_photos.tally[city]
end

def extract_city_from_record(record)
  record.split(", ")[1]
end

def extract_extension_from_record(record)
  record.split(", ")[0].split(".")[1]
end

def get_record_order(record, photo_arr)
  city = extract_city_from_record(record)
  city_list = []
  photo_arr.each do |photo|
    if photo.include?(city)
      city_list << photo
    end
  end

  record_datetime = record.split(", ")[2]
  related_city_datetime_list = city_list.map { |photo| photo.split(", ")[2] }

  related_city_datetime_list.sort.find_index(record_datetime) + 1
end

def rename_photos(photo_list)
  photos_arr = photo_list.split("\n")
  new_list = photos_arr.map do |record|
    city = extract_city_from_record(record)
    number_of_photos = how_many_photos_in_city(city, photos_arr)
    extension = extract_extension_from_record(record)
    "#{city}#{"%0#{number_of_photos.digits.length}d" % get_record_order(record, photos_arr)}.#{extension}"
  end
  new_list.join("\n") + "\n"
end

if renamed_photo_list == rename_photos(photo_list)
  puts "Expected result succeeded"
else
  puts "Expected result failed"
end
