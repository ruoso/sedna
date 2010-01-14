#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <libsedna.h>

#include "const-c.inc"

MODULE = Sedna		PACKAGE = Sedna	 PREFIX = sedna_xs_

INCLUDE: const-xs.inc

struct SednaConnection*
sedna_xs_connect(url, db_name, login, password)
     char* url
     char* db_name
     char* login
     char* password
     CODE:
         struct SednaConnection* ret = malloc(sizeof(struct SednaConnection));
         if (SEconnect(ret, url, db_name, login, password) == SEDNA_SESSION_OPEN) {
            RETVAL = ret;
         } else if (ret == SEDNA_AUTHENTICATION_FAILED) {
            croak("SEDNA_AUTHENTICATION_FAILED");
         } else if (ret == SEDNA_OPEN_SESSION_FAILED) {
            croak("SEDNA_OPEN_SESSION_FAILED");
         } else if (ret == SEDNA_ERROR) {
            croak("SEDNA_ERROR");
         } else {
            croak("unknown error at SEconnect");
         }
     OUTPUT:
         RETVAL

        