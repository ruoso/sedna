use 5.010000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Sedna',
    VERSION_FROM      => 'lib/Sedna.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Sedna.pm', # retrieve abstract from module
       AUTHOR         => 'Daniel Ruoso <ruoso@>') : ()),
    LIBS              => [''], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I -I/usr/lib/sedna/driver/c' # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw(BULK_LOAD_PORTION QUERY_EXECUTION_TIME
		 SEDNA_AUTHENTICATION_FAILED SEDNA_AUTOCOMMIT_OFF
		 SEDNA_AUTOCOMMIT_ON SEDNA_BEGIN_TRANSACTION_FAILED
		 SEDNA_BEGIN_TRANSACTION_SUCCEEDED
		 SEDNA_BOUNDARY_SPACE_PRESERVE_OFF
		 SEDNA_BOUNDARY_SPACE_PRESERVE_ON SEDNA_BULK_LOAD_FAILED
		 SEDNA_BULK_LOAD_SUCCEEDED SEDNA_CLOSE_SESSION_FAILED
		 SEDNA_COMMIT_TRANSACTION_FAILED
		 SEDNA_COMMIT_TRANSACTION_SUCCEEDED SEDNA_CONNECTION_CLOSED
		 SEDNA_CONNECTION_FAILED SEDNA_CONNECTION_OK
		 SEDNA_DATA_CHUNK_LOADED SEDNA_ERROR
		 SEDNA_GET_ATTRIBUTE_SUCCEEDED SEDNA_NEXT_ITEM_FAILED
		 SEDNA_NEXT_ITEM_SUCCEEDED SEDNA_NO_ITEM SEDNA_NO_TRANSACTION
		 SEDNA_OPEN_SESSION_FAILED SEDNA_OPERATION_SUCCEEDED
		 SEDNA_QUERY_FAILED SEDNA_QUERY_SUCCEEDED
		 SEDNA_RESET_ATTRIBUTES_SUCCEEDED SEDNA_RESULT_END
		 SEDNA_ROLLBACK_TRANSACTION_FAILED
		 SEDNA_ROLLBACK_TRANSACTION_SUCCEEDED SEDNA_SESSION_CLOSED
		 SEDNA_SESSION_OPEN SEDNA_SET_ATTRIBUTE_SUCCEEDED
		 SEDNA_TRANSACTION_ACTIVE SEDNA_UPDATE_FAILED
		 SEDNA_UPDATE_SUCCEEDED));
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'Sedna',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
