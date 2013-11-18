/*
 * loggerTaskEx.h
 *
 *  Created on: Mar 3, 2012
 *      Author: brent
 */

#ifndef LOGGERTASKEX_H_
#define LOGGERTASKEX_H_


void configChanged();
int isLogging();
void startLogging();
void stopLogging();

void createLoggerTaskEx();
void loggerTaskEx(void *params);

#endif /* LOGGERTASKEX_H_ */
