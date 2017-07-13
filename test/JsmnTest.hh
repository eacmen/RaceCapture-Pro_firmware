/*
 * Race Capture Firmware
 *
 * Copyright (C) 2016 Autosport Labs
 *
 * This file is part of the Race Capture firmware suite
 *
 * This is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should
 * have received a copy of the GNU General Public License along with
 * this code. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _JSMNTEST_H_
#define _JSMNTEST_H_

#include <cppunit/extensions/HelperMacros.h>

class JsmnTest : public CppUnit::TestFixture
{
	CPPUNIT_TEST_SUITE( JsmnTest );
	CPPUNIT_TEST( decodeStringTest );
	CPPUNIT_TEST( encodeWriteStringTest );
	CPPUNIT_TEST_SUITE_END();

public:
	void decodeStringTest();
	void encodeWriteStringTest();
};

#endif /* _JSMNTEST_H_ */