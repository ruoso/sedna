#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <libsedna.h>

#include "const-c.inc"

typedef struct SednaConnection SednaConnection;

MODULE = Sedna		PACKAGE = Sedna	 PREFIX = sedna_xs_

INCLUDE: const-xs.inc


SednaConnection*
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


void
sedna_xs_setConnectionAttr_AUTOCOMMIT(conn, onoff)
     SednaConnection* conn
     int onoff
     CODE:
         int ret = SEsetConnectionAttr(conn, SEDNA_ATTR_AUTOCOMMIT, &onoff, sizeof(int));
         if (ret != SEDNA_SET_ATTRIBUTE_SUCCEEDED) {
           croak("error at SEsetConnectionAttr: %s", SEgetLastErrorMsg(conn));
         }


void
sedna_xs_setConnectionAttr_SESSION_DIRECTORY(conn, dir)
     SednaConnection* conn
     char* dir
     CODE:
         int ret = SEsetConnectionAttr(conn, SEDNA_ATTR_SESSION_DIRECTORY, &dir, strlen(dir));
         if (ret != SEDNA_SET_ATTRIBUTE_SUCCEEDED) {
           croak("error at SEsetConnectionAttr: %s", SEgetLastErrorMsg(conn));
         }

void
sedna_xs_setConnectionAttr_DEBUG(conn, onoff)
     SednaConnection* conn
     int onoff
     CODE:
         int ret = SEsetConnectionAttr(conn, SEDNA_ATTR_DEBUG, &onoff, sizeof(int));
         if (ret != SEDNA_SET_ATTRIBUTE_SUCCEEDED) {
           croak("error at SEsetConnectionAttr: %s", SEgetLastErrorMsg(conn));
         }

void
sedna_xs_setConnectionAttr_CONCURRENCY_TYPE(conn, type)
     SednaConnection* conn
     int type
     CODE:
         int ret = SEsetConnectionAttr(conn, SEDNA_ATTR_CONCURRENCY_TYPE, &type, sizeof(int));
         if (ret != SEDNA_SET_ATTRIBUTE_SUCCEEDED) {
           croak("error at SEsetConnectionAttr: %s", SEgetLastErrorMsg(conn));
         }

void
sedna_xs_setConnectionAttr_QUERY_EXEC_TIMEOUT(conn, timeout)
     SednaConnection* conn
     int timeout
     CODE:
         int ret = SEsetConnectionAttr(conn, SEDNA_ATTR_QUERY_EXEC_TIMEOUT, &timeout, sizeof(int));
         if (ret != SEDNA_SET_ATTRIBUTE_SUCCEEDED) {
           croak("error at SEsetConnectionAttr: %s", SEgetLastErrorMsg(conn));
         }

void
sedna_xs_setConnectionAttr_MAX_RESULT_SIZE(conn, size)
     SednaConnection* conn
     int size
     CODE:
         int ret = SEsetConnectionAttr(conn, SEDNA_ATTR_MAX_RESULT_SIZE, &size, sizeof(int));
         if (ret != SEDNA_SET_ATTRIBUTE_SUCCEEDED) {
           croak("error at SEsetConnectionAttr: %s", SEgetLastErrorMsg(conn));
         }


void
sedna_xs_setConnectionAttr_LOG_AMMOUNT(conn, ammount)
     SednaConnection* conn
     int ammount
     CODE:
         int ret = SEsetConnectionAttr(conn, SEDNA_ATTR_MAX_RESULT_SIZE, &ammount, sizeof(int));
         if (ret != SEDNA_SET_ATTRIBUTE_SUCCEEDED) {
           croak("error at SEsetConnectionAttr: %s", SEgetLastErrorMsg(conn));
         }

