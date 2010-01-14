#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <libsedna.h>

#include "const-c.inc"

MODULE = Sedna		PACKAGE = Sedna		

INCLUDE: const-xs.inc
