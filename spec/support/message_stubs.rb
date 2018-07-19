# frozen_string_literal: true

def enveloped_response_message(payload, credentials, dialog_id: 'LM6022214510276', message_number: 1, date: Time.now.strftime('%Y%m%d'), time: Time.now.strftime('%H%m%S'))
  payload_data = payload.join
  last_segment_number = 2 + payload.count
  reference_message_number = message_number

  msg = %W[
    HNHBK:1:3+000000000000+300+#{dialog_id}+#{message_number}+#{dialog_id}:#{reference_message_number}'
    HNVSK:998:3+PIN:1+998+1+2::0+1:#{date}:#{time}+2:2:13:@5@NOKEY:6:1+280:#{credentials.bank_code}:#{credentials.user_id}:V:1:1+0'
    HNVSD:999:1+@#{payload_data.length}@#{payload_data}'
    HNHBS:#{last_segment_number}:1+#{message_number}'
  ].join

  padded_length = msg.length.to_s.rjust(12, '0')

  msg.gsub('HNHBK:1:3+000000000000', "HNHBK:1:3+#{padded_length}")
end

def enveloped_request_message(payload, credentials, dialog_id: 'LM6022214510276', message_number: 0, date: Time.now.strftime('%Y%m%d'), time: Time.now.strftime('%H%m%S'))
  payload_data = payload.join
  last_segment_number = payload.count + 2

  msg = %W[
    HNHBK:1:3+000000000000+300+#{dialog_id}+#{message_number}'
    HNVSK:998:3+PIN:1+998+1+1::0+1:#{date}:#{time}+2:2:13:@5@NOKEY:6:1+280:#{credentials.bank_code}:#{credentials.user_id}:V:1:1+0'
    HNVSD:999:1+@#{payload_data.length}@#{payload_data}'
    HNHBS:#{last_segment_number}:1+#{message_number}'
  ].join

  padded_length = msg.length.to_s.rjust(12, '0')

  msg.gsub('HNHBK:1:3+000000000000', "HNHBK:1:3+#{padded_length}")
end

def stub_dialog_finish_request_message(credentials, dialog_id: 'LM6022214510276', rand: '10999990', message_number: 3)
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')

  payload = %W[
    HNSHK:2:4+PIN:1+942+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HKEND:3:1+#{dialog_id}'
    HNSHA:4:2+#{rand}++#{credentials.pin}'
  ]

  enveloped_request_message(payload, credentials, dialog_id: dialog_id, message_number: message_number, date: date, time: time)
end

