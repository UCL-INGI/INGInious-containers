
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
-- $Id: tc886.vhd,v 1.2 2001-10-26 16:30:01 paw Exp $
-- $Revision: 1.2 $
--
-- ---------------------------------------------------------------------

package c10s01b00x00p11n01i00886pkg_a is
  constant x : integer := 1;
end c10s01b00x00p11n01i00886pkg_a;

package c10s01b00x00p11n01i00886pkg_b is
  constant x : integer := 1;
end c10s01b00x00p11n01i00886pkg_b;


entity c10s01b00x00p11n01i00886ent_a is
  generic (    passed_value    : integer := 6; 
               ignored_value    : integer := 0 );
end c10s01b00x00p11n01i00886ent_a;

architecture c10s01b00x00p11n01i00886arch_a of c10s01b00x00p11n01i00886ent_a is
begin
  TESTING:PROCESS
  BEGIN
    assert NOT( passed_value = 1)
      report "***PASSED TEST: c10s01b00x00p11n01i00886"
      severity NOTE;
    assert ( passed_value = 1)
      report "***FAILED TEST: c10s01b00x00p11n01i00886 - A block configuration test failed."
      severity ERROR;
    wait;
  END PROCESS TESTING;
end c10s01b00x00p11n01i00886arch_a;

configuration c10s01b00x00p11n01i00886cfg_a of c10s01b00x00p11n01i00886ent_a is
  for c10s01b00x00p11n01i00886arch_a
  end for;
end c10s01b00x00p11n01i00886cfg_a;

ENTITY c10s01b00x00p11n01i00886ent IS
END c10s01b00x00p11n01i00886ent;

ARCHITECTURE c10s01b00x00p11n01i00886arch OF c10s01b00x00p11n01i00886ent IS
  component ic_socket
    generic (dummy_value : integer := 2);
  end component;
BEGIN
  instance : ic_socket;

END c10s01b00x00p11n01i00886arch;

configuration c10s01b00x00p11n01i00886cfg of c10s01b00x00p11n01i00886ent is
  for c10s01b00x00p11n01i00886arch    -- block_specification
    use work.c10s01b00x00p11n01i00886pkg_a.x;    -- creates a declarative item in this region
    for instance : ic_socket use configuration work.c10s01b00x00p11n01i00886cfg_a
                               generic map ( passed_value => x, ignored_value => dummy_value );
    end for;
  end for;
end c10s01b00x00p11n01i00886cfg;
