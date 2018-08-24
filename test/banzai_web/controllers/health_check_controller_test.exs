defmodule BanzaiWeb.HealthCheckControllerTest do
  use BanzaiWeb.ConnCase
  require IEx

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "content-type", "application/json")}
  end

  describe "report life" do
    test "returns 200 status", %{conn: conn} do
      conn = get conn, health_check_path(conn, :check)
      assert json_response(conn, 200)
    end
  end
end
