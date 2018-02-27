# oso-gegevensset
Data van de OSO gegevensset gepubliceerd door Edustandaard.

Deze git repository is iets anders gestructureerd dan de technische bestanden (ZIPs) die op de Edustandaard website gedownload 
kunnen worden. https://www.edustandaard.nl/standaard_werkgroepen/werkgroep-oso-gegevensset/

De **common/** directory bevat bestanden die per bundel (OV en PaO) gelinkt worden (symlinks).

De Excel codelijsten en OSO landelijke tabellen overheid zijn niet aanwezig in deze repository.


## Symlinks op Windows

Om de symlinks werkend te krijgen dient op Windows de git clone commando met een extra parameter uitgevoerd te worden:

```
git clone -c core.symlinks=true <url>
```
