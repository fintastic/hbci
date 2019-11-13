# frozen_string_literal: true

require 'spec_helper_hbci_ng'

describe HbciNg::Message do
  describe '#to_hbci' do
    let(:sample) do
      sample = <<~HBCI
        HNHBK:1:3+000000000372+300+0+1'
        HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'
        HNVSD:999:1+@213@
          HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
          HKIDN:3:2+280:74090000+186486386+0+1'
          HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
          HKSYN:5:3+0'
          HNSHA:6:2+3999997++111111'
        '
        HNHBS:7:1+1'
      HBCI
      sample.delete("\n").delete("\s")
    end

    before do
      subject.fill(sample)
    end

    it { expect(subject.to_hbci).to eql(sample) }

    describe 'change data' do
      let(:expected_sample) do
        sample = <<~HBCI
          HNHBK:111:3+000000000372+300+0+1'
          HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'
          HNVSD:999:1+@216@
            HNSHK:2:4+SECRET:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
            HKIDN:3:2+280:74090000+186486386+0+1'
            HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
            HKSYN:5:3+0'
            HNSHA:6:2+3999997++111111'
          '
          HNHBS:7:1+1'
        HBCI
        sample.delete("\n").delete("\s")
      end

      before do
        subject.segment(0).find_by_index(0).find_by_index(1).value = '111'

        hnvsd = subject.segment(2)
        bin_data = hnvsd.find_by_index(1).value

        hbci_message = HbciNg::Message.new(bin_data)
        hbci_message.segment(0).find_by_index(1).find_by_index(0).value = 'SECRET'

        hnvsd.find_by_index(1).value = hbci_message.to_hbci
      end

      it { expect(subject.to_hbci).to eql(expected_sample) }
    end
  end
end
