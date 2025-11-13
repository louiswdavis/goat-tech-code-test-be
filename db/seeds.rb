# Clear existing data
puts "Clearing existing data..."
User.destroy_all
Campaign.destroy_all
Task.destroy_all

# Create users
puts "Creating users..."
user1 = User.create!(name: "John 'Soap' MacTavish", email: "soap@goat.com")
user2 = User.create!(name: "Pioneer", email: "pioneer@goat.com")
user3 = User.create!(name: "Claptrap", email: "claptrap@goat.com")

puts "Created #{User.count} users"

# Create campaigns
puts "Creating campaigns..."
campaign1 = Campaign.create!(
  name: "Burger Town - Mega Burger Launch",
  description: "Launching the Mega Burger at Burger Town",
  status: "active"
)

campaign2 = Campaign.create!(
  name: "FICSIT Brand Awareness",
  description: "A satisfactory brand awareness campaign for FICSIT",
  status: "active"
)

campaign3 = Campaign.create!(
  name: "Hyperion Launcher Launch",
  description: "Explosive Marketing Campaign for Hyperion Launcher",
  status: "completed"
)

puts "Created #{Campaign.count} campaigns"


puts "\nUsers:"
User.all.each { |u| puts "  - #{u.name} (#{u.email})" }
puts "\nCampaigns:"
Campaign.all.each { |c| puts "  - #{c.name} (#{c.status})" }

# Create tasks
puts "Creating tasks..."
# Tasks for Burger Town campaign
Task.create!(
  title: "Design Mega Burger Promotional Materials",
  description: "Create eye-catching posters and social media content",
  status: "in_progress",
  priority: "high",
  due_date: Date.today + 7.days,
  campaign: campaign1
)

Task.create!(
  title: "Organize Tasting Event",
  description: "Plan and execute VIP tasting event for food critics",
  status: "todo",
  priority: "medium",
  due_date: Date.today + 14.days,
  campaign: campaign1
)

Task.create!(
  title: "Launch Social Media Campaign",
  description: "Execute pre-planned social media strategy",
  status: "todo",
  priority: "high",
  due_date: Date.today + 10.days,
  campaign: campaign1
)

# Tasks for FICSIT campaign
Task.create!(
  title: "Pioneer Outreach Program",
  description: "Develop outreach materials for new pioneers",
  status: "in_progress",
  priority: "medium",
  due_date: Date.today + 20.days,
  campaign: campaign2
)

Task.create!(
  title: "Factory Tour Videos",
  description: "Create virtual factory tour content",
  status: "todo",
  priority: "low",
  due_date: Date.today + 30.days,
  campaign: campaign2
)

Task.create!(
  title: "Efficiency Campaign",
  description: "Highlight FICSIT's commitment to efficiency",
  status: "todo",
  priority: "medium",
  due_date: Date.today + 25.days,
  campaign: campaign2
)

# Tasks for Hyperion campaign
Task.create!(
  title: "Product Demo Videos",
  description: "Create explosive product demonstration videos",
  status: "done",
  priority: "high",
  due_date: Date.today - 5.days,
  campaign: campaign3
)

Task.create!(
  title: "Influencer Partnership Program",
  description: "Partner with vault hunters for product promotion",
  status: "done",
  priority: "medium",
  due_date: Date.today - 10.days,
  campaign: campaign3
)

Task.create!(
  title: "Post-Launch Analytics Report",
  description: "Compile campaign performance metrics",
  status: "in_progress",
  priority: "low",
  due_date: Date.today + 2.days,
  campaign: campaign3
)

puts "\n✅ Seed data created successfully!"

# my own checks

puts "Seeded: Campaign(s) (#{Campaign.count})"
puts "Seeded: User(s) (#{User.count})"
puts "Seeded: Task(s) (#{Task.count})"