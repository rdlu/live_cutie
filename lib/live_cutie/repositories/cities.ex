defmodule LiveCutie.Repositories.Cities do
  def suggest(""), do: []

  def suggest(prefix) do
    list_cities()
    |> Enum.filter(&has_prefix(&1, prefix))
  end

  defp has_prefix(city, prefix) do
    prefix = prefix |> String.downcase()

    city
    |> String.downcase()
    |> String.starts_with?(prefix)
  end

  def list_cities do
    [
      "São Paulo - SP",
      "Rio de Janeiro - RJ",
      "Belo Horizonte - MG",
      "Brasília - DF",
      "Salvador - BA",
      "Fortaleza - CE",
      "Maceió - AL",
      "Recife - PE",
      "Curitiba - PR",
      "Porto Alegre - RS",
      "Porto Velho - RO",
      "Cuiaba - MT",
      "Belém - PA",
      "São Luís - MA",
      "Manaus - AM",
      "Belém - PA",
      "João Pessoa - PB",
      "Teresina - PI",
      "Natal - RN",
      "Goiânia - GO",
      "Rio Branco - AC",
      "Macapá - AP",
      "Manaus - AM",
      "Salvador - BA",
      "Brasília - DF",
      "Belém - PA"
    ]
  end
end
