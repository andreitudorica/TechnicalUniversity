library ieee;
use ieee.std_logic_1164.all;
use work.generic_functions.all;
use work.twos_complement_types.all;

package generic_conversions is

  function to_integer (a: std_ulogic_vector) return integer;
  function to_integer (a: std_logic_vector) return integer;
  function to_integer (a: twos_complement) return integer;

  function to_std_ulogic_vector (a: integer) return std_ulogic_vector;
  function to_std_ulogic_vector (a: twos_complement) return std_ulogic_vector;
  function to_std_ulogic_vector (a: integer; width: integer) return std_ulogic_vector;

  function to_std_logic_vector (a: integer) return std_logic_vector;

  function to_twos_complement (a: integer) return twos_complement;
  function to_twos_complement (a: std_ulogic_vector) return twos_complement;

end generic_conversions;


package body generic_conversions is

  function to_integer (a: std_ulogic_vector) return integer is
    variable y: integer := 0;
  begin

    y := 0;
    if (a'length < 32) then
      for i in a'length-1 downto 0 loop
        y := y * 2;
        if (a(i) = '1') or (a(i) = 'H') then
          y := y + 1;
        elsif (a(i) = 'U') or (a(i) = 'X') or (a(i) = 'Z') or
              (a(i) = 'W') or (a(i) = '-') then
          y := y + 0;
        end if;
      end loop;
    else
      assert false
        report "Error 0002." &
               "Library = vfp." &
               "Package Body = generic_conversions." &
               "Function = to_integer." &
               "The std_ulogic_vector input to this function MUST be less than 32 bits."
          severity error;
    end if;

    return y;

  end to_integer;

  function to_integer (a: std_logic_vector) return integer is
    variable y: integer := 0;
  begin

    y := 0;
    if (a'length < 32) then
      for i in a'length-1 downto 0 loop
        y := y * 2;
        if (a(i) = '1') or (a(i) = 'H') then
          y := y + 1;
        elsif (a(i) = 'U') or (a(i) = 'X') or (a(i) = 'Z') or
              (a(i) = 'W') or (a(i) = '-') then
          y := y + 0;
        end if;
      end loop;
    else
      assert false
        report "Error 0002." &
               "Library = vfp." &
               "Package Body = generic_conversions." &
               "Function = to_integer." &
               "The std_logic_vector input to this function MUST be less than 32 bits."
          severity error;
    end if;

    return y;

  end to_integer;

  function to_integer (a: twos_complement) return integer is
    variable y: integer := 0;
  begin

    if (a(a'length-1) = '1') or (a(a'length-1) = 'H') then
      y := -1;
    elsif (a(a'length-1) = 'U') or (a(a'length-1) = 'X') or (a(a'length-1) = 'Z') or
          (a(a'length-1) = 'W') or (a(a'length-1) = '-') then
      y := 0;
    else
      y := 0;
    end if;

    for i in a'length-2 downto 0 loop
      y := y * 2;
      if (a(i) = '1') or (a(i) = 'H') then
        y := y + 1;
      elsif (a(i) = 'U') or (a(i) = 'X') or (a(i) = 'Z') or
            (a(i) = 'W') or (a(i) = '-') then
        y := y + 0;
      end if;
    end loop;

    return y;

  end to_integer;


  function to_std_ulogic_vector (a: integer) return std_ulogic_vector is
    constant y_length: integer := integer_wordlength (a);
    constant a_threshold: integer := next_greater_binary_power_minus_1 (a);
    variable y_ref: integer;
    variable y: integer;
    variable y_std_ulogic_vector: std_ulogic_vector(y_length-1 downto 0);
  begin

    y := a;
    if (a >= 0) then
      y_ref := (a_threshold / 2) + 1;
      y_std_ulogic_vector(y_length-1) := '0';
      for i in y_length-2 downto 0 loop
        if (y < y_ref) then
          y_std_ulogic_vector(i) := '0';
        else
          y := y - y_ref;
          y_std_ulogic_vector(i) := '1';
        end if;
        y_ref := y_ref / 2;
      end loop;
    else
      y_ref := -(a_threshold / 2) - 1;
      y_std_ulogic_vector(y_length-1) := '1';
      for i in y_length-2 downto 0 loop
        if (y >= y_ref) then
          y_std_ulogic_vector(i) := '1';
        else
          y := y - y_ref;
          y_std_ulogic_vector(i) := '0';
        end if;
        y_ref := y_ref / 2;
      end loop;
    end if;

    return y_std_ulogic_vector;

  end to_std_ulogic_vector;


  function to_std_logic_vector (a: integer) return std_logic_vector is
    constant y_length: integer := integer_wordlength (a);
    constant a_threshold: integer := next_greater_binary_power_minus_1 (a);
    variable y_ref: integer;
    variable y: integer;
    variable y_std_logic_vector: std_logic_vector(y_length-1 downto 0);
  begin

    y := a;
    if (a >= 0) then
      y_ref := (a_threshold / 2) + 1;
      y_std_logic_vector(y_length-1) := '0';
      for i in y_length-2 downto 0 loop
        if (y < y_ref) then
          y_std_logic_vector(i) := '0';
        else
          y := y - y_ref;
          y_std_logic_vector(i) := '1';
        end if;
        y_ref := y_ref / 2;
      end loop;
    else
      y_ref := -(a_threshold / 2) - 1;
      y_std_logic_vector(y_length-1) := '1';
      for i in y_length-2 downto 0 loop
        if (y >= y_ref) then
          y_std_logic_vector(i) := '1';
        else
          y := y - y_ref;
          y_std_logic_vector(i) := '0';
        end if;
        y_ref := y_ref / 2;
      end loop;
    end if;

    return y_std_logic_vector;

  end to_std_logic_vector;


  function to_std_ulogic_vector (a: integer; width: integer) return std_ulogic_vector is
    constant y_length: integer := width;
    constant a_threshold: integer := 2 ** (width-2);
    variable y_ref: integer;
    variable y: integer;
    variable y_std_ulogic_vector: std_ulogic_vector(y_length-1 downto 0);
  begin

    y := a;
    if (a >= 0) then
      y_ref := a_threshold;
      y_std_ulogic_vector(y_length-1) := '0';
      for i in y_length-2 downto 0 loop
        if (y < y_ref) then
          y_std_ulogic_vector(i) := '0';
        else
          y := y - y_ref;
          y_std_ulogic_vector(i) := '1';
        end if;
        y_ref := y_ref / 2;
      end loop;
    else
      y_ref := -a_threshold;
      y_std_ulogic_vector(y_length-1) := '1';
      for i in y_length-2 downto 0 loop
        if (y >= y_ref) then
          y_std_ulogic_vector(i) := '1';
        else
          y := y - y_ref;
          y_std_ulogic_vector(i) := '0';
        end if;
        y_ref := y_ref / 2;
      end loop;
    end if;

    return y_std_ulogic_vector;

  end to_std_ulogic_vector;


  function to_std_ulogic_vector (a: twos_complement) return std_ulogic_vector is
    variable y: std_ulogic_vector(a'length-1 downto 0);
  begin

    for i in a'length-1 downto 0 loop
      y(i) := a(i);
    end loop;

    return y;

  end to_std_ulogic_vector;


  function to_twos_complement (a: integer) return twos_complement is
    constant y_length: integer := integer_wordlength (a);
    constant a_threshold: integer := next_greater_binary_power_minus_1 (a);
    variable y_ref: integer;
    variable y: integer;
    variable y_2sC: twos_complement(y_length-1 downto 0);
  begin

    y := a;
    if (a >= 0) then
      y_ref := (a_threshold / 2) + 1;
      y_2sC(y_length-1) := '0';
      for i in y_length-2 downto 0 loop
        if (y < y_ref) then
          y_2sC(i) := '0';
        else
          y := y - y_ref;
          y_2sC(i) := '1';
        end if;
        y_ref := y_ref / 2;
      end loop;
    else
      y_ref := -(a_threshold / 2) - 1;
      y_2sC(y_length-1) := '1';
      for i in y_length-2 downto 0 loop
        if (y >= y_ref) then
          y_2sC(i) := '1';
        else
          y := y - y_ref;
          y_2sC(i) := '0';
        end if;
        y_ref := y_ref / 2;
      end loop;
    end if;

    return y_2sC;

  end to_twos_complement;


  function to_twos_complement (a: std_ulogic_vector) return twos_complement is
    variable y: twos_complement(a'length-1 downto 0);
  begin

    for i in a'length-1 downto 0 loop
      y(i) := a(i);
    end loop;

    return y;

  end to_twos_complement;

end generic_conversions;
