** This file is a wrapper do file that closes the stata session after the do file completed
 * I saved this in C:\ado. If you save it somewhere else, update the Makefile accordingly.

do `1'
exit, clear STATA
