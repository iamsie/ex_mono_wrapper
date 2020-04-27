defmodule ExMonoWrapper do
  use Tesla

  alias ExMonoWrapper.DataCleaner

  plug Tesla.Middleware.BaseUrl, "https://api.monobank.ua"
  plug Tesla.Middleware.Headers
  plug Tesla.Middleware.JSON

  def get_currency_info() do
    {:ok, env} = ExMonoWrapper.get("/bank/currency")

    DataCleaner.clean_info(env.body)
  end

  def get_client_info(token) do
    {:ok, env} =
      Tesla.client([
        {Tesla.Middleware.Headers, [{"X-Token", token}]}
      ])
      |> ExMonoWrapper.get("/personal/client-info")

    DataCleaner.clean_client_info(env.body)
  end

  def post_personal_webhook(token, web_hook_url) do
    Tesla.client([
      {Tesla.Middleware.Headers, [{"X-Token", token}]}
    ])
    |> ExMonoWrapper.post("/personal/webhook", web_hook_url)
  end

  def get_personal_statement(token, account, from, to) do
    {:ok, env} =
      Tesla.client([
        {Tesla.Middleware.Headers, [{"X-Token", token}]}
      ])
      |> ExMonoWrapper.get("personal/statement/#{account}/#{from}/#{to}")

    DataCleaner.clean_info(env.body)
  end
end
