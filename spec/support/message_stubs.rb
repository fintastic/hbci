def stub_dialog_init_request_message
  msg = String.new
  msg << "HNHBK:1:3+000000000463+300+0+1'"
  msg << "HNVSK:998:3+PIN:2+998+1+1::6SEF2SHzZm0BAAD4H?+JUh2?+owAQA+1:20190925:090900+2:2:13:@5@NOKEY:5:1+280:74090000:22222222:V:1:1+0'"
  msg << "HNVSD:999:1+@276@"
  msg << "HNSHK:2:4+PIN:2+942+10999990+1+1+1::6SEF2SHzZm0BAAD4H?+JUh2?+owAQA+2+1:20190925:090900+1:999:1+6:10:16+280:74090000:22222222:S:0:0'"
  msg << "HKIDN:3:2+280:74090000+22222222+6SEF2SHzZm0BAAD4H?+JUh2?+owAQA+1'"
  msg << "HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'"
  msg << "HKTAN:5:6+4+HKIDN'"
  msg << "HNSHA:6:2+10999990++33333'"
  msg << "'"
  msg << "HNHBS:7:1+1'"
  msg
end

def stub_dialog_init_response_message
  msg = String.new
  msg << "HNHBK:1:3+000000012649+300+ID9092508032960+1+ID9092508032960:1'"
  msg << "HNVSK:998:3+PIN:1+998+1+2::0+1:20190925:080329+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'"
  msg << "HNVSD:999:1+@414@"
  msg << "HITAN:2:6:4+4++noref+nochallenge'"
  msg << "HIUPD:3:6:4+11111111::280:74090000+DE11111111111111111111+22222222++EUR+xxxxx yyyyyyy++Kontokorrent++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKCDB:1+HKPSP:1+HKCSL:1+HKCDL:1+HKPAE:1+HKAUB:1+HKPPD:1+HKCSA:1+HKCDN:1+HKBMB:1+HKBBS:1+HKDMB:1+HKDBS:1+HKCSB:1+HKCUB:1+HKQTG:1+HKSPA:1+HKDSB:1+HKCCM:1+HKCUM:1+HKCCS:1+HKCDE:1+HKCSE:1+HKDSW:1+HKSAL:1+HKKAZ:1+HKAUB:1+GKVPU:1+GKVPD:1'"
  msg << "'"
  msg << "HNHBS:4:1+1'"
  msg
end

def stub_session_init_request_message
  msg = String.new
  msg << "HNHBK:1:3+000000000370+300+0+1'"
  msg << "HNVSK:998:3+PIN:1+998+1+1::0+1:20190925:090900+2:2:13:@5@NOKEY:5:1+280:74090000:22222222:V:1:1+0'"
  msg << "HNVSD:999:1+@212@"
  msg << "HNSHK:2:4+PIN:1+999+10999990+1+1+1::0+2+1:20190925:090900+1:999:1+6:10:16+280:74090000:22222222:S:0:0'"
  msg << "HKIDN:3:2+280:74090000+22222222+0+1'"
  msg << "HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'"
  msg << "HKSYN:5:3+0'"
  msg << "HNSHA:6:2+10999990++33333'"
  msg << "'"
  msg << "HNHBS:7:1+1'"
  msg
end

def stub_session_init_response_message
  msg = String.new
  msg << "HNHBK:1:3+000000012649+300+ID9092508032960+1+ID9092508032960:1'"
  msg << "HNVSK:998:3+PIN:1+998+1+2::0+1:20190925:080329+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'"
  msg << "HNVSD:999:1+@610@"
  msg << "HISYN:80:4:5+6SEF2SHzZm0BAAD4H?+JUh2?+owAQA'"
  msg << "HITANS:76:6:4+1+1+1+J:N:0:942:2:MTAN2:mobileTAN::mobile TAN:6:1:SMS:2048:J:1:N:0:2:N:J:00:0:N:1:944:2:SECUREGO:mobileTAN::SecureGo:6:1:TAN:2048:J:1:N:0:2:N:J:00:0:N:1:962:2:HHD1.4:HHD:1.4:Smart-TAN plus manuell:6:1:Challenge:2048:J:1:N:0:2:N:J:00:0:N:1:972:2:HHD1.4OPT:HHDOPT1:1.4:Smart-TAN plus optisch / USB:6:1:Challenge:2048:J:1:N:0:2:N:J:00:0:N:1:982:2:MS1.0.0:::Smart-TAN photo:6:1:Challenge:2048:J:1:N:0:2:N:J:00:0:N:1'"
  msg << "HIKAZS:10:4:4+1+1+42:J'HIKAZS:11:5:4+1+1+42:J:N'HIKAZS:12:6:4+1+1+1+42:J:N'HIKAZS:13:7:4+1+1+1+42:J:N'"
  msg << "HISALS:17:4:4+1+1'HISALS:18:7:4+1+1+1'"
  msg << "'"
  msg << "HNHBS:4:1+1'"
  msg
end

def stub_dialog_finish_request_message
  msg = String.new
  msg << "HNHBK:1:3+000000000381+300+ID9092508032960+2'"
  msg << "HNVSK:998:3+PIN:1+998+1+1::6SEF2SHzZm0BAAD4H?+JUh2?+owAQA+1:20190925:090900+2:2:13:@5@NOKEY:5:1+280:74090000:22222222:V:1:1+0'"
  msg << "HNVSD:999:1+@180@"
  msg << "HNSHK:2:4+PIN:1++10999990+1+1+1::6SEF2SHzZm0BAAD4H?+JUh2?+owAQA+2+1:20190925:090900+1:999:1+6:10:16+280:74090000:22222222:S:0:0'"
  msg << "HKEND:3:1+ID9092508032960'"
  msg << "HNSHA:4:2+10999990++33333'"
  msg << "'"
  msg << "HNHBS:5:1+2'"
  msg
end


