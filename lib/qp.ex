defmodule Qp do

  def encode(str) do
    str
      |> String.split("\r\n")
      |> Enum.map(&encode_line/1)
      |> Enum.join("\r\n")
  end

  defp encode_line(str) do
    {eol, line} = str
      |> String.to_char_list
      |> Enum.reverse
      |> Enum.split_while(&(&1==?\t or &1==?\s))

    Enum.concat(Enum.map(eol, &encode_char/1), Enum.map(line, &encode_char/1))
      |> Enum.reverse
      |> Kernel.to_string
      |> chunk_line
  end

  defp encode_char(c) do
    case c do
      c when c == ?\t or (c < 127 and c > 31 and c !== ?=) -> c
      c -> for(<<a,b<-Base.encode16(<<c::utf8>>)>>, into: "", do: <<?=,a,b>>)
    end
  end

  defp chunk_line(<<vline::size(73)-binary,?=,rest::binary>>), do: (vline<>"=\r\n"<>chunk_line("="<>rest))
  defp chunk_line(<<vline::size(74)-binary,?=,rest::binary>>), do: (vline<>"=\r\n"<>chunk_line("="<>rest))
  defp chunk_line(<<vline::size(75)-binary,rest::binary>>), do: (vline<>"=\r\n"<>chunk_line(rest))
  defp chunk_line(other), do: other

  def decode(str), do: str |> String.rstrip |> String.rstrip(?=) |> decode([])
  def decode("=\r\n" <> rest, acc), do: decode(rest, acc)
  def decode(<<?=,x1,x2>> <> rest, acc), do: decode(rest, [<<x1, x2>> |> String.upcase |> Base.decode16! | acc])
  def decode(<<c, rest::binary>>, acc), do: decode(rest, [c | acc])
  def decode("", acc), do: acc |> Enum.reverse |> IO.iodata_to_binary

end

