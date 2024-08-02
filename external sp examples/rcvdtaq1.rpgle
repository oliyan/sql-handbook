**free                                   

Ctl-Opt DftActGrp(*No) Option(*Srcstmt : *NodebugIO);

dcl-pr main  extpgm('RCVDTAQ1');     
  *N char(10);
  *N char(10);
  *N char(40);
end-pr;

// Procedure interface definition a.k.a input parameters
dcl-pi main;    
  dqname      char(10);
  dqlib       char(10);
  outputdata  char(40);
end-pi;         

// Prototype for QRcvDtaQ API
dcl-pr QRcvDtaQ extpgm;
  *n char(10)   const;
  *n char(10)   const;
  *n packed(5)  const;
  *n char(40)   const;
  *n packed(5)  const;
end-pr;

dcl-s length    packed(5);
dcl-s recvData  char(40);
dcl-c waitTime  const(5);


// Call QSNDDTAQ API to write into the Data Queue.
QRcvDtaQ( dqname : dqlib : length : recvData : waitTime);
outputdata = recvData;

*InLR = *On;
return; 