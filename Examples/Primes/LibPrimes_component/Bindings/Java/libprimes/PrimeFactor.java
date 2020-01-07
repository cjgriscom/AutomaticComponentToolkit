/*++

Copyright (C) 2019 PrimeDevelopers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.7.0-develop.

Abstract: This is an autogenerated Java file in order to allow an easy
 use of Prime Numbers Library

Interface version: 1.2.0

*/

package libprimes;

import com.sun.jna.Memory;
import com.sun.jna.Pointer;

import java.util.Arrays;
import java.util.List;

public class PrimeFactor {

	public long Prime;

	public int Multiplicity;

	public static final int SIZE = 12;

	public void readFromPointer(Pointer p, long offset) {
		Prime = p.getLong(offset + 0);
		Multiplicity = p.getInt(offset + 8);
	}

	public void writeToPointer(Pointer p, long offset) {
		p.setLong(offset + 0, Prime);
		p.setInt(offset + 8, Multiplicity);
	}

}
