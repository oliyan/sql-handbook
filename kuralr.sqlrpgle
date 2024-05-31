**free
// -------------------------------------------------------------------------------------------------
// Program Name : KURALR
// Description  : A Simple program to retrieve Tirukkural randomly or by Kural-number.
// Parameters   : None.
// Written By   : Ravisankar Pandian
// Company.     : Programmers.IO
// Date         : 25-07-2023
// -------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------------
// Definition of program control statements.
// -------------------------------------------------------------------------------------------------
  ctl-opt dftactgrp(*no) ;

// -------------------------------------------------------------------------------------------------
// Definition of display file.
// -------------------------------------------------------------------------------------------------
  dcl-f kurald workstn Indds(indicator_ds);

// -------------------------------------------------------------------------------------------------
// Definition of procedures
// -------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------------------
// Definition of Standalone Variables
// -------------------------------------------------------------------------------------------------

  dcl-s kuralnum char(4) inz;
  dcl-s paal varchar(25) inz;
  dcl-s iyal varchar(50) inz;
  dcl-s athigaram varchar(50) inz;
  dcl-s translation varchar(500) inz;
  dcl-s explanation varchar(500) inz;

  dcl-s jobfqn char(30) inz;
  dcl-s command char(200) inz;
  dcl-s commandlength zoned(15);


// -------------------------------------------------------------------------------------------------
// Definition of Data Structures
// -------------------------------------------------------------------------------------------------
  dcl-ds indicator_ds;
    exit                      ind pos(3);
    refresh                   ind pos(5);
    errorinput                ind pos(30);
    allok                     ind pos(50);
  end-ds;

  dcl-ds Pgmds psds qualified ;
    PgmName char(10) ;          // Module or main procedure name
    StsCde zoned(5) ;           // Status code
    PrvStsCde zoned(5) ;        // Previous status
    SrcLineNbr char(8) ;        // Source line number
    Routine char(8) ;           // Name of the RPG routine
    Parms zoned(3) ;            // Number of parms passed to program
    ExceptionType char(3) ;     // Exception type
    ExceptionNbr char(4) ;      // Exception number
    Exception char(7) samepos(ExceptionType) ;
    Reserved1 char(4) ;         // Reserved
    MsgWrkArea char(30) ;       // Message work area
    PgmLib char(10) ;           // Program library
    ExceptionData char(80) ;    // Retrieved exception data
    Rnx9001Exception char(4) ;  // Id of exception that caused RNX9001
    LastFile1 char(10) ;        // Last file operation occurred on
    Unused1 char(6) ;           // Unused
    DteEntered char(8) ;        // Date entered system
    StrDteCentury zoned(2) ;    // Century of job started date
    LastFile2 char(8) ;         // Last file operation occurred on
    LastFileSts char(35) ;      // Last file used status information
    JobName char(10) ;          // Job name
    JobUser char(10) ;          // Job user
    JobNbr zoned(6) ;           // Job number
    StrDte zoned(6) ;           // Job started date
    PgmDte zoned(6) ;           // Date of program running
    PgmTime zoned(6) ;          // Time of program running
    CompileDte char(6) ;        // Date program was compiled
    CompileTime char(6) ;       // Time program was compiled
    CompilerLevel char(4) ;     // Level of compiler
    SrcFile char(10) ;          // Source file name
    SrcLib char(10) ;           // Source file library
    SrcMbr char(10) ;           // Source member name
    ProcPgm char(10) ;          // Program containing procedure
    ProcMod char(10) ;          // Module containing procedure
    SrcLineNbrBin bindec(2) ;   // Source line number as binary
    LastFileStsBin bindec(2) ;  // Source id matching positions 228-235
    User char(10) ;             // Current user
    ExtErrCode int(10) ;        // External error code
    IntoElements int(20) ;      // Elements set by XML-INTO or DATA-INTO (7.3)
    InternalJobId char(16) ;    // Internal job id (7.3 TR6)
    SysName char(8) ;           // System name (7.3 TR6)
  end-ds ;

// -------------------------------------------------------------------------------------------------
// Definition of Constants
// -------------------------------------------------------------------------------------------------
  dcl-c TRUE const('1');
  dcl-c FALSE const('0');
  dcl-c SLASH const('/');


// -------------------------------------------------------------------------------------------------
// Start of the Main logic
// -------------------------------------------------------------------------------------------------
*inlr = TRUE;

    

jobfqn = %editc(pgmds.JobNbr:'X') + SLASH + %trim(pgmds.JobUser) + SLASH + %trim(pgmds.JobName);

command = 'CHGJOB JOB(' + %trim(jobfqn) + ') CCSID(37)';

exec sql
  call qsys2.qcmdexc(:command);

Dou  exit = TRUE;
  exfmt kuralr;
  allok = FALSE;

  // If user pressed F3, then exit the program
  if exit = TRUE;
    leave;
  endif;

  // If user pressed F5, then clear the fieds and display the screen again
  if refresh = TRUE;
    refresh  = FALSE;
    exit     = FALSE;
    errmsgd  = *blanks;
    inputd   = *zeros;
    iter;
  endif;

  // Get the Kural from the public API.

  if inputd <> *zeros;
    kuralnum = %char(inputd);
  else;
    Exec sql
      SELECT  char(dec(RAND()*1330,4,0)) into :kuralnum from sysibm.sysdummy1;
  endif;

  get_kural();
EndDo;

return;


// -------------------------------------------------------------------------------------------------
// Get Kural from API
// -------------------------------------------------------------------------------------------------
dcl-proc get_kural;

  Exec sql
    call getkural(:kuralnum, :paal, :iyal, :athigaram, :translation, :explanation);

  if sqlcod = *Zeros;
    allok = TRUE;
    sect = paal;
    categ = iyal;
    subcateg = athigaram;
    kural = translation;
    expla = explanation;
    kuraldesc = 'Kural(' + %trim(kuralnum) + ')';
  else;
    errmsgd = 'ERROR';
  endif;
end-proc;