def stub_dialog_init_request_message(credentials, rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')

  payload = %W[
    HNSHK:2:4+PIN:1+999+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HKIDN:3:2+280:#{credentials.bank_code}+#{credentials.user_id}+0+1'
    HKVVB:4:3+0+0+1+FintasticHBCI+#{Hbci::VERSION}'
    HNSHA:5:2+#{rand}++#{credentials.pin}'
  ]

  enveloped_request_message(payload, credentials, dialog_id: 0, date: date, time: time, message_number: 1)
end

def stub_dialog_init_response_message(credentials, dialog_id: 'LM6022214510276', rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')

  accounts = [
    { account_number: '11111111',    iban: 'DE11111111111111111111' },
    { account_number: '22222222',    iban: 'DE22222222222222222222' },
    { account_number: '333333333',   iban: 'DE33333333333333333333' },
    { account_number: '444444444',   iban: 'DE44444444444444444444' },
    { account_number: '5555555555',  iban: 'DE55555555555555555555' },
    { account_number: '6666666666',  iban: 'DE66666666666666666666' },
    { account_number: '7777777777',  iban: 'DE77777777777777777777' }
  ]

  owner = 'xxxxx yyyyyyy'

  msg = []
  msg << "HNHBK:1:3+000000011279+300+#{dialog_id}+1+#{dialog_id}:1'"
  msg << "HNVSK:998:3+PIN:1+998+1+2::0+1:#{date}:#{time}+2:2:13:@5@NOKEY:6:1+280:#{credentials.bank_code}:#{credentials.user_id}:V:1:1+0'"
  msg << 'HNVSD:999:1+@11088@'
  msg << "HNSHK:2:4+PIN:1+999+#{rand}+1+1+2::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'"
  msg << "HIRMG:3:2+3060::Bitte beachten Sie die enthaltenen Warnungen/Hinweise.'"
  msg << "HIRMS:4:2:4+3050::UPD nicht mehr aktuell, aktuelle Version enthalten.+3050::BPD nicht mehr aktuell, aktuelle Version enthalten.+3920::Zugelassene TAN-Verfahren f\xFCr den Benutzer:942+0901::*PIN g\xFCltig.+0020::*Dialoginitialisierung erfolgreich'"
  msg << "HIBPA:5:3:4+5+280:#{credentials.bank_code}+Heidelberger Volksbank eG+1+1+300+500'"
  msg << "HIKOM:6:4:4+280:#{credentials.bank_code}+1+3:https?://hbci11.fiducia.de/cgi-bin/hbciservlet+2:hbci01.fiducia.de'"
  msg << "HISHV:7:3:4+J+PIN:1+RDH:9+RDH:10+RDH:7'"
  msg << "HIEKAS:8:5:4+1+1+1+J:J:N:3'"
  msg << "HIKAZS:9:4:4+1+1+365:J'"
  msg << "HIKAZS:10:5:4+1+1+365:J:N'"
  msg << "HIKAZS:11:6:4+1+1+1+365:J:N'"
  msg << "HIKAZS:12:7:4+1+1+1+365:J:N'"
  msg << "HIPAES:13:1:4+1+1+1'"
  msg << "HIPSPS:14:1:4+1+1+1'"
  msg << "HIQTGS:15:1:4+1+1+1'"
  msg << "HISALS:16:4:4+1+1'"
  msg << "HISALS:17:7:4+1+1+1'"
  msg << "HICSAS:18:1:4+1+1+1+1:400'"
  msg << "HICSBS:19:1:4+1+1+1+N:N'"
  msg << "HICSLS:20:1:4+1+1+1+J'"
  msg << "HICSES:21:1:4+1+1+1+1:400'"
  msg << "HICCSS:22:1:4+1+1+1'"
  msg << "HISPAS:23:1:4+1+1+1+J:J:N:sepade?:xsd?:pain.001.001.02.xsd:sepade?:xsd?:pain.001.002.02.xsd:sepade?:xsd?:pain.001.002.03.xsd:sepade?:xsd?:pain.001.003.03.xsd:sepade?:xsd?:pain.008.002.02.xsd:sepade?:xsd?:pain.008.003.02.xsd'"
  msg << "HICCMS:24:1:4+1+1+1+500:N:N'"
  msg << "HIDSES:25:1:4+1+1+1+3:45:6:45'"
  msg << "HIBSES:26:1:4+1+1+1+2:45:2:45'"
  msg << "HIDMES:27:1:4+1+1+1+3:45:6:45:500:N:N'"
  msg << "HIBMES:28:1:4+1+1+1+2:45:2:45:500:N:N'"
  msg << "HICDBS:29:1:4+1+1+1+N'"
  msg << "HICDLS:30:1:4+1+1+1+0:0:N:J'"
  msg << "HIPPDS:31:2:4+1+1+1+1:Telekom:prepaid:N:::15;30;50:2:Vodafone:prepaid:N:::15;25;50:3:E-plus:prepaid:N:::15;20;30:4:O2:prepaid:N:::15;20;30:5:Congstar:prepaid:N:::15;30;50:6:Blau:prepaid:N:::15;20;30'"
  msg << "HICDNS:32:1:4+1+1+1+0:1:3650:J:J:J:J:N:J:J:J:J:0102030612:01020304050607080910111213141516171819202122232425262728293099'"
  msg << "HIDSBS:33:1:4+1+1+1+N:N:9999'"
  msg << "HICUBS:34:1:4+1+1+1+N'"
  msg << "HICUMS:35:1:4+1+1+1+OTHR'"
  msg << "HICDES:36:1:4+1+1+1+4:1:3650:0102030612:01020304050607080910111213141516171819202122232425262728293099'"
  msg << "HIDSWS:37:1:4+1+1+1+J'"
  msg << "HIDMCS:38:1:4+1+1+1+500:N:N:2:45:2:45::sepade?:xsd?:pain.008.003.02.xsd'"
  msg << "HIDSCS:39:1:4+1+1+1+2:45:2:45::sepade?:xsd?:pain.008.003.02.xsd'"
  msg << "HIECAS:40:1:4+1+1+1+J:N:N:urn?:iso?:std?:iso?:20022?:tech?:xsd?:camt.053.001.02'"
  msg << "GIVPUS:41:1:4+1+1+1+N'"
  msg << "GIVPDS:42:1:4+1+1+1+1'"
  msg << "HIAUBS:43:6:4+1+1+1+500'"
  msg << "HIDBSS:44:1:4+1+1+1+N:N'"
  msg << "HIBBSS:45:1:4+1+1+1+N:N'"
  msg << "HIDMBS:46:1:4+1+1+1+N:N'"
  msg << "HIBMBS:47:1:4+1+1+1+N:N'"
  msg << "HITANS:48:5:4+1+1+1+J:N:0:942:2:MTAN2:mobileTAN::mobile TAN:6:1:SMS:2048:1:J:1:0:N:0:2:N:J:00:0:1:944:2:SECUREGO:mobileTAN::SecureGo:6:1:TAN:2048:1:J:1:0:N:0:2:N:J:00:0:1:962:2:HHD1.4:HHD:1.4:Smart-TAN plus manuell:6:1:Challenge:2048:1:J:1:0:N:0:2:N:J:00:0:1:972:2:HHD1.4OPT:HHDOPT1:1.4:Smart-TAN plus optisch:6:1:Challenge:2048:1:J:1:0:N:0:2:N:J:00:0:1'"
  msg << "HIPINS:49:1:4+1+1+0+5:20:6:VR-NetKey oder Alias::HKSPA:N:HKKAZ:N:HKSAL:N:HKEKA:N:HKPAE:J:HKPSP:N:HKQTG:N:HKCSA:J:HKCSB:N:HKCSL:J:HKCSE:J:HKCCS:J:HKCCM:J:HKDSE:J:HKBSE:J:HKDME:J:HKBME:J:HKCDB:N:HKCDL:J:HKPPD:J:HKCDN:J:HKDSB:N:HKCUB:N:HKCUM:J:HKCDE:J:HKDSW:J:HKDMC:J:HKDSC:J:HKECA:N:HKAUB:J:HKDBS:N:HKBBS:N:HKDMB:N:HKBMB:N:GKVPU:N:GKVPD:N:HKTAN:N'"
  msg << "HIAZSS:50:1:4+1+1+1+1:N:::::::::::HKDSC;1;0;1;811:HKPPD;2;0;1;811:HKBBS;1;0;1;811:HKDSE;1;0;1;811:HKCDB;1;0;1;811:HKCDL;1;0;1;811:HKCSE;1;0;1;811:HKKAZ;6;0;1;811:HKDBS;1;0;1;811:HKSAL;4;0;1;811:HKQTG;1;0;1;811:GKVPU;1;0;1;811:HKECA;1;0;1;811:HKDMC;1;0;1;811:HKDME;1;0;1;811:HKSAL;7;0;1;811:HKSPA;1;0;1;811:HKEKA;5;0;1;811:HKKAZ;4;0;1;811:HKKAZ;5;0;1;811:HKCSL;1;0;1;811:HKCDN;1;0;1;811:HKCSA;1;0;1;811:HKCCM;1;0;1;811:HKAUB;6;0;1;811:HKDMB;1;0;1;811:HKBMB;1;0;1;811:HKIDN;2;0;1;811:HKDSW;1;0;1;811:HKCUM;1;0;1;811:GKVPD;1;0;1;811:HKCDE;1;0;1;811:HKBSE;1;0;1;811:HKCSB;1;0;1;811:HKCCS;1;0;1;811:HKDSB;1;0;1;811:HKBME;1;0;1;811:HKCUB;1;0;1;811:HKKAZ;7;0;1;811'"
  msg << "HIVISS:51:1:4+1+1+1+1;L;;Bankauftrag;;;;1;L;;allgemein;;;;2;L;;Legitimation;;;;2;L;;Benutzerkennung;;;;3;L;;Version;;;;4;L;;\xDCberweisung;;;;5;L;;Umbuchung;;;;6;L;;Umbuchung;;;;6;L;;terminiert;;;;7;L;;\xDCberweisung;;;;7;L;;Referenzkonto;;;;8;L;;\xDCberweisung;;;;8;L;;SEPA/EU;;;;9;L;;\xDCberweisung;;;;9;L;;Inland;;;;10;L;;\xDCberweisung;;;;10;L;;Ausland;;;;11;L;;Sammel-;;;;11;L;;\xDCberweisung;;;;12;L;;Sammel\xFCberw.;;;;12;L;;SEPA;;;;13;L;;Sammel\xFCberw.;;;;13;L;;Ausland;;;;14;L;;Lastschrift;;;;15;L;;R\xFCckgabe;;;;15;L;;Lastschrift;;;;16;L;;Lastschrift;;;;16;L;;SEPA;;;;17;L;;Lastschrift;;;;17;L;;Ausland;;;;18;L;;Sammel-;;;;18;L;;Lastschrift;;;;19;L;;Sammellasts.;;;;19;L;;SEPA;;;;20;L;;Sammellasts.;;;;20;L;;Ausland;;;;21;L;;Termin-;;;;21;L;;\xDCberweisung;;;;22;L;;Termin\xFCberw.;;;;22;L;;SEPA;;;;23;L;;Termin\xFCberw.;;;;23;L;;Ausland;;;;24;L;;Termin\xFCberw.;;;;24;L;;Sammel Inl.;;;;25;L;;Termin\xFCberw.;;;;25;L;;Sammel SEPA;;;;26;L;;Termin\xFCberw.;;;;26;L;;Sammel Ausl.;;;;27;L;;Terminlasts.;;;;27;L;;Inland;;;;28;L;;Terminlasts.;;;;28;L;;SEPA;;;;29;L;;Terminlasts.;;;;29;L;;Ausland;;;;30;L;;Terminlasts.;;;;30;L;;Sammel Inl.;;;;31;L;;Terminlasts.;;;;31;L;;Sammel SEPA;;;;32;L;;Terminlasts.;;;;32;L;;Sammel Ausl.;;;;33;L;;Dauer\xFCberw.;;;;33;L;;Inland;;;;34;L;;Dauer-;;;;34;L;;\xDCberweisung;;;;35;L;;Dauer\xFCberw.;;;;35;L;;Ausland;;;;36;L;;Dauerlasts.;;;;36;L;;Inland;;;;37;L;;Dauerlasts.;;;;37;L;;SEPA;;;;38;L;;Bestand;;;;38;L;;abfragen;;;;39;L;;L\xF6schen;;;;39;L;;Auftrag;;;;40;L;;Aussetzen;;;;40;L;;Auftrag;;;;41;L;;Aussetzen;;;;41;L;;Auftrag;;;;42;L;;\xC4ndern;;;;42;L;;Auftrag;;;;43;L;;\xC4ndern;;;;43;L;;Auftrag;;;;44;L;;Freigabe;;;;44;L;;\xDCberw. DTAUS;;;;45;L;;Freigabe;;;;45;L;;Lasts. DTAUS;;;;46;L;;Freigabe;;;;46;L;;\xDCberw. DTAZV;;;;47;L;;Freigabe;;;;47;L;;\xDCberw. SEPA;;;;48;L;;Freigabe;;;;48;L;;Lasts. SEPA;;;;49;L;;Freigabe;;;;49;L;;DSRZ-Dateien;;;;50;L;;Kontoauszug;;;;50;L;;u. Quittung;;;;51;L;;Kontoauszug;;;;51;L;;an/abmelden;;;;52;L;;Postfach;;;;52;L;;an/abmelden;;;;53;L;;Postkorb;;;;54;L;;Datentresor;;;;55;L;;Wertpapier;;;;55;L;;Kauf;;;;56;L;;Wertpapier;;;;56;L;;Verkauf;;;;57;L;;Wertpapier;;;;57;L;;Gesch\xE4ft;;;;58;L;;Anlage;;;;58;L;;Abschluss;;;;59;L;;Kredit;;;;59;L;;Abschluss;;;;60;L;;Produkt;;;;60;L;;Kauf;;;;61;L;;Versicherung;;;;61;L;;Abschluss;;;;62;L;;Service;;;;62;L;;Funktionen;;;;63;L;;TAN-Medien;;;;63;L;;Management;;;;64;L;;Mobiltelefon;;;;64;L;;laden;;;;65;L;;GeldKarte;;;;65;L;;laden;;;;66;L;;Zahlung;;;;66;L;;Internet;;;;67;L;;Geldtransfer;;;;67;L;;Internet;;;;68;L;;Freistellung;;;;69;L;;Adresse;;;;69;L;;\xE4ndern;;;;70;L;;Wertpapier;;;;70;L;;Kauf;;;;71;L;;Wertpapier;;;;71;L;;Verkauf;;;;72;L;;Wertpapier;;;;72;L;;Gesch\xE4ft;;;;73;L;;Eigene;;;;73;L;;IBAN;;;;74;L;;IBAN;;;;74;L;;Empf\xE4nger;;;;75;L;;IBAN;;;;75;L;;Zahler;;;;76;L;;IBAN;;;;76;L;;Absender;;;;77;L;;Kunden;;;;77;L;;Nummer;;;;78;L;;Vertrags-;;;;78;L;;Kennung;;;;79;L;;Eigene;;;;79;L;;IBAN;;;;80;L;;Name;;;;81;L;;Auftrags-;;;;81;L;;Identifikation;;;;82;L;;H\xE4ndler;;;;82;L;;Name;;;;83;L;;Karten-;;;;83;L;;nummer;;;;84;L;;TAN;;;;84;L;;Medium;;;;85;L;;Summe nur;;;;85;L;;Vorkommastellen;;;;86;L;;Freistellung;;;;86;L;;\xE4ndern;;;;87;L;;Adresse?:;;;;87;L;16;#;;;;88;L;;Angebots-Nr?:;;;;88;R;16;#;;;;89;L;;Anzahl?:;;;;89;R;16;#;;;;90;L;;Auftrags-ID?:;;;;90;L;16;#;;;;91;L;;Aut.Merkmal?:;;;;91;L;16;#;;;;92;L;;Bankdaten?:;;;;92;L;16;#;;;;93;L;;Betrag?:;;;;93;R;16;#;;;;94;L;;BIC Empf.?:;;;;94;L;16;#;;;;95;L;;BLZ Abs.?:;;;;95;R;16;#;;;;96;L;;BLZ Empf\xE4nger;;;;96;R;16;#;;;;97;L;;BLZ Karte?:;;;;97;R;16;#;;;;98;L;;BLZ Zahler?:;;;;98;R;16;#;;;;99;L;;Eigene BLZ?:;;;;99;R;16;#;;;;100;L;;Eigenes Kto?:;;;;100;R;16;#;;;;101;L;;Geburtsdatum;;;;101;L;16;#;;;;102;L;;H\xE4ndlername?:;;;;102;L;16;#;;;;103;L;;ISIN?:;;;;103;L;16;#;;;;104;L;;Kartennummer;;;;104;R;16;#;;;;105;L;;Konto Abs.?:;;;;105;R;16;#;;;;106;L;;Konto Empf\xE4nger;;;;106;R;16;#;;;;107;L;;Konto Zahler;;;;107;R;16;#;;;;108;L;;Kreditkarte?:;;;;108;R;16;#;;;;109;L;;Limit?:;;;;109;R;16;#;;;;110;L;;Menge?:;;;;110;R;16;#;;;;111;L;;Mobilfunknummer;;;;111;R;16;#;;;;112;L;;Name Empf.?:;;;;112;L;16;#;;;;113;L;;Postleitzahl;;;;113;R;16;#;;;;114;L;;Rate?:;;;;114;R;16;#;;;;115;L;;Referenzkto?:;;;;115;R;16;#;;;;116;L;;Referenzzahl;;;;116;R;16;#;;;;117;L;;St\xFCcke/Nom.?:;;;;117;R;16;#;;;;118;L;;TAN-Medium;;;;118;L;16;#;;;;119;L;;Termin?:;;;;119;L;16;#;;;;120;L;;Vertrag.Kenn;;;;120;L;16;#;;;;121;L;;WP-Kenn-Nr?:;;;;121;R;16;#;;;;122;L;;Kunden-Nr.;;;;122;R;16;#;;;;123;L;;Summe;;;;123;R;16;#;;;;124;L;32;#;;;;125;R;32;#;;;;126;L;16;#;;;;127;R;16;#;;;:HKBME;1;811;18;;;73;;;124;4;IBAN.1;93;4;CtrlSum.1;89;4;NbOfTxs.1:HKBSE;1;811;14;;;75;;;124;4;IBAN.2;93;4;CtrlSum.1:HKCCM;1;811;11;;;79;;;124;4;IBAN.1;93;4;CtrlSum.1;89;4;NbOfTxs.1:HKCCS;1;811;4;;;74;;;124;4;IBAN.2;93;4;CtrlSum.1:HKCDE;1;811;34;;;74;;;124;4;IBAN.2;93;4;CtrlSum.1:HKCDL;1;811;39;;;73;;;124;4;IBAN.1;93;4;CtrlSum.1:HKCDN;1;811;42;;;74;;;124;4;IBAN.2;93;4;CtrlSum.1:HKCSA;1;811;42;;;74;;;124;4;IBAN.2;93;4;CtrlSum.1:HKCSE;1;811;21;;;74;;;124;4;IBAN.2;93;4;CtrlSum.1:HKCSL;1;811;39;;;79;;;124;4;IBAN.1;93;4;CtrlSum.1:HKCUM;1;811;5;;;74;;;124;4;IBAN.2;93;4;CtrlSum.1:HKDMC;1;811;18;;;73;;;124;4;IBAN.1;93;4;CtrlSum.1;89;4;NbOfTxs.1:HKDME;1;811;18;;;73;;;124;4;IBAN.1;93;4;CtrlSum.1;89;4;NbOfTxs.1:HKDSC;1;811;14;;;75;;;124;4;IBAN.2;93;4;CtrlSum.1:HKDSE;1;811;14;;;75;;;124;4;IBAN.2;93;4;CtrlSum.1:HKDSW;1;811;15;;;73;;;124;1;2,1;93;1;4,1:HKPPD;2;811;64;;;79;;;124;1;2,1;93;1;5,1:HKAUB;6;811;10;;;85;;;127;3;Z.3'"
  msg << "HIUPA:52:4:4+#{credentials.user_id}+14+0'"
  msg << "HIUPD:53:6:4+#{accounts[0][:account_number]}::280:#{credentials.bank_code}+#{accounts[0][:iban]}+#{credentials.user_id}++EUR+#{owner}++Kontokorrent++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKCDB:1+HKPSP:1+HKCSL:1+HKCDL:1+HKPAE:1+HKAUB:1+HKPPD:1+HKCSA:1+HKCDN:1+HKBMB:1+HKBBS:1+HKDMB:1+HKDBS:1+HKCSB:1+HKCUB:1+HKQTG:1+HKSPA:1+HKDSB:1+HKCCM:1+HKCUM:1+HKCCS:1+HKCDE:1+HKCSE:1+HKDSW:1+HKSAL:1+HKKAZ:1+HKAUB:1+GKVPU:1+GKVPD:1'"
  msg << "HIUPD:54:6:4+#{accounts[1][:account_number]}::280:#{credentials.bank_code}+#{accounts[1][:iban]}+#{credentials.user_id}++EUR+#{owner}++Kontokorrent++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKCDB:1+HKPSP:1+HKCSL:1+HKCDL:1+HKPAE:1+HKAUB:1+HKPPD:1+HKCSA:1+HKCDN:1+HKBMB:1+HKBBS:1+HKDMB:1+HKDBS:1+HKCSB:1+HKCUB:1+HKQTG:1+HKSPA:1+HKDSB:1+HKCCM:1+HKCUM:1+HKCCS:1+HKCDE:1+HKCSE:1+HKDSW:1+HKSAL:1+HKKAZ:1+HKAUB:1+GKVPU:1+GKVPD:1'"
  msg << "HIUPD:55:6:4+#{accounts[2][:account_number]}::280:#{credentials.bank_code}+#{accounts[2][:iban]}+#{credentials.user_id}++EUR+#{owner}++Termineinlage++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKPSP:1+HKCSL:1+HKPAE:1+HKCSA:1+HKBMB:1+HKBBS:1+HKDMB:1+HKDBS:1+HKCSB:1+HKCUB:1+HKQTG:1+HKSPA:1+HKCUM:1+HKCCS:1+HKCSE:1+HKSAL:1+HKKAZ:1+GKVPU:1+GKVPD:1'"
  msg << "HIUPD:56:6:4+#{accounts[3][:account_number]}::280:#{credentials.bank_code}+#{accounts[3][:iban]}+#{credentials.user_id}++EUR+#{owner}++Termineinlage++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKPSP:1+HKCSL:1+HKPAE:1+HKCSA:1+HKBMB:1+HKBBS:1+HKDMB:1+HKDBS:1+HKCSB:1+HKCUB:1+HKQTG:1+HKSPA:1+HKCUM:1+HKCCS:1+HKCSE:1+HKSAL:1+HKKAZ:1+GKVPU:1+GKVPD:1'"
  msg << "HIUPD:57:6:4+#{accounts[4][:account_number]}::280:#{credentials.bank_code}+#{accounts[4][:iban]}+#{credentials.user_id}++EUR+#{owner}++Kreditkartenkonto++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKPSP:1+HKPAE:1+HKQTG:1+HKSPA:1+HKSAL:1+HKKAZ:1+GKVPU:1+GKVPD:1'"
  msg << "HIUPD:58:6:4+#{accounts[5][:account_number]}::280:#{credentials.bank_code}+#{accounts[5][:iban]}+#{credentials.user_id}++EUR+#{owner}++Sparkonto++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKPSP:1+HKPAE:1+HKQTG:1+HKSPA:1+HKSAL:1+HKKAZ:1+GKVPU:1+GKVPD:1'"
  msg << "HIUPD:59:6:4+#{accounts[6][:account_number]}::280:#{credentials.bank_code}+#{accounts[6][:iban]}+#{credentials.user_id}++EUR+#{owner}++Gesch\xE4ftsanteile++HKSAK:1+HKISA:1+HKSSP:1+HKSAL:1+HKKAZ:1+HKEKA:1+HKPSP:1+HKPAE:1+HKQTG:1+HKSPA:1+HKSAL:1+HKKAZ:1+GKVPU:1+GKVPD:1'"
  msg << "HNSHA:60:2+#{rand}''"
  msg << "HNHBS:61:1+1'"
  msg.join
end

def stub_dialog_finish_response_message(credentials, dialog_id: 'LM6022214510276', rand: '10999990', message_number: 3)
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')

  payload = %W[
    HNSHK:2:4+PIN:1+942+#{rand}+1+1+2::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HIRMG:3:2+0010::Nachricht entgegengenommen.+0100::Dialog beendet.'
    HNSHA:6:2+#{rand}'
  ]

  enveloped_response_message(payload, credentials, dialog_id: dialog_id, message_number: message_number, date: date, time: time)
end

def stub_balance_v4_request_message(credentials, iban: 'DE05740900000011111111', dialog_id: 'LM6022214510276', rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')
  iban = Ibanizator.iban_from_string(iban)

  payload = %W[
    HNSHK:2:4+PIN:1+942+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HKSAL:3:4+#{iban.extended_data.account_number}:280:#{credentials.bank_code}+N'
    HNSHA:4:2+#{rand}++#{credentials.pin}'
  ]

  enveloped_request_message(payload, credentials, dialog_id: dialog_id, message_number: 2, date: date, time: time)
end

def stub_balance_v6_request_message(credentials, iban: 'DE05740900000011111111', dialog_id: 'LM6022214510276', rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')
  iban = Ibanizator.iban_from_string(iban)

  payload = %W[
    HNSHK:2:4+PIN:1+942+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HKSAL:3:6+#{iban.extended_data.account_number}::280:#{credentials.bank_code}+N'
    HNSHA:4:2+#{rand}++#{credentials.pin}'
  ]

  enveloped_request_message(payload, credentials, dialog_id: dialog_id, message_number: 2, date: date, time: time)
end

def stub_balance_v7_request_message(credentials, iban: 'DE05740900000011111111', dialog_id: 'LM6022214510276', rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')
  iban = Ibanizator.iban_from_string(iban)

  payload = %W[
    HNSHK:2:4+PIN:1+942+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HKSAL:3:7+#{iban}:#{iban.extended_data.bic}:#{iban.extended_data.account_number}::280:#{credentials.bank_code}+N'
    HNSHA:4:2+#{rand}++#{credentials.pin}'
  ]

  enveloped_request_message(payload, credentials, dialog_id: dialog_id, message_number: 2, date: date, time: time)
end

def stub_balance_response_message(credentials, account_number: '11111111', dialog_id: 'LM6022214510276', rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')

  payload = %W[
    HNSHK:2:4+PIN:1+942+#{rand}+1+1+2::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HIRMG:3:2+0010::Nachricht\ entgegengenommen.'
    HIRMS:4:2:3+0020::*Abfrage\ der\ Kontosalden\ erfolgreich.'
    HISAL:5:4:3+#{account_number}:280:#{credentials.bank_code}+Kontokorrent+EUR+C:42028,3:EUR:20160219'
    HNSHA:6:2+#{rand}'
  ]

  enveloped_response_message(payload, credentials, dialog_id: dialog_id, message_number: 3, date: date, time: time)
end

def stub_transactions_v6_request_message(credentials, iban: 'DE05740900000011111111', dialog_id: 'LM6022214510276', rand: '10999990', start_date: Date.new(2016, 2, 18), end_date: Date.new(2016, 2, 20), message_number: 2)
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')
  iban = Ibanizator.iban_from_string(iban)

  payload = %W[
    HNSHK:2:4+PIN:1+942+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
    HKKAZ:3:6+#{iban.extended_data.account_number}::280:#{credentials.bank_code}+N+#{start_date.strftime('%Y%m%d')}+#{end_date.strftime('%Y%m%d')}'
    HNSHA:4:2+#{rand}++#{credentials.pin}'
  ]

  enveloped_request_message(payload, credentials, dialog_id: dialog_id, message_number: message_number, date: date, time: time)
end

def stub_transactions_v7_request_message(credentials, iban: 'DE05740900000011111111', dialog_id: 'LM6022214510276', rand: '10999990', start_date: Date.new(2016, 2, 18), end_date: Date.new(2016, 2, 20), attachment_id: nil, message_number: 2)
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')
  iban = Ibanizator.iban_from_string(iban)

  payload = []
  payload << "HNSHK:2:4+PIN:1+942+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'"

  payload << if attachment_id.nil?
               "HKKAZ:3:7+#{iban}:#{iban.extended_data.bic}:#{iban.extended_data.account_number}::280:#{credentials.bank_code}+N+#{start_date.strftime('%Y%m%d')}+#{end_date.strftime('%Y%m%d')}'"
             else
               "HKKAZ:3:7+#{iban}:#{iban.extended_data.bic}:#{iban.extended_data.account_number}::280:#{credentials.bank_code}+N+#{start_date.strftime('%Y%m%d')}+#{end_date.strftime('%Y%m%d')}++#{attachment_id}'"
             end

  payload << "HNSHA:4:2+#{rand}++#{credentials.pin}'"
  payload = payload.join

  msg = []
  msg << "HNHBK:1:3+000000000000+300+#{dialog_id}+#{message_number}'"
  msg << "HNVSK:998:3+PIN:1+998+1+1::0+1:#{date}:#{time}+2:2:13:@5@NOKEY:6:1+280:#{credentials.bank_code}:#{credentials.user_id}:V:1:1+0'"
  msg << "HNVSD:999:1+@#{payload.length}@#{payload}'"
  msg << "HNHBS:5:1+#{message_number}'"
  msg = msg.join

  padded_length = msg.length.to_s.rjust(12, '0')

  msg.gsub('HNHBK:1:3+000000000000', "HNHBK:1:3+#{padded_length}")
end

def stub_transactions_response_message(credentials, account_number: '11111111', dialog_id: 'LM6022214510276', rand: '10999990', attachment_id: nil)
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')

  mt940 = "\r\n:20:STARTUMS\r\n:25:#{credentials.bank_code}/#{account_number}\r\n:28C:0\r\n:60F:C160218EUR111,23\r\n:61:160218D18,33NMSCNONREF\r\n:86:005?00Basislastschrift?10931?20302-6022613-2945142 Amazon\r\n?21.Mktplce EU-DE 111111111111?222222 EREF: 1111111111111111\r\n?23 MREF: 44444444444444444444?245555555555 CRED: 6666666666\r\n?2577777777 IBAN: DE8730030880?261908262006 BIC: TUBDDEDD\r\n?3030030880?31?32AMAZON PAYMENTS EUROPE S.C.?33A.?34992\r\n:62F:C160218EUR111,56\r\n-"

  payload = []
  payload << "HNSHK:2:4+PIN:1+942+#{rand}+1+1+2::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'"
  payload << "HIRMG:3:2+0010::Nachricht entgegengenommen.'"

  payload << if attachment_id.nil?
               "HIRMS:4:2:3+0020::*Umsatzbereitstellung erfolgreich'"
             else
               "HIRMS:4:2:3+3040::*Es liegen weitere Umsze vor:#{attachment_id}'"
             end
  payload = payload.join

  payload << "HIKAZ:5:6:3+@#{mt940.size}@#{mt940}'"
  payload << "HNSHA:6:2+#{rand}'"

  msg = []
  msg << "HNHBK:1:3+00000000000+300+#{dialog_id}+2+#{dialog_id}:2'"
  msg << "HNVSK:998:3+PIN:1+998+1+2::0+1:#{date}:#{time}+2:2:13:@5@NOKEY:6:1+280:#{credentials.bank_code}:#{credentials.user_id}:V:1:1+0'"
  msg << "HNVSD:999:1+@#{payload.length}@#{payload}'"
  msg << "HNHBS:7:1+2'"
  msg = msg.join

  padded_length = msg.length.to_s.rjust(12, '0')

  msg.gsub('HNHBK:1:3+000000000000', "HNHBK:1:3+#{padded_length}")
end

def stub_system_id_request_message(credentials, iban: 'DE05740900000011111111', dialog_id: 'LM6022214510276', rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')
  iban = Ibanizator.iban_from_string(iban)

  payload = %W[
        HNSHK:2:4+PIN:1+999+#{rand}+1+1+1::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
        HKIDN:3:2+280:#{credentials.bank_code}+#{credentials.user_id}+0+1'
        HKVVB:4:3+0+0+1+FintasticHBCI+#{Hbci::VERSION}'
        HKSYN:5:3+0'
        HNSHA:6:2+#{rand}++#{credentials.pin}'
      ]

  enveloped_request_message(payload, credentials, dialog_id: 0, message_number: 1, date: date, time: time)
end

def stub_system_id_response_message(credentials, account_number: '11111111', dialog_id: 'LM6022214510276', rand: '10999990')
  date = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%H%m%S')

  payload = %W[
        HNSHK:2:4+PIN:1+942+#{rand}+1+1+2::0+1+1:#{date}:#{time}+1:999:1+6:10:16+280:#{credentials.bank_code}:#{credentials.user_id}:S:0:0'
        HISYN:3:4:5+3709434306917000W15S4440RY65OC'
        HNSHA:4:2+#{rand}'
      ]

  enveloped_response_message(payload, credentials, dialog_id: 0, message_number: 1, date: date, time: time)
end
