require 'spec_helper_hbci_ng'

describe HbciNg::SegmentSchema do
  class Test
    include HbciNg::SegmentSchema

    add('Test-ID')

    add('Schlüsselname') do |eg|
      eg.add('Kreditinstitutskennung') do |eg_sub|
        eg_sub.add('Länderkennzeichen')
        eg_sub.add('Kreditinstitutscode ')
      end
    end
  end

  context 'with element' do
    it 'returns schema' do
      expect(Test.find_by_name('Test-ID')).to be_a(HbciNg::ElementSchema)
      expect(Test.find_by_name('Test-ID').index).to be_eql(1)
    end
  end

  context 'with element group' do
    it 'returns schema' do
      expect(Test.find_by_name('Segmentkopf')).to be_a(HbciNg::ElementGroupSchema)
      expect(Test.find_by_name('Segmentkopf').index).to be_eql(0)
      expect(Test.find_by_name('Segmentkopf').find_by_name('Segmentkennung').index).to be_eql(0)
      expect(Test.find_by_name('Segmentkopf').find_by_name('Segmentnummer').index).to be_eql(1)
      expect(Test.find_by_name('Segmentkopf').find_by_name('Segmentversion').index).to be_eql(2)
      expect(Test.find_by_name('Segmentkopf').find_by_name('Bezugssegment').index).to be_eql(3)
    end
  end

  context 'with nested element group' do
    it 'returns element schema' do
      expect(Test.find_by_name('Schlüsselname')).to be_a(HbciNg::ElementGroupSchema)
      expect(Test.find_by_name('Schlüsselname').index).to eql(2)
      expect(Test.find_by_name('Schlüsselname').find_by_name('Kreditinstitutskennung')).to be_a(HbciNg::ElementGroupSchema)
      expect(Test.find_by_name('Schlüsselname').find_by_name('Kreditinstitutskennung').index).to eql(0)
    end
  end
end
