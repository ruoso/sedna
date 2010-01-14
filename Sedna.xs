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
         struct SednaConnection* conn = malloc(sizeof(struct SednaConnection));
         int ret = SEconnect(conn, url, db_name, login, password);
         if (ret == SEDNA_SESSION_OPEN) {
            RETVAL = conn;
         } else if (ret == SEDNA_AUTHENTICATION_FAILED) {
            croak("SEDNA_AUTHENTICATION_FAILED: %s", SEgetLastErrorMsg(conn));
         } else if (ret == SEDNA_OPEN_SESSION_FAILED) {
            croak("SEDNA_OPEN_SESSION_FAILED: %s", SEgetLastErrorMsg(conn));
         } else if (ret == SEDNA_ERROR) {
            croak("SEDNA_ERROR: %s", SEgetLastErrorMsg(conn));
         } else {
            croak("unknown error at SEconnect: %s", SEgetLastErrorMsg(conn));
         }
     OUTPUT:
         RETVAL

        