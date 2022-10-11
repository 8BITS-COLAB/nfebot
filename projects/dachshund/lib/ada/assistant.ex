defmodule ADA.Assistant do
  @config Application.compile_env!(:ada, __MODULE__)
  defp basic_auth(), do: Base.encode64("apikey:#{@config[:apikey]}")

  defp parse_body(body) do
    text =
      body
      |> Map.fetch!("output")
      |> Map.fetch!("generic")
      |> Enum.at(0)
      |> Map.fetch!("text")

    {text, Map.fetch!(body, "context")}
  end

  @spec message({:text, binary(), map()}) :: {binary(), map()}
  def message({:text, text, context}) do
    %HTTPoison.Response{body: body} =
      HTTPoison.post!(
        "#{@config[:url]}/v2/assistants/#{@config[:id]}/message?version=#{@config[:version]}",
        Poison.encode!(%{input: %{text: text}, context: context}),
        [{"Authorization", "Basic #{basic_auth()}"}, {"Content-Type", "application/json"}]
      )

    body
    |> Poison.decode!()
    |> parse_body()
  end
end
