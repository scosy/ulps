# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create categories
categories = [
  'Business',
  'Philosophie',
  'Psychologie',
  'Productivité',
  'Développement personnel',
  'Spiritualité',
  'Histoire',
  'Sciences'
].each do |category|
  Category.create(name: category)
end

# Create books
books = [
  { title: 'Deep Work', subtitle: 'Retrouvez la concentration dans un monde de distractions', author: 'Cal Newport',
    year: 2016, image_url: 'https://images-na.ssl-images-amazon.com/images/I/61Vd7ljX3kL.jpg', category: 'Productivité' },
  { title: 'La lecture rapide', author: 'Tony Buzan', year: 2012,
    image_url: 'https://images-na.ssl-images-amazon.com/images/I/71fPkjH6Y0L.jpg', category: 'Productivité' },
  { title: 'La vérité sur ce qui nous motive', author: 'Daniel H. Pink', year: 2011,
    image_url: 'https://images-na.ssl-images-amazon.com/images/I/511W52nojfL.jpg', category: 'Psychologie' },
  { title: 'The war of art', subtitle: 'Break Through the Blocks and Win Your Inner Creative Battles',
    author: 'Steven Pressfield', year: 2002, image_url: 'https://images-na.ssl-images-amazon.com/images/I/61v-bmIFmhL.jpg', category: 'Développement personnel' },
  { title: 'Le plus étrange des secrets', author: 'Earl Nightingale', year: 2010,
    image_url: 'https://images-na.ssl-images-amazon.com/images/I/61OW8LY0LpL.jpg', category: 'Développement personnel' },
  { title: 'La physique de la conscience', author: 'Philippe Guillemant', year: 2019, image_url: 'https://images-na.ssl-images-amazon.com/images/I/61+uI1A+baL.jpg', category: 'Philosophie' }
].each do |book|
  b = Book.create(
    title: book[:title],
    subtitle: book[:subtitle] || nil,
    author: book[:author],
    year: book[:year],
    image_url: book[:image_url]
  )
  b.categories << Category.find_by(name: book[:category])
end

# Create episodes
episodes = [
  {
    book: Book.find_by(title: 'Deep Work'),
    duration: (49 * 60),
    notes: 'This is my notes',
    edito: "Ce livre m'a aidé à faire du travail en profondeur une priorité dans ma vie professionnelle.",
    mp3_url: 'https://audio.ausha.co/BN0R4f619n0y.mp3',
    preview_url: 'https://audio.ausha.co/yv7wRCq9mQNL.mp3',
    affiliate_link: 'https://amzn.to/3RDGk48'
  }, {
    book: Book.find_by(title: 'La lecture rapide'),
    duration: (32 * 60),
    notes: 'This is my notes',
    edito: "Ce livre m'aide chaque jour à lire plus rapidement et à comprendre plus rapidement ce que je lis.",
    mp3_url: 'https://audio.ausha.co/BN0R4f619n0y.mp3',
    preview_url: 'https://audio.ausha.co/bVw1acJmYp0E.mp3',
    affiliate_link: 'https://amzn.to/3RDGk48'
  }, {
    book: Book.find_by(title: 'La vérité sur ce qui nous motive'),
    duration: (41 * 60),
    notes: 'This is my notes',
    edito: "Ce livre m'a aidé à comprendre les piliers de ma motivation pour réussir à la maitriser.",
    mp3_url: 'https://audio.ausha.co/BN0R4f619n0y.mp3',
    preview_url: 'https://audio.ausha.co/B6Xj4sxqwPqQ.mp3',
    affiliate_link: 'https://amzn.to/3RDGk48'
  }, {
    book: Book.find_by(title: 'The war of art'),
    duration: (55 * 60),
    notes: 'This is my notes',
    edito: "Ce livre m'a fait découvrir que nous étions tous en guerre contre un ennemi intérieur puissant : la résistance.",
    mp3_url: 'https://audio.ausha.co/BN0R4f619n0y.mp3',
    preview_url: 'https://audio.ausha.co/yJ8M4u8rLWq4.mp3',
    affiliate_link: 'https://amzn.to/3RDGk48'
  }, {
    book: Book.find_by(title: 'Le plus étrange des secrets'),
    duration: (43 * 60),
    notes: 'This is my notes',
    edito: "Ce livre d'une efficacité et d'une simplicité étonnante m'a aidé à comprendre une loi essentielle de l'univers.",
    mp3_url: 'https://audio.ausha.co/BN0R4f619n0y.mp3',
    preview_url: 'https://audio.ausha.co/B1EJOFE0PV51.mp3',
    affiliate_link: 'https://amzn.to/3RDGk48'
  }, {
    book: Book.find_by(title: 'La physique de la conscience'),
    duration: (45 * 60),
    notes: 'This is my notes',
    edito: "Ce livre est l'un des plus intéressants que j'ai eu la chance de lire. On y découvre une théorie sur le sens même de la réalité.",
    mp3_url: 'https://audio.ausha.co/BN0R4f619n0y.mp3',
    preview_url: 'https://audio.ausha.co/oaR86hrZwxNL.mp3',
    affiliate_link: 'https://amzn.to/3RDGk48'
  }
].each do |episode|
  Episode.create(
    book: episode[:book],
    duration: episode[:duration],
    notes: episode[:notes],
    edito: episode[:edito],
    mp3_url: episode[:mp3_url],
    preview_url: episode[:preview_url],
    affiliate_link: episode[:affiliate_link]
  )
end

# Give price to existing episodes
Episode.all.each { |episode| episode.update(price: 490) }
