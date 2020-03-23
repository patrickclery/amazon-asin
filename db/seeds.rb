# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create asin:          "B002QYW8LW",
               category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
               category_url:  "https://www.amazon.ca/b/?node=4624252011",
               dimensions:    "11 x 1 x 20 cm",
               product_title: "Baby Banana Bendable Training Toothbrush (Infant)",
               rank:          "118"

Product.create asin:          "B07HCQV1BT",
               category_name: "Electronics > Televisions & Video > Televisions",
               category_url:  "https://www.amazon.ca/b/?node=2690978011",
               dimensions:    "",
               product_title: "Toshiba 49LF421C19 49-inch 1080p HD Smart LED TV - Fire TV Edition",
               rank:          "142"

Product.create asin:          "B07H4MPJ5X",
               category_name: "Video Games > Xbox One > Accessories > Controllers",
               category_url:  "https://www.amazon.ca/b/?node=6920179011",
               dimensions:    "16.5 x 13.5 x 3.8 cm ; 177 g",
               product_title: "Collective Minds Xbox One Mod Pack - Xbox One",
               rank:          "17"
