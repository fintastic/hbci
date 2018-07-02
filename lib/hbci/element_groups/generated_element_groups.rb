# frozen_string_literal: true

module Hbci
  module ElementGroups
    class AllowedGV < ElementGroup
      element :code
      element :req_sigs
      element :limittype
      element :value
      element :curr
      element :limitdays
    end

    class BTG < ElementGroup
      element :value
      element :curr
    end

    class Cert < ElementGroup
      element :type
      element :cert
    end

    class KeyName < ElementGroup
      element :country
      element :blz
      element :userid
      element :keytype
      element :keynum
      element :keyversion
    end

    class KIK < ElementGroup
      element :country
      element :blz
    end

    class KLimit < ElementGroup
      element :limittype
      element :value
      element :curr
      element :limitdays
    end

    class MsgRef < ElementGroup
      element :dialogid
      element :msgnum
    end

    class PubKey < ElementGroup
      element :usage
      element :mode
      element :method
      element :modulus
      element :modname
      element :exponent
      element :expname
    end

    class RetVal < ElementGroup
      element :code
      element :ref
      element :text
      element :parm
    end

    class SecTimestamp < ElementGroup
      element :type
      element :date
      element :time
    end

    class SuppCompMethods < ElementGroup
      element :func
      element :version
    end

    class SuppLangs < ElementGroup
      element :lang
    end

    class SuppSecMethods < ElementGroup
      element :method
      element :version
    end

    class SuppVersions < ElementGroup
      element :version
    end

    class Address2 < ElementGroup
      element :name1
      element :name2
      element :street_pf
      element :plz
      element :ort
      element :country
      element :tel
      element :fax
      element :email
    end

    class Aussetzung1 < ElementGroup
      element :annual
      element :startdate
      element :enddate
      element :number
    end

    class Aussetzung2 < ElementGroup
      element :annual
      element :startdate
      element :enddate
      element :number
      element :newvalue_value
      element :newvalue_curr
    end

    class Aussetzung3 < ElementGroup
      element :annual
      element :startdate
      element :enddate
      element :number
      element :value
      element :curr
    end

    class Berechtigter1 < ElementGroup
      element :name
      element :name2
      element :berechtigter
      element :berechtigung
      element :btg_value
      element :btg_curr
      element :risiko
    end

    class Berechtigter2 < ElementGroup
      element :name
      element :name2
      element :berechtigter
      element :berechtigung
      element :value
      element :curr
      element :risiko
    end

    class ChallengeValidity < ElementGroup
      element :date
      element :time
    end

    class CommParam < ElementGroup
      element :dienst
      element :addr
      element :addr2
      element :filter
      element :filterversion
    end

    class DauerDetails < ElementGroup
      element :firstdate
      element :timeunit
      element :turnus
      element :execday
      element :lastdate
    end

    class FestCond1 < ElementGroup
      element :anlagedate
      element :ablaufdate
      element :zinssatz
      element :zinsmethode
      element :value
      element :curr
      element :value
      element :curr
      element :condid
      element :condbez
    end

    class FestCond2 < ElementGroup
      element :anlagedate
      element :ablaufdate
      element :zinssatz
      element :zinsmethode
      element :value
      element :curr
      element :value
      element :curr
      element :condid
      element :condbez
    end

    class FestCondVersion < ElementGroup
      element :version
      element :date
      element :time
    end

    class Info < ElementGroup
      element :code
      element :msg
    end

    class InfoInfo < ElementGroup
      element :code
      element :descr
      element :type
      element :version
      element :format
      element :comment
    end

    class KTO < ElementGroup
      element :number
      element :country
      element :blz
    end

    class KTV2 < ElementGroup
      element :number
      element :subnumber
      element :kik_country, default: 280
      element :kik_blz
    end

    class KTV3 < ElementGroup
      element :number
      element :subnumber
      element :country
      element :blz
    end

    class KTVInt < ElementGroup
      element :iban
      element :bic
      element :number
      element :subnumber
      element :kik_country
      element :kik_blz
    end

    class KTVZVInt < ElementGroup
      element :sepa
      element :iban
      element :bic
      element :number
      element :subnumber
      element :country
      element :blz
    end

    class ParCustomMsg < ElementGroup
      element :maxlen
    end

    class ParDauerDel < ElementGroup
      element :minpretime
      element :maxpretime
      element :cantermdel
    end

    class ParDauerSEPADel < ElementGroup
      element :minpretime
      element :maxpretime
      element :cantermdel
      element :orderdata_required
    end

    class ParDauerEdit < ElementGroup
      element :numtermchanges
      element :minpretime
      element :maxpretime
      element :recktoeditable
      element :recnameeditable
      element :valueeditable
      element :keyeditable
      element :usageeditable
      element :firstexeceditable
      element :timeuniteditable
      element :turnuseditable
      element :execdayeditable
      element :lastexeceditable
      element :maxusage
      element :turnusmonths
      element :dayspermonth
      element :turnusweeks
      element :daysperweek
      element :textkey
    end

    class ParDauerSEPAEdit < ElementGroup
      element :numtermchanges
      element :minpretime
      element :maxpretime
      element :recktoeditable
      element :recnameeditable
      element :valueeditable
      element :usageeditable
      element :firstexeceditable
      element :timeuniteditable
      element :turnuseditable
      element :execdayeditable
      element :lastexeceditable
      element :turnusmonths
      element :dayspermonth
      element :turnusweeks
      element :daysperweek
    end

    class ParDauerNew < ElementGroup
      element :maxusage
      element :minpretime
      element :maxpretime
      element :turnusmonths
      element :dayspermonth
      element :turnusweeks
      element :daysperweek
      element :textkey
    end

    class ParDauerSEPANew < ElementGroup
      element :maxusage
      element :minpretime
      element :maxpretime
      element :turnusmonths
      element :dayspermonth
      element :turnusweeks
      element :daysperweek
    end

    class ParFestCondList < ElementGroup
      element :curr
    end

    class ParFestNew1 < ElementGroup
      element :canotherausbuchungskto
      element :canotherzinskto
      element :kontoauszug
    end

    class ParFestNew2 < ElementGroup
      element :canexistinganlkto
      element :canotherausbuchungskto
      element :canotherzinskto
      element :kontoauszug
    end

    class ParKontoauszug < ElementGroup
      element :canindex
      element :needreceipt
      element :canmaxentries
      element :format
    end

    class ParKUmsNew1 < ElementGroup
      element :timerange
      element :canmaxentries
    end

    class ParKUmsNew2 < ElementGroup
      element :timerange
      element :canmaxentries
      element :canallaccounts
    end

    class ParKUmsZeit1 < ElementGroup
      element :timerange
      element :canmaxentries
    end

    class ParKUmsZeit2 < ElementGroup
      element :timerange
      element :canmaxentries
      element :canallaccounts
    end

    class ParLast < ElementGroup
      element :maxusage
      element :key
    end

    class ParLastObjection < ElementGroup
      element :value
      element :curr
      element :key
    end

    class ParOrderHistory < ElementGroup
      element :timerange
      element :canmaxentries
    end

    class ParPinTan2 < ElementGroup
      element :pinlen_min
      element :pinlen_max
      element :tanlen_max
      element :info_userid
      element :info_customerid
      element :segcode
      element :needtan
    end

    class ParSammelLast < ElementGroup
      element :maxcsets
      element :maxusage
      element :key
    end

    class ParSammelUeb < ElementGroup
      element :maxcsets
      element :maxusage
      element :key
    end

    class ParSammelUebSEPA < ElementGroup
      element :maxnum
      element :needtotal
      element :cansingletransfer
    end

    class ParSEPAInfo < ElementGroup
      element :cansingleaccquery
      element :cannationalacc
      element :canstructusage
      element :suppformats
    end

    class ParTermSepaEinzelLast < ElementGroup
      element :min_vorl_zeit_fnalrcur
      element :max_vorl_zeit_fnalrcur
      element :min_vorl_zeit_frstooff
      element :max_vorl_zeit_frstooff
    end

    class ParTermSepaCOR1 < ElementGroup
      element :min_vorl_zeit_fnalrcur
      element :max_vorl_zeit_fnalrcur
      element :min_vorl_zeit_frstooff
      element :max_vorl_zeit_frstooff
      element :purpose_codes
      element :suppformats
    end

    class ParTermSepaB2B < ElementGroup
      element :min_vorl_zeit_fnalrcur
      element :max_vorl_zeit_fnalrcur
      element :min_vorl_zeit_frstooff
      element :max_vorl_zeit_frstooff
    end

    class ParSammelLastSEPA < ElementGroup
      element :min_vorl_zeit_fnalrcur
      element :max_vorl_zeit_fnalrcur
      element :min_vorl_zeit_frstooff
      element :max_vorl_zeit_frstooff
      element :maxnum
      element :needtotal
      element :cansingletransfer
    end

    class ParSammelLastCOR1SEPA < ElementGroup
      element :maxnum
      element :needtotal
      element :cansingletransfer
      element :min_vorl_zeit_fnalrcur
      element :max_vorl_zeit_fnalrcur
      element :min_vorl_zeit_frstooff
      element :max_vorl_zeit_frstooff
      element :purpose_codes
      element :suppformats
    end

    class ParSammelLastB2BSEPA < ElementGroup
      element :min_vorl_zeit_fnalrcur
      element :max_vorl_zeit_fnalrcur
      element :min_vorl_zeit_frstooff
      element :max_vorl_zeit_frstooff
      element :maxnum
      element :needtotal
      element :cansingletransfer
    end

    class ParUmbSepa < ElementGroup
      element :purpose_codes
      element :suppformats
    end

    class ParTAN2Step1 < ElementGroup
      element :can1step
      element :canmultitangvs
      element :orderhashmode
      element :instsig
      element :secfunc
      element :process
      element :id
      element :name
      element :maxlentan2step
      element :tanformat
      element :inputinfo
      element :maxleninput2step
      element :noftanlists
      element :canmultitan
      element :cantandelay
    end

    class ParTAN2Step2 < ElementGroup
      element :can1step
      element :canmultitangvs
      element :orderhashmode
      element :secfunc
      element :process
      element :id
      element :name
      element :maxlentan2step
      element :tanformat
      element :inputinfo
      element :maxleninput2step
      element :noftanlists
      element :canmultitan
      element :cantandelay
      element :needtanlistidx
      element :canstorno
      element :needchallengeklass
      element :needchallengevalue
    end

    class ParTAN2Step3 < ElementGroup
      element :can1step
      element :canmultitangvs
      element :orderhashmode
      element :secfunc
      element :process
      element :id
      element :name
      element :maxlentan2step
      element :tanformat
      element :inputinfo
      element :maxleninput2step
      element :noftanlists
      element :canmultitan
      element :cantandelay
      element :needtanlistidx
      element :canstorno
      element :needchallengeklass
      element :needchallengevalue
      element :initmode
      element :needtanmedia
      element :nofactivetanmedia
    end

    class ParTAN2Step4 < ElementGroup
      element :can1step
      element :canmultitangvs
      element :orderhashmode
      element :secfunc
      element :process
      element :id
      element :zkamethod_name
      element :zkamethod_version
      element :name
      element :maxlentan2step
      element :tanformat
      element :inputinfo
      element :maxleninput2step
      element :noftanlists
      element :canmultitan
      element :cantandelay
      element :needtanlistidx
      element :canstorno
      element :needsmsaccount
      element :needchallengeklass
      element :needchallengevalue
      element :ischallengestructured
      element :initmode
      element :needtanmedia
      element :nofactivetanmedia
    end

    class ParTAN2Step5 < ElementGroup
      element :can1step
      element :canmultitangvs
      element :orderhashmode
      element :secfunc
      element :process
      element :id
      element :zkamethod_name
      element :zkamethod_version
      element :name
      element :maxlentan2step
      element :tanformat
      element :inputinfo
      element :maxleninput2step
      element :noftanlists
      element :canmultitan
      element :cantandelay
      element :needtanlistidx
      element :canstorno
      element :needsmsaccount
      element :needorderaccount
      element :needchallengeklass
      element :ischallengestructured
      element :initmode
      element :needtanmedia
      element :nofactivetanmedia
    end

    class ParTermSammelLast < ElementGroup
      element :minpretime
      element :maxpretime
      element :maxcsets
      element :maxusage
      element :key
    end

    class ParTermSammelLastList < ElementGroup
      element :cantimerange
    end

    class ParTermSammelUeb < ElementGroup
      element :minpretime
      element :maxpretime
      element :maxcsets
      element :maxusage
      element :key
    end

    class ParTermSammelUebList < ElementGroup
      element :cantimerange
    end

    class ParTermUeb < ElementGroup
      element :minpretime
      element :maxpretime
      element :maxusage
      element :key
    end

    class ParTermUebSEPA < ElementGroup
      element :minpretime
      element :maxpretime
    end

    class ParTermUebEdit < ElementGroup
      element :minpretime
      element :maxpretime
      element :maxusage
      element :key
    end

    class ParTermUebList < ElementGroup
      element :cantimerange
    end

    class ParTermUebSEPAList < ElementGroup
      element :canmaxentries
      element :cantimerange
    end

    class ParTermUebSEPADel < ElementGroup
      element :orderdata_required
    end

    class ParTermUebSEPAEdit < ElementGroup
      element :minpretime
      element :maxpretime
    end

    class ParUeb < ElementGroup
      element :maxusage
      element :key
    end

    class ParUebForeign < ElementGroup
      element :caniban
      element :countryinfo
    end

    class ParUmb < ElementGroup
      element :maxusage
      element :key
    end

    class ParVormerkposten < ElementGroup
      element :canmaxentries
      element :canallaccounts
    end

    class ParWPDepotList1 < ElementGroup
      element :canmaxentries
    end

    class ParWPDepotList2 < ElementGroup
      element :canmaxentries
      element :cancurr
      element :canquality
    end

    class ParWPDepotUms < ElementGroup
      element :timerange
    end

    class ParWPInfoList < ElementGroup
      element :needdepot
    end

    class ParWPKursList1 < ElementGroup
      element :availboerses
      element :kurspaket
    end

    class ParWPKursList2 < ElementGroup
      element :needdepot
      element :canquality
      element :availboerses
      element :kurspaket
    end

    class ParWPRefList < ElementGroup
      element :searchallowed
      element :regionallowed
      element :standardallowed
      element :newallowed
      element :availboerses
      element :availtypes
    end

    class ParWPStammList < ElementGroup
      element :needdepot
      element :risikodescr
    end

    class Prolong < ElementGroup
      element :laufzeit
      element :value
      element :curr
      element :wiederanlage
    end

    class Saldo < ElementGroup
      element :credit_debit
      element :btg_value
      element :btg_curr
      element :date
      element :time
    end

    class Saldo2 < ElementGroup
      element :credit_debit
      element :value
      element :curr
      element :date
      element :time
    end

    class TANInfo < ElementGroup
      element :usagecode
      element :usagetxt
      element :tan
      element :usagedate
      element :usagetime
    end

    class TANMediaInfo1 < ElementGroup
      element :mediacategory
      element :status
      element :cardnumber
      element :cardseqnumber
      element :tanlistnumber
      element :freetans
      element :lastuse
      element :activatedon
    end

    class TANMediaInfo2 < ElementGroup
      element :mediacategory
      element :status
      element :cardnumber
      element :cardseqnumber
      element :cardtype
      element :number
      element :subnumber
      element :kik_country
      element :kik_blz
      element :validfrom
      element :validto
      element :tanlistnumber
      element :medianame
      element :iban
      element :bic
      element :number
      element :subnumber
      element :kik_country
      element :kik_blz
      element :freetans
      element :lastuse
      element :activatedon
    end

    class TANMediaInfo3 < ElementGroup
      element :mediacategory
      element :status
      element :cardnumber
      element :cardseqnumber
      element :cardtype
      element :number
      element :subnumber
      element :kik_country
      element :kik_blz
      element :validfrom
      element :validto
      element :tanlistnumber
      element :medianame
      element :mobilenumber_secure
      element :iban
      element :bic
      element :number
      element :subnumber
      element :kik_country
      element :kik_blz
      element :freetans
      element :lastuse
      element :activatedon
    end

    class TANMediaInfo4 < ElementGroup
      element :mediacategory
      element :status
      element :cardnumber
      element :cardseqnumber
      element :cardtype
      element :number
      element :subnumber
      element :kik_country
      element :kik_blz
      element :validfrom
      element :validto
      element :tanlistnumber
      element :medianame
      element :mobilenumber_secure
      element :mobilenumber
      element :iban
      element :bic
      element :number
      element :subnumber
      element :kik_country
      element :kik_blz
      element :freetans
      element :lastuse
      element :activatedon
    end

    class TimeRange < ElementGroup
      element :startdate
      element :enddate
    end

    class Timestamp < ElementGroup
      element :date
      element :time
    end

    class Usage1 < ElementGroup
      element :usage
    end

    class Usage2 < ElementGroup
      element :usage
    end

    class Usage3 < ElementGroup
      element :usage
    end

    class WPBInfo1 < ElementGroup
      element :boerse
      element :curr
      element :smallestunit
      element :marktsegment
    end

    class WPBInfo2 < ElementGroup
      element :boerse
      element :curr
      element :type
      element :type_xetra
      element :smallestunit
      element :marktsegmentausland
      element :marktsegment
    end

    class WPBKurs < ElementGroup
      element :kurs
      element :curr
      element :addkurs
      element :date
      element :time
      element :boerse
    end

    class WPKursData < ElementGroup
      element :boerse
      element :notizeinheit
      element :curr
      element :date
      element :time
      element :kassakurs_kurs
      element :vorboerse_kurs
      element :openkurs_kurs
      element :lastkurs_kurs
      element :addkurs
      element :nachboerse_kurs
      element :zeitbezug
      element :annmax_kurs
      element :annmin_kurs
      element :prevdaykurs_kurs
      element :outputprice_kurs
      element :retprice_kurs
    end

    class WPRef < ElementGroup
      element :type
      element :code
    end

    class WPStammAktien < ElementGroup
      element :boerse
      element :nennwert_value
      element :kapitalchange
      element :kapitalchangevalue_value
      element :dividende_value
      element :hvtermin
    end

    class WPStammFonds < ElementGroup
      element :faelligkeit
      element :wiederanlagerabattvon
      element :wiederanlagerabatt_bis
      element :wiederanlagerabatt
      element :ausgabeaufschlag
      element :verwaltungsgebuehr
      element :depotbankgebuehr
      element :info
    end

    class WPStammOptions < ElementGroup
      element :boerse
      element :faelligkeit
      element :underlying
      element :bezugsverhaeltnis
    end

    class WPStammRenten < ElementGroup
      element :boerse
      element :zinssatz
      element :emissdate
      element :faelligkeit
      element :firstzinstermin
      element :zinsperiode
      element :einloesungskurs
      element :einloesungstype
    end

    class WPZinsTermine < ElementGroup
      element :termin
    end
  end
end
