--  Ghdlsynth as a library.
--  Copyright (C) 2017 Tristan Gingold
--
--  This file is part of GHDL.
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston,
--  MA 02110-1301, USA.

with Grt.Types; use Grt.Types;
with Netlists; use Netlists;

package Libghdlsynth is
   type C_String_Array is array (Natural) of Ghdl_C_String;
   type C_String_Array_Acc is access C_String_Array;

   function Synth (Argc : Natural; Argv : C_String_Array_Acc) return Module;
end Libghdlsynth;
