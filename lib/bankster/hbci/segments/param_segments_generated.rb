module Bankster
  module Hbci
    module Segments
      class HIBPAv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :version
        element_group :kik, type: ElementGroups::KIK
        element :kiname
        element :numgva
        element_group :supp_langs, type: ElementGroups::SuppLangs
        element_group :supp_versions, type: ElementGroups::SuppVersions
        element :maxmsgsize
        element :timeout_min
        element :timeout_max
      end

      class HIKPVv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        9.times do |i|
          element_group "supp_comp_methods_#{i}".to_sym, type: ElementGroups::SuppCompMethods
        end
      end

      class HISSPv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :msgtype
        element :dialogidref
        element :msgnumref
        element :func
        element_group :key_name, type: ElementGroups::KeyName
        element :locktype
        element_group :sec_timestamp, type: ElementGroups::SecTimestamp
        element_group :cert, type: ElementGroups::Cert
      end

      class HIKIMv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :betreff
        element :text
      end

      class HIUPDv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV2
        element :customerid
        element :acctype
        element :cur
        element :name1
        element :name2
        element :konto
        element_group :k_limit, type: ElementGroups::KLimit
        999.times do |i|
          element_group "allowed_gv_#{i}".to_sym, type: ElementGroups::AllowedGV
        end
      end

      class HIUPDv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV2
        element :iban
        element :customerid
        element :acctype
        element :cur
        element :name1
        element :name2
        element :konto
        element_group :k_limit, type: ElementGroups::KLimit
        999.times do |i|
          element_group "allowed_gv_#{i}".to_sym, type: ElementGroups::AllowedGV
        end
        element :accountdata
      end

      class HIRMGv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        99.times do |i|
          element_group "ret_val_#{i}".to_sym, type: ElementGroups::RetVal
        end
      end

      class HIRMSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        99.times do |i|
          element_group "ret_val_#{i}".to_sym, type: ElementGroups::RetVal
        end
      end

      class HISHVv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :mixing
        9.times do |i|
          element_group "supp_sec_methods_#{i}".to_sym, type: ElementGroups::SuppSecMethods
        end
      end

      class HIISAv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :type
        element :dialogid
        element :msgnum
        element :func
        element_group :key_name, type: ElementGroups::KeyName
        element_group :pub_key, type: ElementGroups::PubKey
        element_group :cert, type: ElementGroups::Cert
      end

      class HISYNv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :sysid
        element :msgnum
        element :sigid
      end

      class HISYNv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :sysid
        element :msgnum
        element :sigid
        element :sigid2
      end

      class HIUPAv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :userid
        element :version
        element :usage
      end

      class HIUPAv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :userid
        element :version
        element :usage
        element :username
      end

      class HIUPAv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :userid
        element :version
        element :usage
        element :username
        element :userdata
      end

      class HIKIFv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV2
        element :acctype
        element :name
        element :name2
        element :accbez
        element :curr
        element :opendate
        element :sollzins
        element :habenzins
        element :overdrivezins
        element_group :kredit, type: ElementGroups::BTG
        element_group :refkto, type: ElementGroups::KTV2
        element_group :address, type: ElementGroups::Address2
        element :versandart
        element :turnus
        element :info
        9.times do |i|
          element_group "berechtigter_#{i}".to_sym, type: ElementGroups::Berechtigter1
        end
      end

      class HIKIFSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIKIFv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV3
        element :acctype
        element :name
        element :name2
        element :accbez
        element :curr
        element :opendate
        element :sollzins
        element :habenzins
        element :overdrivezins
        element_group :kredit, type: ElementGroups::BTG
        element_group :refkto, type: ElementGroups::KTV3
        element_group :address, type: ElementGroups::Address2
        element :versandart
        element :turnus
        element :info
        9.times do |i|
          element_group "berechtigter_#{i}".to_sym, type: ElementGroups::Berechtigter2
        end
      end

      class HIKIFSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIAZKv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :cardtype
        element :cardnumber
        element :nextcardnumber
        element :name
        element :validfrom
        element :validuntil
        element_group :cardlimit, type: ElementGroups::BTG
        element :comment
      end

      class HIAZKSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIAZKv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :cardtype
        element :cardbez
        element :cardnumber
        element :nextcardnumber
        element :name
        element :validfrom
        element :validuntil
        element_group :cardlimit, type: ElementGroups::BTG
        element :comment
      end

      class HIAZKSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIPAESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIKOMv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :kik, type: ElementGroups::KIK
        element :deflang
        9.times do |i|
          element_group "comm_param_#{i}".to_sym, type: ElementGroups::CommParam
        end
      end

      class HIKOMSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIKOMv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :kik, type: ElementGroups::KIK
        element :deflang
        9.times do |i|
          element_group "comm_param_#{i}".to_sym, type: ElementGroups::CommParam
        end
      end

      class HIKOMSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIKOMv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :kik, type: ElementGroups::KIK
        element :deflang
        9.times do |i|
          element_group "comm_param_#{i}".to_sym, type: ElementGroups::CommParam
        end
      end

      class HIKOMSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIKDMSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_custom_msg, type: ElementGroups::ParCustomMsg
      end

      class HIKDMSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_custom_msg, type: ElementGroups::ParCustomMsg
      end

      class HIKDMSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_custom_msg, type: ElementGroups::ParCustomMsg
      end

      class HIKDMSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_custom_msg, type: ElementGroups::ParCustomMsg
      end

      class HIDALSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_del, type: ElementGroups::ParDauerDel
      end

      class HIDALSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_del, type: ElementGroups::ParDauerDel
      end

      class HIDALSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_del, type: ElementGroups::ParDauerDel
      end

      class HIDALSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_dauer_del, type: ElementGroups::ParDauerDel
      end

      class HIDANv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HIDANSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_edit, type: ElementGroups::ParDauerEdit
      end

      class HIDANv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HIDANSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_edit, type: ElementGroups::ParDauerEdit
      end

      class HIDANv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HIDANSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_edit, type: ElementGroups::ParDauerEdit
      end

      class HIDANv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HIDANSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_dauer_edit, type: ElementGroups::ParDauerEdit
      end

      class HIDABv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTO
        element_group :other, type: ElementGroups::KTO
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage1
        element :date
        element :orderid
        element_group :dauer_details, type: ElementGroups::DauerDetails
        element_group :aussetzung, type: ElementGroups::Aussetzung1
      end

      class HIDABSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIDABv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTO
        element_group :other, type: ElementGroups::KTO
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage2
        element :date
        element :orderid
        element_group :dauer_details, type: ElementGroups::DauerDetails
        element_group :aussetzung, type: ElementGroups::Aussetzung2
      end

      class HIDABSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIDABv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV2
        element_group :other, type: ElementGroups::KTV2
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage3
        element :date
        element :orderid
        element_group :dauer_details, type: ElementGroups::DauerDetails
        element_group :aussetzung, type: ElementGroups::Aussetzung2
      end

      class HIDABSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIDABv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV3
        element_group :other, type: ElementGroups::KTV3
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage3
        element :date
        element :orderid
        element_group :dauer_details, type: ElementGroups::DauerDetails
        element_group :aussetzung, type: ElementGroups::Aussetzung3
      end

      class HIDABSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIDABv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV3
        element_group :other, type: ElementGroups::KTV3
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage3
        element :date
        element :orderid
        element_group :dauer_details, type: ElementGroups::DauerDetails
        element_group :aussetzung, type: ElementGroups::Aussetzung3
        element :canchange
        element :canskip
        element :candel
      end

      class HIDABSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIDAEv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDAESv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_new, type: ElementGroups::ParDauerNew
      end

      class HIDAEv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDAESv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_new, type: ElementGroups::ParDauerNew
      end

      class HIDAEv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDAESv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_dauer_new, type: ElementGroups::ParDauerNew
      end

      class HIDAEv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDAESv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_dauer_new, type: ElementGroups::ParDauerNew
      end

      class HIFGKv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :fest_cond_version, type: ElementGroups::FestCondVersion
        99.times do |i|
          element_group "fest_cond_#{i}".to_sym, type: ElementGroups::FestCond1
        end
      end

      class HIFGKSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_fest_cond_list, type: ElementGroups::ParFestCondList
      end

      class HIFGKv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :fest_cond_version, type: ElementGroups::FestCondVersion
        99.times do |i|
          element_group "fest_cond_#{i}".to_sym, type: ElementGroups::FestCond1
        end
      end

      class HIFGKSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_fest_cond_list, type: ElementGroups::ParFestCondList
      end

      class HIFGKv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :fest_cond_version, type: ElementGroups::FestCondVersion
        99.times do |i|
          element_group "fest_cond_#{i}".to_sym, type: ElementGroups::FestCond2
        end
      end

      class HIFGKSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_fest_cond_list, type: ElementGroups::ParFestCondList
      end

      class HIFGBv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :anlagekto, type: ElementGroups::KTO
        element :kontakt
        element_group :anlagebetrag, type: ElementGroups::BTG
        element_group :fest_cond, type: ElementGroups::FestCond1
        element_group :belastungskto, type: ElementGroups::KTO
        element :eigenerechnung
        element :wiederanlage
        element :kontoauszug
        element_group :ausbuchungskto, type: ElementGroups::KTO
        element_group :zinskto, type: ElementGroups::KTO
        element_group :fest_cond_version, type: ElementGroups::FestCondVersion
        element_group :zinsbetrag, type: ElementGroups::BTG
        element :status
        element_group :prolong, type: ElementGroups::Prolong
      end

      class HIFGBSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIFGBv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :anlagekto, type: ElementGroups::KTV2
        element :kontakt
        element_group :anlagebetrag, type: ElementGroups::BTG
        element_group :fest_cond, type: ElementGroups::FestCond1
        element_group :belastungskto, type: ElementGroups::KTV2
        element :eigenerechnung
        element :wiederanlage
        element :kontoauszug
        element_group :ausbuchungskto, type: ElementGroups::KTV2
        element_group :zinskto, type: ElementGroups::KTV2
        element_group :fest_cond_version, type: ElementGroups::FestCondVersion
        element_group :zinsbetrag, type: ElementGroups::BTG
        element :status
        element_group :prolong, type: ElementGroups::Prolong
      end

      class HIFGBSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIFGBv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :anlagekto, type: ElementGroups::KTV3
        element :kontakt
        element_group :anlagebetrag, type: ElementGroups::BTG
        element_group :fest_cond, type: ElementGroups::FestCond2
        element_group :belastungskto, type: ElementGroups::KTV3
        element :eigenerechnung
        element :wiederanlage
        element :kontoauszug
        element_group :ausbuchungskto, type: ElementGroups::KTV3
        element_group :zinskto, type: ElementGroups::KTV3
        element_group :fest_cond_version, type: ElementGroups::FestCondVersion
        element_group :zinsbetrag, type: ElementGroups::BTG
        element :status
        element_group :prolong, type: ElementGroups::Prolong
      end

      class HIFGBSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIFGNv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTO
        element :kontakt
      end

      class HIFGNSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_fest_new, type: ElementGroups::ParFestNew1
      end

      class HIFGNv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV2
        element :kontakt
      end

      class HIFGNSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_fest_new, type: ElementGroups::ParFestNew2
      end

      class HIFGNv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV3
        element :kontakt
      end

      class HIFGNSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_fest_new, type: ElementGroups::ParFestNew2
      end

      class HIINFSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIINFv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "info_#{i}".to_sym, type: ElementGroups::Info
        end
      end

      class HIINFSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIINFv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "info_#{i}".to_sym, type: ElementGroups::Info
        end
      end

      class HIINFSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIINFv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "info_#{i}".to_sym, type: ElementGroups::Info
        end
      end

      class HIINFSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIKIAv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "info_info_#{i}".to_sym, type: ElementGroups::InfoInfo
        end
      end

      class HIKIASv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIKIAv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "info_info_#{i}".to_sym, type: ElementGroups::InfoInfo
        end
      end

      class HIKIASv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIKIAv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "info_info_#{i}".to_sym, type: ElementGroups::InfoInfo
        end
      end

      class HIKIASv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIKIAv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "info_info_#{i}".to_sym, type: ElementGroups::InfoInfo
        end
      end

      class HIKIASv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HIEKAv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :format
        element_group :time_range, type: ElementGroups::TimeRange
        element :booked
        element :abschlussinfo
        element :kondinfo
        element :ads
        element :receipt
      end

      class HIEKASv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_kontoauszug, type: ElementGroups::ParKontoauszug
      end

      class HIEKAv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :format
        element_group :time_range, type: ElementGroups::TimeRange
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
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_kontoauszug, type: ElementGroups::ParKontoauszug
      end

      class HIEKAv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :format
        element_group :time_range, type: ElementGroups::TimeRange
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
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_kontoauszug, type: ElementGroups::ParKontoauszug
      end

      class HIEKAv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :format
        element_group :time_range, type: ElementGroups::TimeRange
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
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_kontoauszug, type: ElementGroups::ParKontoauszug
      end

      class HIKANv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKANSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_k_ums_new, type: ElementGroups::ParKUmsNew1
      end

      class HIKANv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKANSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_k_ums_new, type: ElementGroups::ParKUmsNew2
      end

      class HIKANv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKANSv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_k_ums_new, type: ElementGroups::ParKUmsNew2
      end

      class HIKANv7 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKANSv7 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_k_ums_new_sepa, type: ElementGroups::ParKUmsNew2
      end

      class HIKAZv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKAZSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_k_ums_zeit, type: ElementGroups::ParKUmsZeit1
      end

      class HIKAZv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKAZSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_k_ums_zeit, type: ElementGroups::ParKUmsZeit2
      end

      class HIKAZv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKAZSv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_k_ums_zeit, type: ElementGroups::ParKUmsZeit2
      end

      class HIKAZv7 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :booked
        element :notbooked
      end

      class HIKAZSv7 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_k_ums_zeit_sepa, type: ElementGroups::ParKUmsZeit2
      end

      class HILASSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_last, type: ElementGroups::ParLast
      end

      class HILASSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_last, type: ElementGroups::ParLast
      end

      class HILASSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_last, type: ElementGroups::ParLast
      end

      class HILASSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_last, type: ElementGroups::ParLast
      end

      class HILSWSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_last_objection, type: ElementGroups::ParLastObjection
      end

      class HILSWSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_last_objection, type: ElementGroups::ParLastObjection
      end

      class HIAUEv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV3
        element_group :other, type: ElementGroups::KTV3
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage3
        element :date
        element :id
        element :status
      end

      class HIAUESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_order_history, type: ElementGroups::ParOrderHistory
      end

      class HIPINSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_pin_tan, type: ElementGroups::ParPinTan2
      end

      class HISALv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTO
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo
        element_group :pending, type: ElementGroups::Saldo
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
      end

      class HISALSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HISALv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTO
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo
        element_group :pending, type: ElementGroups::Saldo
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element :timestamp_date
        element :timestamp_time
      end

      class HISALSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HISALv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV2
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo
        element_group :pending, type: ElementGroups::Saldo
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element :timestamp_date
        element :timestamp_time
        element :duedate
      end

      class HISALSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HISALv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV3
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo2
        element_group :pending, type: ElementGroups::Saldo2
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element_group :overdrive, type: ElementGroups::BTG
        element_group :timestamp, type: ElementGroups::Timestamp
        element :duedate
      end

      class HISALSv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISALv7 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTVInt
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo2
        element_group :pending, type: ElementGroups::Saldo2
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element_group :overdrive, type: ElementGroups::BTG
        element_group :timestamp, type: ElementGroups::Timestamp
        element :duedate
      end

      class HISALSv7 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISLASv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_sammel_last, type: ElementGroups::ParSammelLast
      end

      class HISLASv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_sammel_last, type: ElementGroups::ParSammelLast
      end

      class HISLASv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_sammel_last, type: ElementGroups::ParSammelLast
      end

      class HISLASv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sammel_last, type: ElementGroups::ParSammelLast
      end

      class HISUBSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_sammel_ueb, type: ElementGroups::ParSammelUeb
      end

      class HISUBSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_sammel_ueb, type: ElementGroups::ParSammelUeb
      end

      class HISUBSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_sammel_ueb, type: ElementGroups::ParSammelUeb
      end

      class HISUBSv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sammel_ueb, type: ElementGroups::ParSammelUeb
      end

      class HIDTESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sammel_ueb, type: ElementGroups::ParSammelUeb
      end

      class HICCMSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sammel_ueb_sepa, type: ElementGroups::ParSammelUebSEPA
      end

      class HIDMEv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDMESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sammel_last_sepa, type: ElementGroups::ParSammelLastSEPA
      end

      class HIDMCv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDMCSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sammel_last_cor1_sepa, type: ElementGroups::ParSammelLastCOR1SEPA
      end

      class HIBMEv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIBMESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sammel_last_b2_bsepa, type: ElementGroups::ParSammelLastB2BSEPA
      end

      class HISPAv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        999.times do |i|
          element_group "acc_#{i}".to_sym, type: ElementGroups::KTVZVInt
        end
      end

      class HISPASv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_sepa_info, type: ElementGroups::ParSEPAInfo
      end

      class HIPROv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :msg_ref, type: ElementGroups::MsgRef
        element :segref
        element :date
        element :time
        element_group :ret_val, type: ElementGroups::RetVal
      end

      class HIPROSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIPROv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :msg_ref, type: ElementGroups::MsgRef
        element :segref
        element :date
        element :time
        element_group :ret_val, type: ElementGroups::RetVal
      end

      class HIPROSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIPROv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :msg_ref, type: ElementGroups::MsgRef
        element :segref
        element :date
        element :time
        element_group :ret_val, type: ElementGroups::RetVal
      end

      class HIPROSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITANv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element_group :challenge_validity, type: ElementGroups::ChallengeValidity
        element :listidx
        element :info
      end

      class HITANSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_tan2_step, type: ElementGroups::ParTAN2Step1
      end

      class HITANv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element_group :challenge_validity, type: ElementGroups::ChallengeValidity
        element :listidx
        element :ben
      end

      class HITANSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_tan2_step, type: ElementGroups::ParTAN2Step2
      end

      class HITANv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element_group :challenge_validity, type: ElementGroups::ChallengeValidity
        element :listidx
        element :ben
        element :tanmedia
      end

      class HITANSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_tan2_step, type: ElementGroups::ParTAN2Step3
      end

      class HITANv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element :challenge_hhd_uc
        element_group :challenge_validity, type: ElementGroups::ChallengeValidity
        element :listidx
        element :ben
        element :tanmedia
      end

      class HITANSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_tan2_step, type: ElementGroups::ParTAN2Step4
      end

      class HITANv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :process
        element :orderhash
        element :orderref
        element :challenge
        element :challenge_hhd_uc
        element_group :challenge_validity, type: ElementGroups::ChallengeValidity
        element :listidx
        element :ben
        element :tanmedia
      end

      class HITANSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_tan2_step, type: ElementGroups::ParTAN2Step5
      end

      class HITABv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :tanoption
        999.times do |i|
          element_group "media_info_#{i}".to_sym, type: ElementGroups::TANMediaInfo1
        end
      end

      class HITABSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITABv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :tanoption
        999.times do |i|
          element_group "media_info_#{i}".to_sym, type: ElementGroups::TANMediaInfo2
        end
      end

      class HITABSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITABv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :tanoption
        999.times do |i|
          element_group "media_info_#{i}".to_sym, type: ElementGroups::TANMediaInfo3
        end
      end

      class HITABSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITABv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :tanoption
        999.times do |i|
          element_group "media_info_#{i}".to_sym, type: ElementGroups::TANMediaInfo4
        end
      end

      class HITABSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITAZv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :liststatus
        element :listnumber
        element :date
        element :noftansperlist
        element :nofusedtansperlist
        999.times do |i|
          element_group "tan_info_#{i}".to_sym, type: ElementGroups::TANInfo
        end
      end

      class HITAZSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISLEv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HISLESv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_sammel_last, type: ElementGroups::ParTermSammelLast
      end

      class HISLLSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HISLBv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element_group :my, type: ElementGroups::KTV3
        element :senddate
        element :execdate
        element :ordercount
        element_group :sum, type: ElementGroups::BTG
      end

      class HISLBSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_sammel_last_list, type: ElementGroups::ParTermSammelLastList
      end

      class HITSEv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HITSESv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_sammel_ueb, type: ElementGroups::ParTermSammelUeb
      end

      class HITSLSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITSBv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element_group :my, type: ElementGroups::KTV3
        element :senddate
        element :execdate
        element :ordercount
        element_group :sum, type: ElementGroups::BTG
      end

      class HITSBSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_sammel_ueb_list, type: ElementGroups::ParTermSammelUebList
      end

      class HITUEv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HITUESv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_ueb, type: ElementGroups::ParTermUeb
      end

      class HITUEv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HITUESv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_ueb, type: ElementGroups::ParTermUeb
      end

      class HITUEv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HITUESv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_ueb, type: ElementGroups::ParTermUeb
      end

      class HITULSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HITULSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HITULSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HITUAv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HITUASv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_ueb_edit, type: ElementGroups::ParTermUebEdit
      end

      class HITUAv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HITUASv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_ueb_edit, type: ElementGroups::ParTermUebEdit
      end

      class HITUAv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HITUASv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_ueb_edit, type: ElementGroups::ParTermUebEdit
      end

      class HITUBv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTO
        element_group :other, type: ElementGroups::KTO
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage1
        element :date
        element :id
      end

      class HITUBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_ueb_list, type: ElementGroups::ParTermUebList
      end

      class HITUBv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV2
        element_group :other, type: ElementGroups::KTV2
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage3
        element :date
        element :id
      end

      class HITUBSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_term_ueb_list, type: ElementGroups::ParTermUebList
      end

      class HITUBv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV3
        element_group :other, type: ElementGroups::KTV3
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage3
        element :date
        element :id
        element :status
      end

      class HITUBSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_ueb_list, type: ElementGroups::ParTermUebList
      end

      class HIUEBSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_ueb, type: ElementGroups::ParUeb
      end

      class HIUEBSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_ueb, type: ElementGroups::ParUeb
      end

      class HIUEBSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_ueb, type: ElementGroups::ParUeb
      end

      class HIUEBSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_ueb, type: ElementGroups::ParUeb
      end

      class HIEILSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_ueb, type: ElementGroups::ParUeb
      end

      class HIAOMSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_ueb_foreign, type: ElementGroups::ParUebForeign
      end

      class HIAOMSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_ueb_foreign, type: ElementGroups::ParUebForeign
      end

      class HIGUBv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTV3
        element :myname
        element :myname2
        element_group :other, type: ElementGroups::KTV3
        element :name
        element :name2
        element_group :btg, type: ElementGroups::BTG
        element :key
        element :addkey
        element_group :usage, type: ElementGroups::Usage3
        element_group :timestamp, type: ElementGroups::Timestamp
      end

      class HIGUBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_ueb, type: ElementGroups::ParUeb
      end

      class HICCSSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
      end

      class HICUMSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_umb_sepa, type: ElementGroups::ParUmbSepa
      end

      class HIDSEv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDSESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_sepa_einzel_last, type: ElementGroups::ParTermSepaEinzelLast
      end

      class HIDSCv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIDSCSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_sepa_cor1, type: ElementGroups::ParTermSepaCOR1
      end

      class HIBSEv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HIBSESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_sepa_b2_b, type: ElementGroups::ParTermSepaB2B
      end

      class HICSEv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HICSESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_ueb_sepa, type: ElementGroups::ParTermUebSEPA
      end

      class HICSBv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTVInt
        element :sepadescr
        element :sepapain
        element :orderid
        element :candel
        element :canchange
      end

      class HICSBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_ueb_sepa_list, type: ElementGroups::ParTermUebSEPAList
      end

      class HICSLSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_ueb_sepa_del, type: ElementGroups::ParTermUebSEPADel
      end

      class HICSAv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HICSASv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_term_ueb_sepa_edit, type: ElementGroups::ParTermUebSEPAEdit
      end

      class HICDEv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
      end

      class HICDESv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_dauer_sepa_new, type: ElementGroups::ParDauerSEPANew
      end

      class HICDNv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :orderid
        element :orderidold
      end

      class HICDNSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_dauer_sepa_edit, type: ElementGroups::ParDauerSEPAEdit
      end

      class HICDLSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_dauer_sepa_del, type: ElementGroups::ParDauerSEPADel
      end

      class HICDBv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :my, type: ElementGroups::KTVInt
        element :sepadescr
        element :sepapain
        element :orderid
        element_group :dauer_details, type: ElementGroups::DauerDetails
        element_group :aussetzung, type: ElementGroups::Aussetzung3
        element :canchange
        element :canskip
        element :candel
      end

      class HICDBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element :maxentries_allowed
      end

      class HIUMBSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_umb, type: ElementGroups::ParUmb
      end

      class HIUMBSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_umb, type: ElementGroups::ParUmb
      end

      class HIVMKv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :mt942
      end

      class HIVMKSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_vormerkposten, type: ElementGroups::ParVormerkposten
      end

      class HIWPDv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data571
      end

      class HIWPDSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_list, type: ElementGroups::ParWPDepotList1
      end

      class HIWPDv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data535
      end

      class HIWPDSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_list, type: ElementGroups::ParWPDepotList1
      end

      class HIWPDv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data571
      end

      class HIWPDSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_list, type: ElementGroups::ParWPDepotList2
      end

      class HIWPDv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data535
      end

      class HIWPDSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_list, type: ElementGroups::ParWPDepotList2
      end

      class HIWPDv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data535
      end

      class HIWPDSv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_wp_depot_list, type: ElementGroups::ParWPDepotList2
      end

      class HIWDUv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data572
      end

      class HIWDUSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_ums, type: ElementGroups::ParWPDepotUms
      end

      class HIWDUv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data536
      end

      class HIWDUSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_ums, type: ElementGroups::ParWPDepotUms
      end

      class HIWDUv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data572
      end

      class HIWDUSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_ums, type: ElementGroups::ParWPDepotUms
      end

      class HIWDUv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data536
      end

      class HIWDUSv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_depot_ums, type: ElementGroups::ParWPDepotUms
      end

      class HIWDUv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :data536
      end

      class HIWDUSv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_wp_depot_ums, type: ElementGroups::ParWPDepotUms
      end

      class HIWPIv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
        element :name
        element :info
        element :grformat
        element :grafik
        element :weblink
      end

      class HIWPISv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIWPIv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
        element :name
        element :info
        element :grformat
        element :grafik
        element :weblink
      end

      class HIWPISv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_info_list, type: ElementGroups::ParWPInfoList
      end

      class HIWPIv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
        element :name
        element :info
        element :grformat
        element :grafik
        element :weblink
      end

      class HIWPISv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_wp_info_list, type: ElementGroups::ParWPInfoList
      end

      class HIWPKv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
        99.times do |i|
          element_group "wp_kurs_data_#{i}".to_sym, type: ElementGroups::WPKursData
        end
      end

      class HIWPKSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_kurs_list, type: ElementGroups::ParWPKursList1
      end

      class HIWPKv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
        element :name
        element :boerse
        element :wp_kurs_data_notizeinheit
        element :wp_kurs_data_zeitbezug
        element :umsatz
        element_group :wp_kurs_data_kassakurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_vorboerse, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_openkurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_lastkurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_nachboerse, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_prevdaykurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_annmax, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_annmin, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_outputprice, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_retprice, type: ElementGroups::WPBKurs
      end

      class HIWPKSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_kurs_list, type: ElementGroups::ParWPKursList2
      end

      class HIWPKv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
        element :name
        element :boerse
        element :wp_kurs_data_notizeinheit
        element :wp_kurs_data_zeitbezug
        element :umsatz
        element_group :wp_kurs_data_kassakurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_vorboerse, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_openkurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_lastkurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_nachboerse, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_prevdaykurs, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_annmax, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_annmin, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_outputprice, type: ElementGroups::WPBKurs
        element_group :wp_kurs_data_retprice, type: ElementGroups::WPBKurs
      end

      class HIWPKSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_wp_kurs_list, type: ElementGroups::ParWPKursList2
      end

      class HIWPRv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :name
        element :stammavail
        element :kursavail
        element :infoavail
        9.times do |i|
          element_group "wp_ref_#{i}".to_sym, type: ElementGroups::WPRef
        end
      end

      class HIWPRSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_ref_list, type: ElementGroups::ParWPRefList
      end

      class HIWPRv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :name
        element :stammavail
        element :kursavail
        element :infoavail
        9.times do |i|
          element_group "wp_ref_#{i}".to_sym, type: ElementGroups::WPRef
        end
      end

      class HIWPRSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_ref_list, type: ElementGroups::ParWPRefList
      end

      class HIWPRv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :name
        element :stammavail
        element :kursavail
        element :infoavail
        9.times do |i|
          element_group "wp_ref_#{i}".to_sym, type: ElementGroups::WPRef
        end
      end

      class HIWPRSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_wp_ref_list, type: ElementGroups::ParWPRefList
      end

      class HIWSDv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
        element :name
        element :longname
        element :type
        element :region
        element :boerse
        element :depotcurr
        element :wp_stamm_renten_zinssatz
        element :notizeinheit
        element :canorder
        element_group :wp_stamm_aktien_nennwert, type: ElementGroups::BTG
        element :wp_stamm_renten_emissdate
        element_group :wp_zins_termine, type: ElementGroups::WPZinsTermine
        element :wp_stamm_aktien_kapitalchange
        element_group :wp_stamm_aktien_kapitalchangevalue, type: ElementGroups::BTG
        element_group :wp_stamm_aktieb_dividende, type: ElementGroups::BTG
        element :faelligkeit
        element :wp_stamm_aktien_hvtermin
        element_group :retprice, type: ElementGroups::BTG
        element :verlosung
        element :lossize
        element :emittent
        element :type
        element :group
        element :info
        99.times do |i|
          element_group "wpb_info_#{i}".to_sym, type: ElementGroups::WPBInfo1
        end
      end

      class HIWSDSv1 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
      end

      class HIWSDv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
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
        element_group :wp_stamm_aktien, type: ElementGroups::WPStammAktien
        element_group :wp_stamm_renten, type: ElementGroups::WPStammRenten
        element_group :wp_stamm_fonds, type: ElementGroups::WPStammFonds
        element_group :wp_stamm_options, type: ElementGroups::WPStammOptions
        99.times do |i|
          element_group "wpb_info_#{i}".to_sym, type: ElementGroups::WPBInfo2
        end
      end

      class HIWSDSv2 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element_group :par_wp_stamm_list, type: ElementGroups::ParWPStammList
      end

      class HIWSDv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :wp_ref, type: ElementGroups::WPRef
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
        element_group :wp_stamm_aktien, type: ElementGroups::WPStammAktien
        element_group :wp_stamm_renten, type: ElementGroups::WPStammRenten
        element_group :wp_stamm_fonds, type: ElementGroups::WPStammFonds
        element_group :wp_stamm_options, type: ElementGroups::WPStammOptions
        99.times do |i|
          element_group "wpb_info_#{i}".to_sym, type: ElementGroups::WPBInfo2
        end
      end

      class HIWSDSv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element :maxnum
        element :minsigs
        element :secclass
        element_group :par_wp_stamm_list, type: ElementGroups::ParWPStammList
      end

    end
  end
end
