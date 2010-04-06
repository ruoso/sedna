use 5.010000;
use ExtUtils::MakeMaker;
use ExtUtils::Constant;

WriteMakefile
  ( NAME              => 'Sedna',
    VERSION_FROM      => 'lib/Sedna.pm',
    PREREQ_PM         => {},
    ABSTRACT_FROM     => 'lib/Sedna.pm',
    AUTHOR            => 'Daniel Ruoso <daniel@ruoso.com>',
    LIBS              => [],
    DEFINE            => '',
    INC               => '-I. -Ilibsedna/driver/c',
    OBJECT            =>
    join(' ', 'Sedna.o', map { 'libsedna/driver/c/'.$_ }
      qw( libsedna.mt.o usocket.mt.o uhdd.mt.o
          sp.mt.o uutils.mt.o usecurity.mt.o
          d_printf.mt.o error_codes.mt.o u.mt.o )),
);

my @names =
  qw( BULK_LOAD_PORTION
      QUERY_EXECUTION_TIME
      SEDNA_AUTHENTICATION_FAILED
      SEDNA_AUTOCOMMIT_OFF
      SEDNA_AUTOCOMMIT_ON
      SEDNA_BEGIN_TRANSACTION_FAILED
      SEDNA_BEGIN_TRANSACTION_SUCCEEDED
      SEDNA_BOUNDARY_SPACE_PRESERVE_OFF
      SEDNA_BOUNDARY_SPACE_PRESERVE_ON
      SEDNA_BULK_LOAD_FAILED
      SEDNA_BULK_LOAD_SUCCEEDED
      SEDNA_CLOSE_SESSION_FAILED
      SEDNA_COMMIT_TRANSACTION_FAILED
      SEDNA_COMMIT_TRANSACTION_SUCCEEDED
      SEDNA_CONNECTION_CLOSED
      SEDNA_CONNECTION_FAILED
      SEDNA_CONNECTION_OK
      SEDNA_DATA_CHUNK_LOADED
      SEDNA_DEBUG_ON
      SEDNA_DEBUG_OFF
      SEDNA_ERROR
      SEDNA_GET_ATTRIBUTE_SUCCEEDED
      SEDNA_LOG_FULL
      SEDNA_LOG_LESS
      SEDNA_NEXT_ITEM_FAILED
      SEDNA_NEXT_ITEM_SUCCEEDED
      SEDNA_NO_ITEM
      SEDNA_NO_TRANSACTION
      SEDNA_OPEN_SESSION_FAILED
      SEDNA_OPERATION_SUCCEEDED
      SEDNA_QUERY_FAILED
      SEDNA_QUERY_SUCCEEDED
      SEDNA_READONLY_TRANSACTION
      SEDNA_RESET_ATTRIBUTES_SUCCEEDED
      SEDNA_RESULT_END
      SEDNA_ROLLBACK_TRANSACTION_FAILED
      SEDNA_ROLLBACK_TRANSACTION_SUCCEEDED
      SEDNA_SESSION_CLOSED
      SEDNA_SESSION_OPEN
      SEDNA_SET_ATTRIBUTE_SUCCEEDED
      SEDNA_TRANSACTION_ACTIVE
      SEDNA_UPDATE_FAILED
      SEDNA_UPDATE_SUCCEEDED
      SEDNA_UPDATE_TRANSACTION
   );

ExtUtils::Constant::WriteConstants
  ( NAME         => 'Sedna',
    NAMES        => \@names,
    DEFAULT_TYPE => 'IV',
    C_FILE       => 'const-c.inc',
    XS_FILE      => 'const-xs.inc',
  );

sub MY::postamble {
    return <<MAKE;
libsedna/driver/c/libsedna.mt.o:
	make -C libsedna
MAKE
}

sub MY::realclean_subdirs {
    return <<MAKE;
realclean_subdirs:
	make -C libsedna clean
MAKE
}
