# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveCutie.Repo.insert!(%LiveCutie.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias LiveCutie.Repo
alias LiveCutie.Pets.Pet
alias LiveCutie.PokeGames.PokeGame

%Pet{
  name: "Fido",
  species: "dog",
  cuteness: "4",
  image: "images/petz/fido.jpg"
}
|> Repo.insert!()

%Pet{
  name: "Brad",
  species: "dog",
  cuteness: "5",
  image: "images/petz/brad.jpg"
}
|> Repo.insert!()

%Pet{
  name: "Fluffy",
  species: "cat",
  cuteness: "5",
  image: "images/petz/fluffy.jpg"
}
|> Repo.insert!()

%Pet{
  name: "Lily",
  species: "cat",
  cuteness: "4",
  image: "images/petz/lily.jpg"
}
|> Repo.insert!()

%Pet{
  name: "Bella",
  species: "cat",
  cuteness: "5",
  image: "images/petz/bella.jpg"
}
|> Repo.insert!()

%Pet{
  name: "Polly",
  species: "bird",
  cuteness: "4",
  image: "images/petz/polly.jpg"
}
|> Repo.insert!()

%PokeGame{
  name: "Yellow",
  description: "This is a poke game",
  platform: "Game Boy",
  generation: 1,
  box_image: "images/poke_games/yellow.jpg",
  favorite: true,
  played: :yes,
  legendary: ["Articuno", "Zapdos", "Moltres", "Mewtwo"],
  starters: ["Pikachu"],
  streaming: false
}
|> Repo.insert!()

%PokeGame{
  name: "HeartGold",
  description: "This is a poke game",
  platform: "Nintendo DS",
  generation: 4,
  box_image: "images/poke_games/heartgold.jpg",
  favorite: true,
  played: :soon,
  legendary: [
    "Latias",
    "Latios",
    "Lugia",
    "Ho-Oh",
    "Suicune",
    "Raikou",
    "Entei",
    "Articuno",
    "Zapdos",
    "Moltres",
    "Mewtwo",
    "Kyogre",
    "Groudon",
    "Rayquaza"
  ],
  starters: ["Chikorita", "Cyndaquil", "Totodile"],
  streaming: false
}
|> Repo.insert!()

%PokeGame{
  name: "SoulSilver",
  description: "This is a poke game",
  platform: "Nintendo DS",
  generation: 4,
  box_image: "images/poke_games/soulsilver.jpg",
  favorite: true,
  played: :soon,
  legendary: [
    "Latias",
    "Latios",
    "Lugia",
    "Ho-Oh",
    "Suicune",
    "Raikou",
    "Entei",
    "Articuno",
    "Zapdos",
    "Moltres",
    "Mewtwo",
    "Kyogre",
    "Groudon",
    "Rayquaza"
  ],
  starters: ["Chikorita", "Cyndaquil", "Totodile"],
  streaming: true
}
|> Repo.insert!()
