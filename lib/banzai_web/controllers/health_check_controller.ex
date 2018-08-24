defmodule BanzaiWeb.HealthCheckController do
  @moduledoc """
  Returns a simple 200 response for AWS ELB/Target Group "health check".
  """
  use BanzaiWeb, :controller

  def check(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{}))
  end
end
