
-- Copyright (C) 2001 Bill Billowitch.

-- Some of the work to develop this test suite was done with Air Force
-- support.  The Air Force and Bill Billowitch assume no
-- responsibilities for this software.

-- This file is part of VESTs (Vhdl tESTs).

-- VESTs is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at
-- your option) any later version. 

-- VESTs is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-- for more details. 

-- You should have received a copy of the GNU General Public License
-- along with VESTs; if not, write to the Free Software Foundation,
-- Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 

-- ---------------------------------------------------------------------
--
-- $Id: tc426.vhd,v 1.2 2001-10-26 16:29:54 paw Exp $
-- $Revision: 1.2 $
--
-- ---------------------------------------------------------------------

ENTITY model IS
  PORT
    (
      F1:  OUT     integer := 3;
      F2:  INOUT    integer := 3;
      F3:  IN    integer
      );
END model;

architecture model of model is
begin
  process
  begin
    wait for 1 ns;
    assert F3= 3
      report"wrong initialization of F3 through type conversion" severity failure;
    assert F2 = 3
      report"wrong initialization of F2 through type conversion" severity failure;
    wait;
  end process;
end;


ENTITY c03s02b01x01p19n01i00426ent IS
END c03s02b01x01p19n01i00426ent;

ARCHITECTURE c03s02b01x01p19n01i00426arch OF c03s02b01x01p19n01i00426ent IS

  type       time_cons_vector is array (15 downto 0) of time;
  type       time_cons_vectorofvector is array (0 to 15) of time_cons_vector;
  constant    C1 : time_cons_vectorofvector := (others => (others => 3 ns));

  function complex_scalar(s : time_cons_vectorofvector) return integer is
  begin
    return 3;
  end complex_scalar;
  function scalar_complex(s : integer) return time_cons_vectorofvector is
  begin
    return C1;
  end scalar_complex;
  component model1
    PORT
      (    
        F1:  OUT     integer;
        F2:  INOUT    integer;
        F3:  IN    integer
        );
  end component;
  for T1 : model1 use entity work.model(model);

  signal S1 : time_cons_vectorofvector;
  signal S2 : time_cons_vectorofvector;
  signal S3 : time_cons_vectorofvector := C1;
BEGIN
  T1: model1
    port map (
      scalar_complex(F1) => S1,
      scalar_complex(F2) => complex_scalar(S2),
      F3 => complex_scalar(S3)
      );
  TESTING: PROCESS
  BEGIN
    wait for 1 ns;
    assert NOT((S1 = C1) and (S2 = C1)) 
      report "***PASSED TEST: c03s02b01x01p19n01i00426" 
      severity NOTE;
    assert ((S1 = C1) and (S2 = C1)) 
      report "***FAILED TEST: c03s02b01x01p19n01i00426 - For an interface object of mode out, buffer, inout, or linkage, if the formal part includes a type conversion function, then the parameter subtype of that function must be a constrained array subtype."
      severity ERROR;
    wait;
  END PROCESS TESTING;

END c03s02b01x01p19n01i00426arch;
