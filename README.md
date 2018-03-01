# OSO-gegevensset

Beschrijving en technische bestanden van de Edustandaard afspraak Overstap Service Onderwijs (OSO). Deze afspraak wordt beheerd en gepubliceerd door Edustandaard op: https://www.edustandaard.nl/standaard_afspraken/oso-gegevensset-en-profielen-oso/. 

De OSO afspraak gaat over de inhoud van over te dragen leerlingdossiers. Specifiek voor de overdracht bij de overstap van leerlingen tussen twee scholen en/of ter voorbereiding op de ondersteuningsaanvraag bij het Samenwerkingsverband.

Deze GitHub repository is aanvullend op de publicatie van de afspraak op de Edustandaard website en is in eerste instantie bedoeld om partijen die aansluiten op de OSO keten te ondersteunen. Via de repository kunnen ontwikkelaars op een vaste locatie de laatste versie van de ‘technische bestanden’ ophalen en de wijzigingen met vorige versie(s) inzien.

## Indeling repository

Deze git repository is iets anders gestructureerd dan de technische bestanden (ZIPs) die op de Edustandaard website gedownload kunnen worden op  https://www.edustandaard.nl/standaard_werkgroepen/werkgroep-oso-gegevensset/

De **common/** directory bevat bestanden die zowel voor de ‘OV’ als de ‘PaO’ overdracht nodig zijn. Deze bestanden worden vanuit de desbetreffende directories (OV en PaO) gelinkt (symlinks).

De **OV/** directory bevat de bestanden die nodig zijn bij het implementeren van de ‘normale’ OSO overdracht (POPO, POVO, VOVO, binnenBRIN).

De **PaO/** directory bevat de bestanden die nodig zijn bij het implementeren van de overdracht in het kader van Passend Onderwijs (PaO).

### NB1: Codelijsten

De Excel codelijsten en de OSO landelijke tabellen overheid zijn niet aanwezig in deze repository.

### NB2: Symlinks op Windows

Om de symlinks werkend te krijgen dient op Windows de git clone commando met een extra parameter uitgevoerd te worden:

```
git clone -c core.symlinks=true <url>
```
