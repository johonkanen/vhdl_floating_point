library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

package float_multiplier_pkg is

    subtype t_mantissa is unsigned(22 downto 0);
    subtype t_exponent is signed(7 downto 0);

    type float_record is record
        sign : signed(0 downto 0);
        exponent : t_exponent;
        mantissa : t_mantissa;
    end record;

------------------------------------------------------------------------
    function float ( real_number : real)
        return float_record;
------------------------------------------------------------------------
    function get_mantissa ( number : real)
        return unsigned;
------------------------------------------------------------------------
    function get_exponent ( number : real)
        return t_exponent;
------------------------------------------------------------------------
    function to_real ( float_number : float_record)
        return real;
------------------------------------------------------------------------

end package float_multiplier_pkg;

package body float_multiplier_pkg is

------------------------------------------------------------------------
    function get_mantissa
    (
        number : real
    )
    return unsigned
    is
    begin
        return to_unsigned(integer((number-floor(number))* 2.0**t_mantissa'length), t_mantissa'length);
    end get_mantissa;
------------------------------------------------------------------------
    function get_exponent
    (
        number : real
    )
    return t_exponent
    is
        variable result : real := 0.0;
    begin
        result := floor(log2((abs(number))));
        
        return to_signed(integer(result),t_exponent'length);
    end get_exponent;
------------------------------------------------------------------------
    function get_sign
    (
        number : real
    )
    return signed
    is
        variable result : signed(0 downto 0);
    begin

        if number > 0.0 then
            result := "0";
        else
            result := "1";
        end if;

        return result;
        
    end get_sign;
------------------------------------------------------------------------
    function get_data
    (
        int_number : integer;
        real_number : real
    )
    return signed 
    is
        variable returned_signed : signed(7 downto 0);
    begin
        if real_number >= 0.0 then 
            returned_signed := to_signed(int_number, t_exponent'length);
        else
            returned_signed := -to_signed(int_number, t_exponent'length);
        end if;

        return returned_signed;

    end get_data;
------------------------------------------------------------------------
    function float
    (
        real_number : real
    )
    return float_record
    is
        variable returned_float : float_record := ("0", (others => '0'), (others => '0'));
        constant exp_width : integer := returned_float.exponent'high + 1;

    begin

        -- returned_float.sign     := get_exponent(real_number);
        returned_float.exponent := get_exponent(real_number);
        returned_float.mantissa := get_mantissa(real_number);

        return returned_float;
        
    end float;
------------------------------------------------------------------------
    function to_real
    (
        float_number : float_record
    )
    return real
    is
        variable result : real := 1.0;
    begin

        result := (2.0**real(to_integer(float_number.exponent))) * real(to_integer(float_number.mantissa))/2.0**(t_mantissa'length-1);
        return result;
        
    end to_real;
------------------------------------------------------------------------
end package body float_multiplier_pkg;
