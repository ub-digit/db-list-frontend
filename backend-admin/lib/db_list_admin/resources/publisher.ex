
defmodule DbListAdmin.Resource.Publisher do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo
  import Ecto.Query
  alias Ecto.Multi



  def publishers_base do
    from publishers in Model.Publisher,
    left_join: db_publishers in Model.DatabasePublisher,
    on: publishers.id == db_publishers.publisher_id,
    preload: [database_publishers: db_publishers]
  end

  def get_publishers() do
    (from t in publishers_base())
    |> Repo.all()
    |> Enum.map(fn item -> Model.Publisher.remap(item) end)
  end

  def show(%{"id" => id}) do
    Repo.get!(Model.Publisher, id)
    #|> Repo.preload([:database_publishers])
    |> Model.Publisher.remap()
  end

  def create_or_update(data) do
  Multi.new()
    |> Multi.run(:publisher, fn repo, _ ->
      Model.Publisher.changeset(Model.Publisher.find(data["id"]), data)
      |> repo.insert_or_update()
      |> case do
        {:ok, res} -> {:ok, Model.Publisher.remap((res))}
        {:error, reason} -> {:error, Model.Publisher.remap_error(reason.errors)}
      end
    end)
    |> Repo.transaction()
    |> return_insert_or_update()
  end

  def return_insert_or_update({:ok, res}) do
    res
  end

  def return_insert_or_update({:error, _, reason, _}) do
    reason
  end


  # def delete(%{"id" => id}) do
  #   publisher = Repo.get(Model.Publisher, id)
  #   case publisher do
  #     nil -> %{error: %{publisher: %{error_code: "does_not_exist", id: id}}}
  #     _   -> case Repo.delete publisher do
  #             {:ok, struct}       -> Model.Publisher.remap(struct)
  #             {:error, changeset} -> {:error, changeset}
  #     end
  #   end
  # end

  def delete(data) do
    Multi.new()
    |> Multi.run(:publisher, fn repo, _ ->
      Model.Publisher.changeset(Model.Publisher.find(data["id"]), data)
      |> repo.delete()
      |> case do
        {:ok, res} -> {:ok, res}
        {:error, reason} -> {:error, Model.Publisher.remap_error(reason.errors)}
      end
    end)
    |> Repo.transaction()
    |> return_deleted()
  end

  def return_deleted({:ok, _}) do
    %{status: "deleted"}
  end

  def return_deleted({:error, _, err, _}) do
    err
  end
end
