module HbciNg
  module Segments
    class HNVSKv3
      include SegmentSchema

      add('Sicherheitsprofil') do |eg|
        eg.add('Sicherheitsverfahren, Code')
        eg.add('Version des Sicherheitsverfahrens')
      end

      add('Sicherheitsfunktion, kodiert')
      add('Rolle des Sicherheitslieferanten, kodiert')

      add('Sicherheitsidentifikation, Details') do |eg|
        eg.add('Bezeichner für Sicherheitspartei')
        eg.add('CID')
        eg.add('Identifizierung der Partei')
      end

      add('Sicherheitsdatum und -uhrzeit') do |eg|
        eg.add('Datum- und Zeitbezeichner, kodiert')
        eg.add('Datum')
        eg.add('Uhrzeit')
      end

      add('Verschlüsselungsalgorithmus') do |eg|
        eg.add('Verwendung des Verschlüsselungsalgorithmus, kodiert')
        eg.add('Operationsmodus, kodiert')
        eg.add('Verschlüsselungsalgorithmus, kodiert')
        eg.add('Wert des Algorithmusparameters, Schlüssel')
        eg.add('Bezeichner für Algorithmusparameter, Schlüssel')
        eg.add('Bezeichner für Algorithmusparameter, IV')
        eg.add('Wert des Algorithmusparameters, IV')
      end

      add('Schlüsselname') do |eg|
        eg.add('Kreditinstitutskennung') do |eg_sub|
          eg_sub.add('Länderkennzeichen')
          eg_sub.add('Kreditinstitutscode')
        end
        eg.add('Benutzerkennung')
        eg.add('Schlüsselart')
        eg.add('Schlüsselnummer')
        eg.add('5 Schlüsselversion ')
      end

      add('Komprimierungsfunktion')

      add('Zertifikat') do |eg|
        eg.add('Zertifikatstyp')
        eg.add('Zertifikatsinhalt')
      end
    end
  end
end
