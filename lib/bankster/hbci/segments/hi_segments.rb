module Bankster
  module Hbci
    module Segments
      class HIBPAv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :version
        element_group :KIK, type: KIK
        element :kiname
        element :numgva
        element_group :SuppLangs, type: SuppLangs
        element_group :SuppVersions, type: SuppVersions
        element :maxmsgsize
        element :timeout_min
        element :timeout_max
      end

      class HIKPVv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :SuppCompMethods, type: SuppCompMethods
      end

      class HISSPv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :msgtype
        element :dialogidref
        element :msgnumref
        element :func
        element_group :KeyName, type: KeyName
        element :locktype
        element_group :SecTimestamp, type: SecTimestamp
        element_group :Cert, type: Cert
      end

      class HIKIMv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :betreff
        element :text
      end

      class HIUPDv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTV2
        element :customerid
        element :acctype
        element :cur
        element :name1
        element :name2
        element :konto
        element_group :KLimit, type: KLimit
        element_group :AllowedGV, type: AllowedGV
      end

      class HIUPDv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTV2
        element :iban
        element :customerid
        element :acctype
        element :cur
        element :name1
        element :name2
        element :konto
        element_group :KLimit, type: KLimit
        element_group :AllowedGV, type: AllowedGV
        element :accountdata
      end

      class HIRMGv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :RetVal, type: RetVal
      end

      class HIRMSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :RetVal, type: RetVal
      end

      class HISHVv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :mixing
        element_group :SuppSecMethods, type: SuppSecMethods
      end

      class HIISAv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :type
        element :dialogid
        element :msgnum
        element :func
        element_group :KeyName, type: KeyName
        element_group :PubKey, type: PubKey
        element_group :Cert, type: Cert
      end

      class HISYNv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :sysid
        element :msgnum
        element :sigid
      end

      class HISYNv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :sysid
        element :msgnum
        element :sigid
        element :sigid2
      end

      class HIUPAv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :userid
        element :version
        element :usage
      end

      class HIUPAv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :userid
        element :version
        element :usage
        element :username
      end

      class HIUPAv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :userid
        element :version
        element :usage
        element :username
        element :userdata
      end

      class HIKIFv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV2
        element :acctype
        element :name
        element :name2
        element :accbez
        element :curr
        element :opendate
        element :sollzins
        element :habenzins
        element :overdrivezins
        element_group :kredit, type: BTG
        element_group :refkto, type: KTV2
        element_group :Address, type: Address2
        element :versandart
        element :turnus
        element :info
        element_group :Berechtigter, type: Berechtigter1
      end

      class HIKIFSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIKIFv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV3
        element :acctype
        element :name
        element :name2
        element :accbez
        element :curr
        element :opendate
        element :sollzins
        element :habenzins
        element :overdrivezins
        element_group :kredit, type: BTG
        element_group :refkto, type: KTV3
        element_group :Address, type: Address2
        element :versandart
        element :turnus
        element :info
        element_group :Berechtigter, type: Berechtigter2
      end

      class HIKIFSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIAZKv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :cardtype
        element :cardnumber
        element :nextcardnumber
        element :name
        element :validfrom
        element :validuntil
        element_group :cardlimit, type: BTG
        element :comment
      end

      class HIAZKSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIAZKv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :cardtype
        element :cardbez
        element :cardnumber
        element :nextcardnumber
        element :name
        element :validfrom
        element :validuntil
        element_group :cardlimit, type: BTG
        element :comment
      end

      class HIAZKSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIPAESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIKOMv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KIK, type: KIK
        element :deflang
        element_group :CommParam, type: CommParam
      end

      class HIKOMSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIKOMv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KIK, type: KIK
        element :deflang
        element_group :CommParam, type: CommParam
      end

      class HIKOMSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIKOMv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KIK, type: KIK
        element :deflang
        element_group :CommParam, type: CommParam
      end

      class HIKOMSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIKDMSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParCustomMsg, type: ParCustomMsg
      end

      class HIKDMSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParCustomMsg, type: ParCustomMsg
      end

      class HIKDMSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParCustomMsg, type: ParCustomMsg
      end

      class HIKDMSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParCustomMsg, type: ParCustomMsg
      end

      class HIDALSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerDel, type: ParDauerDel
      end

      class HIDALSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerDel, type: ParDauerDel
      end

      class HIDALSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerDel, type: ParDauerDel
      end

      class HIDALSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParDauerDel, type: ParDauerDel
      end

      class HIDANv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HIDANSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerEdit, type: ParDauerEdit
      end

      class HIDANv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HIDANSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerEdit, type: ParDauerEdit
      end

      class HIDANv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HIDANSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerEdit, type: ParDauerEdit
      end

      class HIDANv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HIDANSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParDauerEdit, type: ParDauerEdit
      end

      class HIDABv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTO
        element_group :Other, type: KTO
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage1
        element :date
        element :orderid
        element_group :DauerDetails, type: DauerDetails
        element_group :Aussetzung, type: Aussetzung1
      end

      class HIDABSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIDABv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTO
        element_group :Other, type: KTO
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage2
        element :date
        element :orderid
        element_group :DauerDetails, type: DauerDetails
        element_group :Aussetzung, type: Aussetzung2
      end

      class HIDABSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIDABv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV2
        element_group :Other, type: KTV2
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage3
        element :date
        element :orderid
        element_group :DauerDetails, type: DauerDetails
        element_group :Aussetzung, type: Aussetzung2
      end

      class HIDABSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIDABv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV3
        element_group :Other, type: KTV3
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage3
        element :date
        element :orderid
        element_group :DauerDetails, type: DauerDetails
        element_group :Aussetzung, type: Aussetzung3
      end

      class HIDABSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIDABv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV3
        element_group :Other, type: KTV3
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage3
        element :date
        element :orderid
        element_group :DauerDetails, type: DauerDetails
        element_group :Aussetzung, type: Aussetzung3
        element :canchange
        element :canskip
        element :candel
      end

      class HIDABSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIDAEv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDAESv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerNew, type: ParDauerNew
      end

      class HIDAEv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDAESv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerNew, type: ParDauerNew
      end

      class HIDAEv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDAESv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParDauerNew, type: ParDauerNew
      end

      class HIDAEv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDAESv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParDauerNew, type: ParDauerNew
      end

      class HIFGKv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :FestCondVersion, type: FestCondVersion
        element_group :FestCond, type: FestCond1
      end

      class HIFGKSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParFestCondList, type: ParFestCondList
      end

      class HIFGKv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :FestCondVersion, type: FestCondVersion
        element_group :FestCond, type: FestCond1
      end

      class HIFGKSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParFestCondList, type: ParFestCondList
      end

      class HIFGKv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :FestCondVersion, type: FestCondVersion
        element_group :FestCond, type: FestCond2
      end

      class HIFGKSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParFestCondList, type: ParFestCondList
      end

      class HIFGBv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :Anlagekto, type: KTO
        element :kontakt
        element_group :Anlagebetrag, type: BTG
        element_group :FestCond, type: FestCond1
        element_group :Belastungskto, type: KTO
        element :eigenerechnung
        element :wiederanlage
        element :kontoauszug
        element_group :Ausbuchungskto, type: KTO
        element_group :Zinskto, type: KTO
        element_group :FestCondVersion, type: FestCondVersion
        element_group :Zinsbetrag, type: BTG
        element :status
        element_group :Prolong, type: Prolong
      end

      class HIFGBSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIFGBv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :Anlagekto, type: KTV2
        element :kontakt
        element_group :Anlagebetrag, type: BTG
        element_group :FestCond, type: FestCond1
        element_group :Belastungskto, type: KTV2
        element :eigenerechnung
        element :wiederanlage
        element :kontoauszug
        element_group :Ausbuchungskto, type: KTV2
        element_group :Zinskto, type: KTV2
        element_group :FestCondVersion, type: FestCondVersion
        element_group :Zinsbetrag, type: BTG
        element :status
        element_group :Prolong, type: Prolong
      end

      class HIFGBSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIFGBv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :Anlagekto, type: KTV3
        element :kontakt
        element_group :Anlagebetrag, type: BTG
        element_group :FestCond, type: FestCond2
        element_group :Belastungskto, type: KTV3
        element :eigenerechnung
        element :wiederanlage
        element :kontoauszug
        element_group :Ausbuchungskto, type: KTV3
        element_group :Zinskto, type: KTV3
        element_group :FestCondVersion, type: FestCondVersion
        element_group :Zinsbetrag, type: BTG
        element :status
        element_group :Prolong, type: Prolong
      end

      class HIFGBSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIFGNv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTO
        element :kontakt
      end

      class HIFGNSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParFestNew, type: ParFestNew1
      end

      class HIFGNv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTV2
        element :kontakt
      end

      class HIFGNSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParFestNew, type: ParFestNew2
      end

      class HIFGNv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTV3
        element :kontakt
      end

      class HIFGNSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParFestNew, type: ParFestNew2
      end

      class HIINFSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIINFv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :Info, type: Info
      end

      class HIINFSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIINFv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :Info, type: Info
      end

      class HIINFSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIINFv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :Info, type: Info
      end

      class HIINFSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIKIAv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :InfoInfo, type: InfoInfo
      end

      class HIKIASv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIKIAv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :InfoInfo, type: InfoInfo
      end

      class HIKIASv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIKIAv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :InfoInfo, type: InfoInfo
      end

      class HIKIASv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIKIAv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :InfoInfo, type: InfoInfo
      end

      class HIKIASv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIEKAv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :format
        element_group :TimeRange, type: TimeRange
        element :booked
        element :abschlussinfo
        element :kondinfo
        element :ads
        element :receipt
      end

      class HIEKASv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKontoauszug, type: ParKontoauszug
      end

      class HIEKAv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :format
        element_group :TimeRange, type: TimeRange
        element :booked
        element :abschlussinfo
        element :kondinfo
        element :ads
        element :iban
        element :bic
        element :name
        element :name2
        element :name3
        element :receipt
      end

      class HIEKASv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKontoauszug, type: ParKontoauszug
      end

      class HIEKAv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :format
        element_group :TimeRange, type: TimeRange
        element :booked
        element :abschlussinfo
        element :kondinfo
        element :ads
        element :iban
        element :bic
        element :name
        element :name2
        element :name3
        element :receipt
      end

      class HIEKASv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKontoauszug, type: ParKontoauszug
      end

      class HIEKAv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :format
        element_group :TimeRange, type: TimeRange
        element :booked
        element :abschlussinfo
        element :kondinfo
        element :ads
        element :iban
        element :bic
        element :name
        element :name2
        element :name3
        element :receipt
      end

      class HIEKASv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKontoauszug, type: ParKontoauszug
      end

      class HIKANv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKANSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParKUmsNew, type: ParKUmsNew1
      end

      class HIKANv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKANSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParKUmsNew, type: ParKUmsNew2
      end

      class HIKANv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKANSv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKUmsNew, type: ParKUmsNew2
      end

      class HIKANv7 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKANSv7 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKUmsNewSEPA, type: ParKUmsNew2
      end

      class HIKAZv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKAZSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParKUmsZeit, type: ParKUmsZeit1
      end

      class HIKAZv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKAZSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParKUmsZeit, type: ParKUmsZeit2
      end

      class HIKAZv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKAZSv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKUmsZeit, type: ParKUmsZeit2
      end

      class HIKAZv7 < Segment
        element_group :SegHead, type: SegHeadInst
        element :booked
        element :notbooked
      end

      class HIKAZSv7 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParKUmsZeitSEPA, type: ParKUmsZeit2
      end

      class HILASSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParLast, type: ParLast
      end

      class HILASSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParLast, type: ParLast
      end

      class HILASSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParLast, type: ParLast
      end

      class HILASSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParLast, type: ParLast
      end

      class HILSWSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParLastObjection, type: ParLastObjection
      end

      class HILSWSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParLastObjection, type: ParLastObjection
      end

      class HIAUEv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV3
        element_group :Other, type: KTV3
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage3
        element :date
        element :id
        element :status
      end

      class HIAUESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParOrderHistory, type: ParOrderHistory
      end

      class HIPINSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParPinTan, type: ParPinTan2
      end

      class HISALv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTO
        element :kontobez
        element :curr
        element_group :booked, type: Saldo
        element_group :pending, type: Saldo
        element_group :kredit, type: BTG
        element_group :available, type: BTG
        element_group :used, type: BTG
      end

      class HISALSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HISALv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTO
        element :kontobez
        element :curr
        element_group :booked, type: Saldo
        element_group :pending, type: Saldo
        element_group :kredit, type: BTG
        element_group :available, type: BTG
        element_group :used, type: BTG
        element :Timestamp.date
        element :Timestamp.time
      end

      class HISALSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HISALv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTV2
        element :kontobez
        element :curr
        element_group :booked, type: Saldo
        element_group :pending, type: Saldo
        element_group :kredit, type: BTG
        element_group :available, type: BTG
        element_group :used, type: BTG
        element :Timestamp.date
        element :Timestamp.time
        element :duedate
      end

      class HISALSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HISALv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTV3
        element :kontobez
        element :curr
        element_group :booked, type: Saldo2
        element_group :pending, type: Saldo2
        element_group :kredit, type: BTG
        element_group :available, type: BTG
        element_group :used, type: BTG
        element_group :overdrive, type: BTG
        element_group :Timestamp, type: Timestamp
        element :duedate
      end

      class HISALSv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISALv7 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :KTV, type: KTVInt
        element :kontobez
        element :curr
        element_group :booked, type: Saldo2
        element_group :pending, type: Saldo2
        element_group :kredit, type: BTG
        element_group :available, type: BTG
        element_group :used, type: BTG
        element_group :overdrive, type: BTG
        element_group :Timestamp, type: Timestamp
        element :duedate
      end

      class HISALSv7 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISLASv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParSammelLast, type: ParSammelLast
      end

      class HISLASv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParSammelLast, type: ParSammelLast
      end

      class HISLASv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParSammelLast, type: ParSammelLast
      end

      class HISLASv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSammelLast, type: ParSammelLast
      end

      class HISUBSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParSammelUeb, type: ParSammelUeb
      end

      class HISUBSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParSammelUeb, type: ParSammelUeb
      end

      class HISUBSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParSammelUeb, type: ParSammelUeb
      end

      class HISUBSv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSammelUeb, type: ParSammelUeb
      end

      class HIDTESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSammelUeb, type: ParSammelUeb
      end

      class HICCMSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSammelUebSEPA, type: ParSammelUebSEPA
      end

      class HIDMEv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDMESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSammelLastSEPA, type: ParSammelLastSEPA
      end

      class HIDMCv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDMCSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSammelLastCOR1SEPA, type: ParSammelLastCOR1SEPA
      end

      class HIBMEv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIBMESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSammelLastB2BSEPA, type: ParSammelLastB2BSEPA
      end

      class HISPAv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :Acc, type: KTVZVInt
      end

      class HISPASv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParSEPAInfo, type: ParSEPAInfo
      end

      class HIPROv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :MsgRef, type: MsgRef
        element :segref
        element :date
        element :time
        element_group :RetVal, type: RetVal
      end

      class HIPROSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIPROv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :MsgRef, type: MsgRef
        element :segref
        element :date
        element :time
        element_group :RetVal, type: RetVal
      end

      class HIPROSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIPROv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :MsgRef, type: MsgRef
        element :segref
        element :date
        element :time
        element_group :RetVal, type: RetVal
      end

      class HIPROSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITANv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element_group :ChallengeValidity, type: ChallengeValidity
        element :listidx
        element :info
      end

      class HITANSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTAN2Step, type: ParTAN2Step1
      end

      class HITANv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element_group :ChallengeValidity, type: ChallengeValidity
        element :listidx
        element :ben
      end

      class HITANSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTAN2Step, type: ParTAN2Step2
      end

      class HITANv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element_group :ChallengeValidity, type: ChallengeValidity
        element :listidx
        element :ben
        element :tanmedia
      end

      class HITANSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTAN2Step, type: ParTAN2Step3
      end

      class HITANv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element :challenge_hhd_uc
        element_group :ChallengeValidity, type: ChallengeValidity
        element :listidx
        element :ben
        element :tanmedia
      end

      class HITANSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTAN2Step, type: ParTAN2Step4
      end

      class HITANv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element :challenge_hhd_uc
        element_group :ChallengeValidity, type: ChallengeValidity
        element :listidx
        element :ben
        element :tanmedia
      end

      class HITANSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTAN2Step, type: ParTAN2Step5
      end

      class HITABv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :tanoption
        element_group :MediaInfo, type: TANMediaInfo1
      end

      class HITABSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITABv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :tanoption
        element_group :MediaInfo, type: TANMediaInfo2
      end

      class HITABSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITABv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :tanoption
        element_group :MediaInfo, type: TANMediaInfo3
      end

      class HITABSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITABv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :tanoption
        element_group :MediaInfo, type: TANMediaInfo4
      end

      class HITABSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITAZv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :liststatus
        element :listnumber
        element :date
        element :noftansperlist
        element :nofusedtansperlist
        element_group :TANInfo, type: TANInfo
      end

      class HITAZSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISLEv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HISLESv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermSammelLast, type: ParTermSammelLast
      end

      class HISLLSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISLBv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element_group :My, type: KTV3
        element :senddate
        element :execdate
        element :ordercount
        element_group :sum, type: BTG
      end

      class HISLBSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermSammelLastList, type: ParTermSammelLastList
      end

      class HITSEv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HITSESv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermSammelUeb, type: ParTermSammelUeb
      end

      class HITSLSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITSBv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element_group :My, type: KTV3
        element :senddate
        element :execdate
        element :ordercount
        element_group :sum, type: BTG
      end

      class HITSBSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermSammelUebList, type: ParTermSammelUebList
      end

      class HITUEv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HITUESv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermUeb, type: ParTermUeb
      end

      class HITUEv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HITUESv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermUeb, type: ParTermUeb
      end

      class HITUEv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HITUESv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermUeb, type: ParTermUeb
      end

      class HITULSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HITULSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HITULSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITUAv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HITUASv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermUebEdit, type: ParTermUebEdit
      end

      class HITUAv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HITUASv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermUebEdit, type: ParTermUebEdit
      end

      class HITUAv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HITUASv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermUebEdit, type: ParTermUebEdit
      end

      class HITUBv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTO
        element_group :Other, type: KTO
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage1
        element :date
        element :id
      end

      class HITUBSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermUebList, type: ParTermUebList
      end

      class HITUBv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV2
        element_group :Other, type: KTV2
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage3
        element :date
        element :id
      end

      class HITUBSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParTermUebList, type: ParTermUebList
      end

      class HITUBv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV3
        element_group :Other, type: KTV3
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage3
        element :date
        element :id
        element :status
      end

      class HITUBSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermUebList, type: ParTermUebList
      end

      class HIUEBSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParUeb, type: ParUeb
      end

      class HIUEBSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParUeb, type: ParUeb
      end

      class HIUEBSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParUeb, type: ParUeb
      end

      class HIUEBSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParUeb, type: ParUeb
      end

      class HIEILSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParUeb, type: ParUeb
      end

      class HIAOMSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParUebForeign, type: ParUebForeign
      end

      class HIAOMSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParUebForeign, type: ParUebForeign
      end

      class HIGUBv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTV3
        element :myname
        element :myname2
        element_group :Other, type: KTV3
        element :name
        element :name2
        element_group :BTG, type: BTG
        element :key
        element :addkey
        element_group :usage, type: usage3
        element_group :Timestamp, type: Timestamp
      end

      class HIGUBSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParUeb, type: ParUeb
      end

      class HICCSSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HICUMSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParUmbSepa, type: ParUmbSepa
      end

      class HIDSEv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDSESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermSepaEinzelLast, type: ParTermSepaEinzelLast
      end

      class HIDSCv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIDSCSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermSepaCOR1, type: ParTermSepaCOR1
      end

      class HIBSEv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HIBSESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermSepaB2B, type: ParTermSepaB2B
      end

      class HICSEv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HICSESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermUebSEPA, type: ParTermUebSEPA
      end

      class HICSBv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTVInt
        element :sepadescr
        element :sepapain
        element :orderid
        element :candel
        element :canchange
      end

      class HICSBSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermUebSEPAList, type: ParTermUebSEPAList
      end

      class HICSLSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermUebSEPADel, type: ParTermUebSEPADel
      end

      class HICSAv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HICSASv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParTermUebSEPAEdit, type: ParTermUebSEPAEdit
      end

      class HICDEv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
      end

      class HICDESv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParDauerSEPANew, type: ParDauerSEPANew
      end

      class HICDNv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :orderid
        element :orderidold
      end

      class HICDNSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParDauerSEPAEdit, type: ParDauerSEPAEdit
      end

      class HICDLSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParDauerSEPADel, type: ParDauerSEPADel
      end

      class HICDBv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :My, type: KTVInt
        element :sepadescr
        element :sepapain
        element :orderid
        element_group :DauerDetails, type: DauerDetails
        element_group :Aussetzung, type: Aussetzung3
        element :canchange
        element :canskip
        element :candel
      end

      class HICDBSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element :maxentries_allowed
      end

      class HIUMBSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParUmb, type: ParUmb
      end

      class HIUMBSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParUmb, type: ParUmb
      end

      class HIVMKv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :mt942
      end

      class HIVMKSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParVormerkposten, type: ParVormerkposten
      end

      class HIWPDv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data571
      end

      class HIWPDSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotList, type: ParWPDepotList1
      end

      class HIWPDv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data535
      end

      class HIWPDSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotList, type: ParWPDepotList1
      end

      class HIWPDv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data571
      end

      class HIWPDSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotList, type: ParWPDepotList2
      end

      class HIWPDv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data535
      end

      class HIWPDSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotList, type: ParWPDepotList2
      end

      class HIWPDv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data535
      end

      class HIWPDSv6 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParWPDepotList, type: ParWPDepotList2
      end

      class HIWDUv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data572
      end

      class HIWDUSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotUms, type: ParWPDepotUms
      end

      class HIWDUv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data536
      end

      class HIWDUSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotUms, type: ParWPDepotUms
      end

      class HIWDUv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data572
      end

      class HIWDUSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotUms, type: ParWPDepotUms
      end

      class HIWDUv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data536
      end

      class HIWDUSv4 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPDepotUms, type: ParWPDepotUms
      end

      class HIWDUv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :data536
      end

      class HIWDUSv5 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParWPDepotUms, type: ParWPDepotUms
      end

      class HIWPIv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :info
        element :grformat
        element :grafik
        element :weblink
      end

      class HIWPISv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIWPIv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :info
        element :grformat
        element :grafik
        element :weblink
      end

      class HIWPISv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPInfoList, type: ParWPInfoList
      end

      class HIWPIv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :info
        element :grformat
        element :grafik
        element :weblink
      end

      class HIWPISv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParWPInfoList, type: ParWPInfoList
      end

      class HIWPKv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element_group :WPKursData, type: WPKursData
      end

      class HIWPKSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPKursList, type: ParWPKursList1
      end

      class HIWPKv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :boerse
        element :WPKursData.notizeinheit
        element :WPKursData.zeitbezug
        element :umsatz
        element_group :WPKursData.Kassakurs, type: WPBKurs
        element_group :WPKursData.Vorboerse, type: WPBKurs
        element_group :WPKursData.Openkurs, type: WPBKurs
        element_group :WPKursData.Lastkurs, type: WPBKurs
        element_group :WPKursData.Nachboerse, type: WPBKurs
        element_group :WPKursData.Prevdaykurs, type: WPBKurs
        element_group :WPKursData.Annmax, type: WPBKurs
        element_group :WPKursData.Annmin, type: WPBKurs
        element_group :WPKursData.Outputprice, type: WPBKurs
        element_group :WPKursData.Retprice, type: WPBKurs
      end

      class HIWPKSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPKursList, type: ParWPKursList2
      end

      class HIWPKv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :boerse
        element :WPKursData.notizeinheit
        element :WPKursData.zeitbezug
        element :umsatz
        element_group :WPKursData.Kassakurs, type: WPBKurs
        element_group :WPKursData.Vorboerse, type: WPBKurs
        element_group :WPKursData.Openkurs, type: WPBKurs
        element_group :WPKursData.Lastkurs, type: WPBKurs
        element_group :WPKursData.Nachboerse, type: WPBKurs
        element_group :WPKursData.Prevdaykurs, type: WPBKurs
        element_group :WPKursData.Annmax, type: WPBKurs
        element_group :WPKursData.Annmin, type: WPBKurs
        element_group :WPKursData.Outputprice, type: WPBKurs
        element_group :WPKursData.Retprice, type: WPBKurs
      end

      class HIWPKSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParWPKursList, type: ParWPKursList2
      end

      class HIWPRv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :name
        element :stammavail
        element :kursavail
        element :infoavail
        element_group :WPRef, type: WPRef
      end

      class HIWPRSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPRefList, type: ParWPRefList
      end

      class HIWPRv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :name
        element :stammavail
        element :kursavail
        element :infoavail
        element_group :WPRef, type: WPRef
      end

      class HIWPRSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPRefList, type: ParWPRefList
      end

      class HIWPRv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :name
        element :stammavail
        element :kursavail
        element :infoavail
        element_group :WPRef, type: WPRef
      end

      class HIWPRSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParWPRefList, type: ParWPRefList
      end

      class HIWSDv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :longname
        element :type
        element :region
        element :boerse
        element :depotcurr
        element :WPStammRenten.zinssatz
        element :notizeinheit
        element :canorder
        element_group :WPStammAktien.nennwert, type: BTG
        element :WPStammRenten.emissdate
        element_group :WPZinsTermine, type: WPZinsTermine
        element :WPStammAktien.kapitalchange
        element_group :WPStammAktien.kapitalchangevalue, type: BTG
        element_group :WPStammAktieb.dividende, type: BTG
        element :faelligkeit
        element :WPStammAktien.hvtermin
        element_group :retprice, type: BTG
        element :verlosung
        element :lossize
        element :emittent
        element :type
        element :group
        element :info
        element_group :WPBInfo, type: WPBInfo1
      end

      class HIWSDSv1 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
      end

      class HIWSDv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :notizeinheit
        element :kategorie
        element :type
        element :group
        element :typedescr
        element :depotcurr
        element :endcurr
        element :canorder
        element :risiko
        element :emittent
        element :info
        element_group :WPStammAktien, type: WPStammAktien
        element_group :WPStammRenten, type: WPStammRenten
        element_group :WPStammFonds, type: WPStammFonds
        element_group :WPStammOptions, type: WPStammOptions
        element_group :WPBInfo, type: WPBInfo2
      end

      class HIWSDSv2 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element_group :ParWPStammList, type: ParWPStammList
      end

      class HIWSDv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element_group :WPRef, type: WPRef
        element :name
        element :notizeinheit
        element :kategorie
        element :type
        element :group
        element :typedescr
        element :depotcurr
        element :endcurr
        element :canorder
        element :risiko
        element :emittent
        element :info
        element_group :WPStammAktien, type: WPStammAktien
        element_group :WPStammRenten, type: WPStammRenten
        element_group :WPStammFonds, type: WPStammFonds
        element_group :WPStammOptions, type: WPStammOptions
        element_group :WPBInfo, type: WPBInfo2
      end

      class HIWSDSv3 < Segment
        element_group :SegHead, type: SegHeadInst
        element :maxnum
        element :minsigs
        element :secclass
        element_group :ParWPStammList, type: ParWPStammList
      end

    end
  end
end
