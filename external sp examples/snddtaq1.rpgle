**free                                   
//Create Data Queue first using
// CRTDTAQ DTAQ(CMPSYS/CMPDTAQ) MAXLEN(40)
Ctl-Opt DftActGrp(*No) Option(*Srcstmt : *NodebugIO);


dcl-pr main  extpgm('SNDDTAQ1');     
  *N char(10);
  *N char(10);
  *N char(40);
end-pr;
// Procedure interface definition a.k.a input parameters
dcl-pi main;    
  dqname  char(10);
  dqlib   char(10);
  data    char(40);
end-pi;         

// Prototype for QSndDtaq API
dcl-pr QSndDtaq extpgm;
  *n char(10) const;
  *n char(10) const;
  *n packed(5)  const;
  *n char(40) const;
end-pr;

dcl-s length  packed(5);

length = %len(%trim(data));

// Call QSNDDTAQ API to write into the Data Queue.
QSndDtaq( dqname : dqlib : length : data);

*InLR = *On;
return; 