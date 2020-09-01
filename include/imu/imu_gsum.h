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

#ifndef IMU_GSUM_H_
#define IMU_GSUM_H_

#include "cpp_guard.h"
#include "imu.h"
#include "loggerConfig.h"

CPP_GUARD_BEGIN

//can handle a track up to 10km
#define GSUM_MAX_SEGMENTS		1000
#define GSUM_MAX_SEGMENT_LEN		(10.0f/GSUM_MAX_SEGMENTS) // 10km - calculations are in km.
#define GSUM_MAX_MINVAL			(0.000001f)

float get_imu_gsum(void);
float get_imu_gsum_max(void);
float get_imu_gsum_pct(void);
int get_segment_by_distance(void);
void gsum_reset_maxes(void);

CPP_GUARD_END

#endif /* IMU_GSUM_H_ */
