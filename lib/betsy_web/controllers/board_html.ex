defmodule BetsyWeb.BoardHTML do
  use BetsyWeb, :html

  embed_templates "board_html/*"

  @doc """
  Renders a board form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def board_form(assigns)
end
