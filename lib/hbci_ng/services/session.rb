# "HNHBK:1:3+000000000372+300+0+1'HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'HNVSD:999:1+@213@HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'HKIDN:3:2+280:74090000+186486386+0+1'HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'HKSYN:5:3+0'HNSHA:6:2+3999997++463083''HNHBS:7:1+1'"
# request = <<~HBCI
#     HNHBK:1:3+000000000372+300+0+1'
#     HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'
#     HNVSD:999:1+@213@
#       HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
#       HKIDN:3:2+280:74090000+186486386+0+1'
#       HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
#       HKSYN:5:3+0'
#       HNSHA:6:2+3999997++463083'
#     '
#     HNHBS:7:1+1'
# HBCI

# HNHBK:1:3+000000000380+300+0+1'
# HNVSK:998:3+PIN:1+998+1+1::0+1:20191014:161022+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'
# HNVSD:999:1+@215@
#   HNSHK:2:4+PIN:1+999+22999978+1+1+1::0+2+1:20191014:161022+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
#   HKIDN:3:2+280:74090000+186486386+0+1'
#   HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
#   HKSYN:5:3+0'
#   HNSHA:6:2+22999978++463083'
# '
# HNHBS:7:1+1'

module HbciNg
  module Services
    class Session
      def initialize(connector)
        @now = Time.now
        @connector = connector
        @security_reference = generate_security_reference.to_s
      end

      def perform
        Hbci.logger.info('Start initiating FinTS/HBCI session')

        response = Hbci::Response.new(@connector.post(hbci_message, false))
        puts response.to_s

        Hbci.logger.info('Finish initiating FinTS/HBCI session')
      end

      def hbci_message_template
        hbci_message_template = <<~HBCI
          HNHBK:1:3+?Nachrichtengröße?+300+?Dialog-ID?+1'
          HNVSK:998:3+PIN:1+998+1+1::0+1:?Datum?:?Uhrzeit?+2:2:13:@5@NOKEY:5:1+280:?Kreditinstitutscode?:?Benutzerkennung?:V:1:1+0'
          HNVSD:999:1+@213@
            HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
            HKIDN:3:2+280:74090000+186486386+0+1'
            HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
            HKSYN:5:3+0'
            HNSHA:6:2+3999997++111111'
          '
          HNHBS:7:1+1'
        HBCI
        hbci_message_template
      end

      def hbci_message
        hbci_message = Message.new(hbci_message_template)

        # Verschlüsselungskopf
        hnvsk = hbci_message.segments('HNVSK').first
        hnvsk.find_by_index(5).find_by_index(1).value = @now.strftime('%Y%m%d')
        hnvsk.find_by_index(5).find_by_index(2).value = @now.strftime('%H%m%S')
        hnvsk.find_by_index(7).find_by_index(1).value = @connector.credentials.bank_code
        hnvsk.find_by_index(7).find_by_index(2).value = @connector.credentials.user_id

        # Verschlüsselte Daten
        hnvsd = hbci_message.segments('HNVSD').first
        hnvsd_content = HbciNg::Message.new(hnvsd.find_by_index(1).value)

        # Signaturkopf
        hnshk = hnvsd_content.segments('HNSHK').first
        hnshk.find_by_index(3).value = @security_reference
        hnshk.find_by_index(8).find_by_index(1).value = @now.strftime('%Y%m%d')
        hnshk.find_by_index(8).find_by_index(2).value = @now.strftime('%H%m%S')
        hnshk.find_by_index(11).find_by_index(1).value = @connector.credentials.bank_code
        hnshk.find_by_index(11).find_by_index(2).value = @connector.credentials.user_id

        # Identifikation
        hkidn = hnvsd_content.segments('HKIDN').first
        hkidn.find_by_index(1).find_by_index(1).value = @connector.credentials.bank_code
        hkidn.find_by_index(2).value = @connector.credentials.user_id

        # Signaturabschluss
        hnsha = hnvsd_content.segments('HNSHA').first
        hnsha.find_by_index(1).value = @security_reference
        hnsha.find_by_index(3).value = @connector.credentials.pin

        # Set Verschlüsselte Daten
        hnvsd.find_by_index(1).value = hnvsd_content.to_hbci

        # Nachrichtenkopf
        hnhbk = hbci_message.segments('HNHBK').first
        hnhbk.find_by_index(3).value = '0'
        hnhbk.find_by_index(1).value = hbci_message.to_hbci.size.to_s.rjust(12, '0')

        hbci_message
      end

      private

      def generate_security_reference
        rand(1..23) * 999_999 + 1_000_000
      end
    end
  end
end
