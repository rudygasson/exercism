defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    {an, ad} = reduce a
    {bn, bd} = reduce b
    reduce({an * bd + bn * ad, ad * bd})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    {bn, bd} = b
    add(a, {-bn, bd})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(_, {0, _}), do: {0, 1}
  def multiply(a, {1, 1}), do: a
  def multiply(a, b) do
    {an, ad} = reduce a
    {bn, bd} = reduce b
    reduce({an * bn, ad * bd})
  end


  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(_, {0, _}), do: {:error, "Division by Zero"}
  def divide_by({0, _}, _), do: {0, 1}
  def divide_by(num, den) do
    {dn, dd} = den
    multiply(num, {dd, dn})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    {a1, a2} = a |> reduce
    {Kernel.abs(a1), Kernel.abs(a2)}
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) do
    {an, ad} = reduce a
    case {a, n} do
      {{0, _}, _} -> {0, 1}
      {_, 0} -> {1, 1}
      {a, 1} -> a
      {_, n} when n > 0 -> {an ** n, ad ** n} |> reduce
      {_, n} when n < 0 -> {ad ** -n, an ** -n} |> reduce
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {nn, nd} = n |> reduce
    x ** (nn/nd)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({0, _}), do: {0, 1}

  def reduce({a1, a2}) when a2 < 0 do
    {-a1, -a2} |> reduce
  end

  def reduce({a1, a2}) do
    rd = &({div(a1, &1), div(a2, &1)})
    Integer.gcd(a1, a2) |> rd.()
  end
end
