# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

colors = %w[Red Blue Green Yellow Purple Orange Black White Pink Gray]

colors.each do |color|
  org_name = "#{color} Corp"
  subdomain = color.downcase + "_corp"

  organization = Organization.create(
    organization_name: org_name,
    subdomain: subdomain,
    email: "#{org_name.downcase.parameterize(separator: "-")}@#{color}.com",
    password: "password",
    password_confirmation: "password"
  )
  puts "#{organization.organization_name} Organization created"

  ActsAsTenant.with_tenant(organization) do
    domain = "#{organization.organization_name.downcase.parameterize(separator: "-")}.com"

    members = Array.new(rand(10..30)) do
      User.create(
        name: Faker::Name.name,
        email: Faker::Internet.unique.email(domain: domain),
        password: "password",
        password_confirmation: "password",
        role: 1
      )
    end
    puts "#{organization.organization_name} Members created"

    projects = Array.new(rand(1..4)) do
      organization.projects.create(
        title: Faker::App.name,
        details: Faker::Lorem.sentence,
        expected_completion_date: Faker::Date.forward(days: 90)
      )
    end
    puts "#{organization.organization_name} Projects created"

    members.each do |member|
      projects.sample(rand(1..2)).each do |project|
        ProjectMember.find_or_create_by(
          project_id: project.id,
          user_id: member.id,
        )
      end
    end
    puts "#{organization.organization_name} Projects-Members created"
  end
end
