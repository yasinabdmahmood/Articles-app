# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
Article.destroy_all

# Create realistic articles
Article.create!([
  {
    title: 'The Rise of Remote Work: How the Workplace is Evolving',
    content: <<~TEXT
      Over the past decade, remote work has transformed from a niche perk into a mainstream practice. With advancements in technology and shifting workplace expectations, more companies are embracing flexible work environments. 

      Remote work allows employees to maintain better work-life balance, reduce commute stress, and increase productivity. However, it also presents challenges—like maintaining team communication and avoiding burnout.

      As we move forward, hybrid models combining remote and in-office work are likely to become the norm. Employers who adapt to this shift are more likely to attract top talent and foster employee satisfaction.
    TEXT
  },
  {
    title: 'Exploring the Hidden Gems of Northern Italy',
    content: <<~TEXT
      While cities like Rome and Venice steal the spotlight, Northern Italy is home to breathtaking hidden gems. From the serene lakes of Como and Garda to the charming medieval towns of Emilia-Romagna, this region offers a rich blend of culture, cuisine, and natural beauty.

      Travel enthusiasts can explore vineyards in Piedmont, hike the Dolomites, or indulge in culinary delights like truffle pasta and prosciutto di Parma. Whether you're a history buff, foodie, or nature lover, Northern Italy has something unforgettable to offer.

      Pro tip: Visit during the shoulder seasons (spring and early autumn) to avoid crowds and enjoy mild weather.
    TEXT
  },
  {
    title: 'AI and the Future of Education: A Double-Edged Sword?',
    content: <<~TEXT
      Artificial Intelligence is making its way into classrooms, offering personalized learning experiences, real-time feedback, and administrative support for teachers. Platforms powered by AI can adapt to student needs, track performance, and even automate grading.

      However, the rise of AI also raises ethical concerns—data privacy, algorithmic bias, and the potential dehumanization of education are serious considerations. Teachers are not being replaced, but their roles are evolving rapidly.

      The future of education will depend on how we balance innovation with empathy, ensuring that AI serves as a tool to empower both educators and learners.
    TEXT
  }
])

puts "Seeded #{Article.count} articles with realistic content."
