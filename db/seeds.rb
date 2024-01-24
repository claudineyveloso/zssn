# frozen_string_literal: true

User.create(
  name: FFaker::Name.name_with_prefix,
  age: %i[20 25 30 35 40 45 50].sample,
  gender: %i[Masculino Feminino].sample,
  latitude: FFaker::Geolocation.lat,
  longitude: FFaker::Geolocation.lng,
  created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
  updated_a: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)
)
