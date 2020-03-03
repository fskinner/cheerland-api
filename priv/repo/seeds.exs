# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CheerlandApi.Repo.insert!(%CheerlandApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

CheerlandApi.Auth.create_user(%{
  email: "lucasavilez@gmail.com",
  name: "Lucas Avilez",
  password: "123456",
  gender: "Masculino",
  is_admin: false,
  allowed_group: "A",
  allow_couple_bed: true,
})

CheerlandApi.Auth.create_user(%{
  email: "felipeskinner@gmail.com",
  name: "Felipe Skinner",
  password: "123456",
  gender: "Masculino",
  is_admin: true,
  allowed_group: "B",
  allow_couple_bed: false,
})

CheerlandApi.Auth.create_user(%{
  email: "foo@bar.com",
  name: "Foo Bar",
  password: "123456",
  gender: "Feminino",
  is_admin: false,
  allowed_group: "C",
  allow_couple_bed: false,
})

CheerlandApi.Reservations.create_room(%{
  group: "A",
  label: "First Room",
  max_beds: 5,
  women_only: false
})

CheerlandApi.Reservations.create_room(%{
  group: "B",
  label: "Second Luxury Room",
  description: "A pretty room for pretty people",
  max_beds: 3,
  women_only: true
})

CheerlandApi.Reservations.create_room(%{
  group: "C",
  label: "Weird Space Room",
  description: "An amazing room for groups of people",
  max_beds: 12,
  women_only: false
})
