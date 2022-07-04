defmodule LiveCutie.Repositories.Places do
  def search_by_zip(zip) do
    :timer.sleep(2000)

    list_stores()
    |> Enum.filter(&String.starts_with?(&1.zip, zip))
  end

  def search_by_city(city) do
    list_stores()
    |> Enum.filter(&(&1.city == city))
  end

  def list_stores do
    [
      %{
        name: "Loja 1",
        street: "Rua 1",
        phone_number: "11 1111-1111",
        city: "São Paulo",
        zip: "01234-567",
        open: true,
        hours: "10:00 - 18:00"
      },
      %{
        name: "Loja 2",
        street: "Rua 2",
        phone_number: "11 2222-2222",
        city: "São Paulo",
        zip: "01234-567",
        open: false,
        hours: "10:00 - 18:00"
      },
      %{
        name: "Loja 3",
        street: "Rua 3",
        phone_number: "21 3333-3333",
        city: "Rio de Janeiro",
        zip: "20001-001",
        open: true,
        hours: "10:00 - 18:00"
      },
      %{
        name: "Loja 4",
        street: "Rua 4",
        phone_number: "51 4444-4444",
        city: "Porto Alegre",
        zip: "90001-567",
        open: true,
        hours: "10:00 - 18:00"
      },
      %{
        name: "Loja 5",
        street: "Rua 5",
        phone_number: "41 5555-5555",
        city: "Curitiba",
        zip: "80200-050",
        open: false,
        hours: "10:00 - 18:00"
      }
    ]
  end
end
