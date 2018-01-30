<?xml version="1.0" encoding="UTF-8"?>
<!--Overzicht van wijzigingen -->
<!-- 20170308: Eerste officiele release voor Validatie van OSO Gegevensset versie 2017.1, inclusief wijzigingen:
				Validatie toegevoegd dat bij selectief uitleveren in het geval van OPT-UIT ook werkelijk alle gegevens uit deze categorie ontbreken 
				Validatie van codelijsten aangepast: codelijsten 16 (soort overstap/dossier), 29 (soort overdracht)
				Validatie van codelijst 48 toegevoegd (voor alle velden binnen blok categorie_uitlevering) -->
<!-- 20161128: Validatie van codelijsten 42 t/m 47 m.b.t. eindtoets toegevoegd -->
<!-- 20160120: Wijzigingen n.a.v. nieuwe versie 2016.1: 
				Validatie van codelijsten aangepast: 4 & 23 gewijzigd; 39 & 40 verwijderd en 41 toegevoegd -->
<!-- 20151119: Validatie van code Nvt van codelijst 39 toegevoegd -->
<!-- 20150716: Validatie van code NAZ van codelijst 11 en Nvt van codelijst 31 toegevoegd -->
<!-- 20150529: Validatie van code LA van codelijst 11 toegevoegd -->
<!-- 20150218: validatie van waarde van gegevensveld "profiel" met codelijst 21 code "ondersteuning" toegevoegd -->
<!-- 20150216: validatie van waarde van gegevensveld "toestemming" met codelijst 37, "soort_arrangement" met codelijst 39 en "niveau_eindtoets" met codelijst 40 toegevoegd -->
<!-- 20140519: validatie van 4 velden met codelijst (akkoord, lgfindicatierec, rvcindicatie, examenuitslag en beoordelingexamenvak) toegevoegd, na verwijdering uit XSD -->
<!-- 20140509: validatie van veel gegevensvelden met codelijsten (enumeraties) toegevoegd, na verwijdering uit XSD -->
<!--           validatie van veld Herzien VO advies (herzienadvies) toegevoegd -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:od="http://www.edustandaard.nl/oso_gegevensset/2017/dossier" xmlns="http://www.edustandaard.nl/oso_gegevensset/2017/schemas/Meldingen" exclude-result-prefixes="xs" version="2.0" extension-element-prefixes="od">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <meldingen>
      <!-- ______________________________________________________________ -->
      <!--                 Validatie van codelijsten                      -->
      <!-- ______________________________________________________________ -->
      <!-- 20140509: CONTROLE VAN CODELIJSTEN 
				2. Advies vo, 
				3. LGF onderwijssoort, 
				4. Communicatie soort, 5. Communicatie aanduiding, 
				6. Voorschoolse toeleider, 7. Voorschoolse historie, 8. Voorschoolse deelname, 9. VVE programma
				10. NNCA, 11. Referentiescore, 12. Domeinen, 13. Jaargroepen, 14. Geslacht, 15. Gewicht,
				16. Soort overstap, 
				17. RVC indicattie,
				18. Huisnummer aanduiding, 19. Soort adres, 
				21. Profiel, 22. Vergelijkingsgroep, 23. Diagnose, 
				29. Overdrachtsoort, 
				31. TLV, 32. UPW en 33. Deeldossiertype 
				34. UPW leerjaar, 35. Examenuitslag, 36. Beoordelingexamenvak, 37. Akkoord, 38. LGF indicatie voor REC
				[39. Soort arrangement,] [40. Niveau eindtoets,] 41. Relatie tot kind
				42 t/m 47 m.b.t. eindtoets basisonderwijs
			-->
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van velden m.b.t. VO advies (school, ouders, leerling & herzien) conform codelijst 2. Advies VO -->
      <xsl:for-each select="/descendant::*/od:overstapadvies/od:advies">
        <xsl:if test="not(text()='01') and not(text()='10') and      not(text()='20') and not(text()='21') and not(text()='22') and not(text()='23') and      not(text()='30') and not(text()='31') and not(text()='32') and not(text()='33') and not(text()='34') and not(text()='35') and      not(text()='40') and not(text()='41') and not(text()='42') and not(text()='43') and not(text()='44') and       not(text()='50') and not(text()='51') and not(text()='52') and       not(text()='60') and not(text()='61') and not(text()='70') and not(text()='80')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'VO advies volgens school' bevat een waarde die niet voorkomt in in codelijst 2.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="/descendant::*/od:overstapadvies/od:wensouders">
        <xsl:if test="not(text()='01') and not(text()='10') and      not(text()='20') and not(text()='21') and not(text()='22') and not(text()='23') and      not(text()='30') and not(text()='31') and not(text()='32') and not(text()='33') and not(text()='34') and not(text()='35') and      not(text()='40') and not(text()='41') and not(text()='42') and not(text()='43') and not(text()='44') and       not(text()='50') and not(text()='51') and not(text()='52') and       not(text()='60') and not(text()='61') and not(text()='70') and not(text()='80')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'VO advies volgens ouders' bevat een waarde die niet voorkomt in in codelijst 2.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="/descendant::*/od:overstapadvies/od:wensleerling">
        <xsl:if test="not(text()='01') and not(text()='10') and      not(text()='20') and not(text()='21') and not(text()='22') and not(text()='23') and      not(text()='30') and not(text()='31') and not(text()='32') and not(text()='33') and not(text()='34') and not(text()='35') and      not(text()='40') and not(text()='41') and not(text()='42') and not(text()='43') and not(text()='44') and       not(text()='50') and not(text()='51') and not(text()='52') and       not(text()='60') and not(text()='61') and not(text()='70') and not(text()='80')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'VO advies volgens leerling' bevat een waarde die niet voorkomt in in codelijst 2.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="/descendant::*/od:overstapadvies/od:herzienadvies">
        <xsl:if test="not(text()='01') and not(text()='10') and      not(text()='20') and not(text()='21') and not(text()='22') and not(text()='23') and      not(text()='30') and not(text()='31') and not(text()='32') and not(text()='33') and not(text()='34') and not(text()='35') and      not(text()='40') and not(text()='41') and not(text()='42') and not(text()='43') and not(text()='44') and       not(text()='50') and not(text()='51') and not(text()='52') and       not(text()='60') and not(text()='61') and not(text()='70') and not(text()='80')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Herzien VO advies' bevat een waarde die niet voorkomt in in codelijst 2.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld codelgfonderwijssoort conform codelijst 3. LGF onderwijssoort -->
      <xsl:for-each select="/descendant::*/od:lgf/od:codelgfonderwijssoort">
        <xsl:if test="not(text()='11') and not(text()='12') and not(text()='13') and not(text()='14') and      not(text()='21') and not(text()='22') and not(text()='23') and not(text()='24') and not(text()='25') and not(text()='26') and      not(text()='31') and not(text()='32') and not(text()='33') and not(text()='34') and not(text()='35') and      not(text()='40') and not(text()='44')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'LGF onderwijssoort' bevat een waarde die niet voorkomt in in codelijst 3.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld communicatie.soort conform codelijst 4. Communicatie soort -->
      <!-- 20160120: validatie van de waarden "mobiel" en "fax" verwijderd -->
      <xsl:for-each select="/descendant::*/od:communicatie/od:soort">
        <xsl:if test="not(text()='e-mail') and not(text()='telefoon')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Communicatie soort' bevat een waarde die niet voorkomt in codelijst 4.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld communicatie.aanduiding conform codelijst 5. Communicatie aanduiding -->
      <xsl:for-each select="/descendant::*/od:communicatie/od:aanduiding">
        <xsl:if test="not(text()='werk') and not(text()='prive') and not(text()='overig')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Communicatie aanduiding' bevat een waarde die niet voorkomt in codelijst 5.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld codevoorschoolsetoeleider conform codelijst 6. Voorschoolse toeleider -->
      <xsl:for-each select="/descendant::*/od:voorschools/od:codevoorschoolsetoeleider">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5') and not(text()='6') and not(text()='7') and not(text()='8') and not(text()='9')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Voorschoolse toeleider' bevat een waarde die niet voorkomt in codelijst 6.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld codevoorschoolsehistorie conform codelijst 7. Voorschoolse historie -->
      <xsl:for-each select="/descendant::*/od:voorschools/od:codevoorschoolsehistorie">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Voorschoolse historie' bevat een waarde die niet voorkomt in codelijst 7.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld codevoorschoolsedeelname conform codelijst 8. Voorschoolse deelname -->
      <xsl:for-each select="/descendant::*/od:voorschools/od:codevoorschoolsedeelname">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Voorschoolse deelname' bevat een waarde die niet voorkomt in codelijst 8.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld codevoorschoolsprogramma conform codelijst 9. VVE programma -->
      <xsl:for-each select="/descendant::*/od:voorschools/od:codevoorschoolsprogramma">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5') and not(text()='6')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Voorschoolse programma' bevat een waarde die niet voorkomt in codelijst 9.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="/descendant::*/od:vroegschools/od:codevroegschoolsprogramma">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5') and not(text()='6')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Vroegschoolse programma' bevat een waarde die niet voorkomt in codelijst 9.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld nnca conform codelijst 10. NNCA -->
      <xsl:for-each select="/descendant::*/od:nnca">
        <xsl:if test="not(text()='0') and not(text()='1') and not(text()='2')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'NNCA' bevat een waarde die niet voorkomt in codelijst 10.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld codereferentiescore conform codelijst 11. Referentiescore-->
      <!-- 20150716 Validatie van code NAZ toegevoegd -->
      <!-- 20150529 Validatie van code LA toegevoegd -->
      <xsl:for-each select="/descendant::*/od:referentiescore/od:codereferentiescore">
        <xsl:if test="not(text()='AE') and not(text()='CAE') and not(text()='IV') and not(text()='CIV') and not(text()='FN') and not(text()='ON') and      not(text()='DLE') and not(text()='Percentiel') and not(text()='Percentage') and not(text()='T-score') and not(text()='Stanine') and      not(text()='DQ') and not(text()='IQ') and not(text()='ERK') and not(text()='C-score') and not(text()='Norm') and not(text()='RNTRM') and       not(text()='ZML')and not(text()='LGH') and not(text()='AVI') and not(text()='NAZ') and not(text()='LM') and not(text()='Standaardscore') and not(text()='LA')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Code van referentiescore' bevat een waarde die niet voorkomt in codelijst 11.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld domein conform codelijst 12. Domeinen -->
      <xsl:for-each select="/descendant::*/od:extrahulpingroep78/od:domein">
        <xsl:if test="not(text()='TL') and not(text()='BL') and not(text()='SP') and not(text()='RW') and       not(text()='ST') and not(text()='MT') and       not(text()='BO') and not(text()='SV') and       not(text()='WO') and not(text()='EN') and not(text()='CV') and       not(text()='LCC') and not(text()='LNK') and not(text()='LZS') and not(text()='LTP')and not(text()='LZV') and not(text()='LDV') and not(text()='LWV') and not(text()='LHW')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Hulpdomeinen' bevat een waarde die niet voorkomt in codelijst 12.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld jaargroep (4x binnen schoolloopbaan, toetsresultaat en cijferlijst) conform codelijst 13. Jaargroepen-->
      <xsl:for-each select="/descendant::*/od:jaargroep">
        <xsl:if test="not(text()='0') and       not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5') and not(text()='6') and not(text()='7') and not(text()='8') and       not(text()='11') and not(text()='12') and not(text()='13') and not(text()='14') and not(text()='15') and not(text()='16') and       not(text()='S') and not(text()='P')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Leerjaar' bevat een waarde die niet voorkomt in codelijst 13.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld geslacht conform codelijst 14. Geslacht -->
      <xsl:for-each select="/descendant::*/od:geslacht">
        <xsl:if test="not(text()='0') and not(text()='1') and not(text()='2')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Geslacht' bevat een waarde die niet voorkomt in codelijst 14.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld leerlinggewicht conform codelijst 15. Gewicht -->
      <xsl:for-each select="/descendant::*/od:leerlinggewicht">
        <xsl:if test="not(text()='0.00') and not(text()='0.30') and not(text()='1.20')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Leerlinggewicht' bevat een waarde die niet voorkomt in codelijst 15.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld dossier.metadata.overstap conform codelijst 16. Soort overstap/dossier -->
      <!-- 20170308: Validatie uitgebreid met codes "POSWV" en "VOSWV" -->
      <xsl:for-each select="/descendant::*/od:metadata/od:overstap">
        <xsl:if test="not(text()='VSPO') and not(text()='VSWEC') and not(text()='POPO') and not(text()='POWEC') and      not(text()='POVO') and not(text()='VOVO') and not(text()='VOMBO') and not(text()='VOHBO') and      not(text()='VOWO') and not(text()='WECWEC') and not(text()='WECVO') and not(text()='WECMBO') and      not(text()='POSWV') and not(text()='VOSWV') and      not(text()='WECHBO') and not(text()='WECWO') and not(text()='OVERIG')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Soort overstap' bevat een waarde die niet voorkomt in codelijst 16.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld RVC indicatie conform codelijst 17. RVC indicatie -->
      <xsl:for-each select="/descendant::*/od:rvc/od:rvcindicatie">
        <xsl:if test="not(text()='LWOO') and not(text()='PRO')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'RVC indicatie' bevat een waarde die niet voorkomt in codelijst 17.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld soortadres conform codelijst 18. Huisnummer aanduiding -->
      <xsl:for-each select="/descendant::*/od:adres/od:aanduiding">
        <xsl:if test="not(text()='TO') and not(text()='BY')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Huisnummer aanduiding' bevat een waarde die niet voorkomt in codelijst 18.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld soortadres conform codelijst 19. Soort adres -->
      <xsl:for-each select="/descendant::*/od:adres/od:soortadres">
        <xsl:if test="not(text()='bezoek') and not(text()='post') and not(text()='gba')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Soort adres' bevat een waarde die niet voorkomt in codelijst 19.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld profiel conform codelijst 21. Profiel -->
      <!-- 20150218: validatie van waarde van gegevensveld "profiel" met codelijst 21 code "ondersteuning" toegevoegd -->
      <xsl:for-each select="/descendant::*/od:overstapadvies/od:profiel">
        <xsl:if test="not(text()='basis') and not(text()='plus') and not(text()='bespreek') and not(text()='disharmonisch') and not(text()='ondersteuning')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Profiel' binnen overstapadvies bevat een waarde die niet voorkomt in codelijst 21.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld codevergelijkingsgroep conform codelijst 22. Vergelijkingsgroep -->
      <xsl:for-each select="/descendant::*/od:referentiescore/od:codevergelijkingsgroep">
        <xsl:if test="not(text()='BB+') and not(text()='BB') and not(text()='KB') and not(text()='GT') and       not(text()='HAVO') and not(text()='VWO') and not(text()='Landelijk')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Code van vergelijkingsgroep' bevat een waarde die niet voorkomt in codelijst 22.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld diagnose.code conform codelijst 23. Diagnose codes -->
      <!-- 20160120: validatie van de waarden "H54.0" tot en met "H91.9.s" toegevoegd -->
      <xsl:for-each select="/descendant::*/od:diagnose/od:code">
        <xsl:if test="not(text()='F81.0') and not(text()='F81.1') and not(text()='F81.2') and not(text()='F82') and      not(text()='F84') and not(text()='F84.0') and not(text()='F84.2') and not(text()='F84.5') and not(text()='F84.nld') and not(text()='F84.mcdd') and       not(text()='F90') and not(text()='F90.0') and not(text()='F90.0+') and not(text()='F90.0-') and not(text()='F91') and not(text()='F91.3') and       not(text()='F95') and not(text()='F95.2') and      not(text()='F41.0') and not(text()='F43.1') and not(text()='F50') and not(text()='F92.0') and not(text()='F93.1') and not(text()='F94') and       not(text()='Fspd') and not(text()='G40') and       not(text()='H54.0') and not(text()='H54.2') and not(text()='H91.9.d') and not(text()='H91.9.s') and       not(text()='Z62')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Code van diagnose' bevat een waarde die niet voorkomt in codelijst 23.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld overdrachtsoort conform codelijst 29. Overdrachtsoort -->
      <!-- 20170308: Validatie uitgebreid met code "swv-dossier" -->
      <xsl:for-each select="/descendant::*/od:overdrachtsoort">
        <xsl:if test="not(text()='overstapdossier') and not(text()='overdrachtbinnenbrin') and not(text()='swv-dossier')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Soort overdracht' bevat een waarde die niet voorkomt in codelijst 29.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld tlvcategorie conform codelijst 31. TLV bekostigingscategorie -->
      <!-- 20150716 Validatie van code Nvt toegevoegd -->
      <xsl:for-each select="/descendant::*/od:tlv/od:tlvcategorie">
        <xsl:if test="not(text()='H') and not(text()='M') and not(text()='L') and not(text()='Nvt')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'TLV bekostigingscategorie' bevat een waarde die niet voorkomt in codelijst 31.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld upwuitstroomprofiel conform codelijst 32. UPW uitstroomprofiel -->
      <xsl:for-each select="/descendant::*/od:upw/od:upwuitstroomprofiel">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'UPW uitstroomprofiel' bevat een waarde die niet voorkomt in codelijst 32.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld metadata.deeldossier conform 33. Deeldossier type -->
      <!--<xsl:for-each select="/descendant::*/od:metadata/od:deeldossier">
				<xsl:if test="not(text()='LAS') and not(text()='LVS') and not(text()='LASLVS') and not(text()='TIB')">
					<xsl:call-template name="melding">
						<xsl:with-param name="tekst">Het veld 'Deeldossier type' binnen metadata bevat een waarde die niet voorkomt in codelijst 33.</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>-->
      <xsl:if test="not(//od:metadata/od:deeldossier/text()='LAS') and not(//od:metadata/od:deeldossier/text()='LVS') and not(//od:metadata/od:deeldossier/text()='LASLVS') and not(//od:metadata/od:deeldossier/text()='TIB')">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Het veld 'Deeldossier type' binnen metadata bevat een waarde die niet voorkomt in codelijst 33.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld upwleerjaar conform codelijst 34. UPW leerjaar -->
      <xsl:for-each select="/descendant::*/od:upw/od:upwleerjaar">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5') and not(text()='6')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'UPW leerjaar' bevat een waarde die niet voorkomt in codelijst 34.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld examenuitslag conform codelijst 35. Examenuitslag -->
      <xsl:for-each select="/descendant::*/od:examenresultaat/od:examenuitslag">
        <xsl:if test="not(text()='geslaagd') and not(text()='afgewezen') and not(text()='herexamen')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Examenuitslag' bevat een waarde die niet voorkomt in codelijst 35.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld beoordelingexamenvak conform codelijst 36. Beoordelingexamenvak -->
      <xsl:for-each select="/descendant::*/od:resultaatvakkenvo/od:beoordelingexamenvak">
        <xsl:if test="not(text()='voldoende') and not(text()='onvoldoende')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Beoordeling van examenvak' bevat een waarde die niet voorkomt in codelijst 36.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld akkoord conform codelijst 37. Akkoord -->
      <xsl:for-each select="/descendant::*/od:inzage/od:akkoord">
        <xsl:if test="not(text()='Ja') and not(text()='Nee') and not(text()='Onbekend')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Akkoord' bevat een waarde die niet voorkomt in codelijst 37.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="/descendant::*/od:inzage/od:toestemming">
        <xsl:if test="not(text()='Ja') and not(text()='Nee') and not(text()='Onbekend')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Toestemming' bevat een waarde die niet voorkomt in codelijst 37.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld lgfindicatierec conform codelijst 38. LGF indicatie voor REC -->
      <xsl:for-each select="/descendant::*/od:lgf/od:lgfindicatierec">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'LGF indicatie voor REC' bevat een waarde die niet voorkomt in codelijst 38.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld soort_arrangement conform codelijst 39. Soort arrangement -->
      <!-- 20160120: veld "soort_arrangement" verwijderd, dus ook deze codelijst validatie -->
      <!-- 20151119: Validatie van code Nvt toegevoegd -->
      <!-- 20150216: Validatie van deze codelijst toegevoegd -->
      <!--<xsl:for-each select="/descendant::*/od:arrangement/od:soort_arrangement">
				<xsl:if test="not(text()='1') and not(text()='2') and not(text()='Nvt')">
					<xsl:call-template name="melding">
						<xsl:with-param name="tekst">Het veld 'Soort arrangement' bevat een waarde die niet voorkomt in codelijst 39.</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>-->
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld niveau_eindtoets conform codelijst 40. Niveau van eindtoets -->
      <!-- 20160120: veld "niveau_eindtoets" verwijderd, dus ook deze codelijst validatie -->
      <!-- 20150216: Validatie van deze codelijst toegevoegd -->
      <!--<xsl:for-each select="/descendant::*/od:niveau_eindtoets">
				<xsl:if test="not(text()='Standaard') and not(text()='Basis') and not(text()='Niveau')">
					<xsl:call-template name="melding">
						<xsl:with-param name="tekst">Het veld 'Niveau van eindtoets' bevat een waarde die niet voorkomt in codelijst 40.</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>-->
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld relatietotkind conform codelijst 41. Relatie tot kind -->
      <!-- 20160120: Validatie van deze codelijst toegevoegd -->
      <xsl:for-each select="/descendant::*/od:verzorger/od:relatietotkind">
        <xsl:if test="not(text()='1') and not(text()='2') and not(text()='3') and not(text()='4') and not(text()='5') and       not(text()='6') and not(text()='7') and not(text()='8') and not(text()='9')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Relatie tot kind' binnen het blok 'Verzorger' bevat een waarde die niet voorkomt in codelijst 41.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld <toetssoort> binnen <eindtoets_basisonderwijs> conform codelijst 42. Soort eindtoets -->
      <!-- 20161128: Validatie van deze codelijst toegevoegd -->
      <xsl:for-each select="/descendant::*/od:eindtoets_basisonderwijs/od:eindtoetsresultaat/od:toetssoort">
        <xsl:if test="not(text()='0011') and not(text()='0012') and not(text()='0013') and not(text()='0014') and not(text()='0015') and not(text()='0016') ">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Toetssoort' binnen het blok 'Eindtoets basisonderwijs' bevat een waarde die niet voorkomt in codelijst 42.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld <toetsniveau> binnen <eindtoets_basisonderwijs> conform codelijst 43. Niveau eindtoets -->
      <!-- 20161128: Validatie van deze codelijst toegevoegd -->
      <xsl:for-each select="/descendant::*/od:eindtoets_basisonderwijs/od:eindtoetsresultaat/od:toetsniveau">
        <xsl:if test="not(text()='B') and not(text()='N') and not(text()='S') and not(text()='E') ">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Toetsniveau' binnen het blok 'Eindtoets basisonderwijs' bevat een waarde die niet voorkomt in codelijst 43.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld <wettelijke_ontheffing> binnen <eindtoets_basisonderwijs> conform codelijst 44. Wettelijke ontheffing eindtoets -->
      <!-- 20161128: Validatie van deze codelijst toegevoegd -->
      <xsl:for-each select="/descendant::*/od:eindtoets_basisonderwijs/od:eindtoetsresultaat/od:wettelijke_ontheffing">
        <xsl:if test="not(text()='J') and not(text()='N') ">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Wettelijke ontheffing' binnen het blok 'Eindtoets basisonderwijs' bevat een waarde die niet voorkomt in codelijst 44.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld <ond_referentieniveau> en <dom_referentieniveau> binnen <eindtoets_basisonderwijs> conform codelijst 45. Eindtoets referentieniveau -->
      <!-- 20161128: Validatie van deze codelijst toegevoegd -->
      <xsl:for-each select="/descendant::*/od:eindtoets_basisonderwijs/od:eindtoetsresultaat/od:onderdelen/od:onderdeel/od:ond_referentieniveau">
        <xsl:if test="not(text()='01') and not(text()='02') and not(text()='03') and not(text()='04') ">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Onderdeel referentiescore' binnen het blok 'Eindtoets basisonderwijs' bevat een waarde die niet voorkomt in codelijst 45.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="/descendant::*/od:eindtoets_basisonderwijs/od:eindtoetsresultaat/od:onderdelen/od:onderdeel/od:domeinen/od:domein/od:dom_referentieniveau">
        <xsl:if test="not(text()='01') and not(text()='02') and not(text()='03') and not(text()='04') ">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Domein referentiescore' binnen het blok 'Eindtoets basisonderwijs' bevat een waarde die niet voorkomt in codelijst 45.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld <onderdeelcode> binnen <eindtoets_basisonderwijs> conform codelijst 46. Eindtoets cnderdeelcode -->
      <!-- 20161128: Validatie van deze codelijst toegevoegd -->
      <xsl:for-each select="/descendant::*/od:eindtoets_basisonderwijs/od:eindtoetsresultaat/od:onderdelen/od:onderdeel/od:onderdeelcode">
        <xsl:if test="not(text()='8000') and not(text()='8001') ">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Onderdeelcode' binnen het blok 'Eindtoets basisonderwijs' bevat een waarde die niet voorkomt in codelijst 46.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld <domeincode> binnen <eindtoets_basisonderwijs> conform codelijst 47. Eindtoets domeincode -->
      <!-- 20161128: Validatie van deze codelijst toegevoegd -->
      <xsl:for-each select="/descendant::*/od:eindtoets_basisonderwijs/od:eindtoetsresultaat/od:onderdelen/od:onderdeel/od:domeinen/od:domein/od:domeincode">
        <xsl:if test="not(text()='8050') and not(text()='8051') ">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Domeincode' binnen het blok 'Eindtoets basisonderwijs' bevat een waarde die niet voorkomt in codelijst 47.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform codelijst -->
      <!-- Is de waarde van veld <domeincode> binnen <eindtoets_basisonderwijs> conform codelijst 48. Categorie uitlevering -->
      <!-- 20170308: Validatie van deze codelijst toegevoegd voor alle betreffende velden in blok "categorie uitlevering" -->
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_metadata">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Metadata' (cat_metadata) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_ouderinzage">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Ouderinzage' (cat_ouderinzage) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_school">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie School' (cat_school) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_leerling">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Leerling' (cat_leerling) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_oudersverzorgers">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Ouders/Verzorgers' (cat_oudersverzorgers) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_vve">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie VVE' (cat_vve) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_schoolloopbaan">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Schoolloopbaan' (cat_schoolloopbaan) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_overstapadvies">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Overstapadvies' (cat_overstapadvies) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_zorgenbegeleiding">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Zorg en Begeleiding' (cat_zorgenbegeleiding) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_verzuim">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Verzuim' (cat_verzuim) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_eindtoetsbo">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Eindtoets bo' (cat_eindtoetsbo) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_toetsresultaten">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Toetsresultaten' (cat_toetsresultaten) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_handelingsplannen">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Handelingsplannen' (cat_overstapadvies) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_cijferlijsten">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Cijferlijsten' (cat_cijferlijsten) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_vombo">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie VO-MBO' (cat_vombon) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="//od:metadata/od:categorie_uitlevering/od:cat_bijlagedocs">
        <xsl:if test="not(text()='VERPLICHT') and not(text()='OPTIONEEL')  and not(text()='VERBODEN') and not(text()='OPT-UIT')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Categorie Bijlagedocumenten' (cat_bijlagedocs) binnen metadata bevat een waarde die niet voorkomt in codelijst 48.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- ________________________________________________________________________________________ -->
      <!--                              Validatie van veldwaarden                                   -->
      <!-- ________________________________________________________________________________________ -->
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OG.01 -->
      <!-- e-mail format controle van veld "nummer" binnen "communicatie" (zie Tabel A.6): 
				Formaat AN  4…256 (karakterset afkomstig van basistype)Reguliere expressie
				Beschrijving controles: 
				Het emailadres moet 1 teken @ bevatten. 
				Het deel voor de @ mag tot 64 tekens lang zijn. 
				Er mogen cijfers,  letters en de volgende tekens in voorkomen: !#$%  *+=?^_`{|}~.-. 
				De domeinnaam mag cijfers, letters, punten en minnen bevatten, maar mag niet met punt of min beginnen of eindigen. 
				De extensie moet letters bevatten (let op, nu in reguliere expressie controle van DUO ook cijfers toegelaten).
				reguliere expressie conform DUO: "[a-zA-Z0-9!#$%*+=?^_`{|}~.-]+@[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*$" -->
      <!-- 20160120: Validatie van deze veldwaarde toegevoegd -->
      <xsl:for-each select="/descendant::*/od:communicatie">
        <xsl:variable name="csoort" select="xs:string(od:soort)"/>
        <xsl:variable name="cadres" select="xs:string(od:nummer)"/>
        <xsl:if test="($csoort='e-mail') and (string-length($cadres) lt 4)">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Een e-mail adres is minimaal 4 tekens.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="($csoort='e-mail') and (string-length($cadres) gt 256)">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Een e-mail adres is niet langer dan 256 tekens.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="($csoort='e-mail') and not(contains($cadres,'@'))">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">In een e-mail adres is het @-teken verplicht.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="($csoort='e-mail') and not(matches($cadres,'[a-zA-Z0-9!#$%*+=?^_`{|}~.-]+@[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*$'))">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">In een e-mail adres moet voldoen aan de voorwaarden m.b.t. toegestane karakters voorgaand aan het @-teken en voor domeinnaam en extensie.</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OG.02 -->
      <!-- Veld "standaardversie" binnen "metadata" heeft waarde "2017.1" -->
      <!-- Is de waarde van veld dossier.metadata.standaardversie conform afspraak -->
      <xsl:for-each select="/descendant::*/od:metadata/od:standaardversie">
        <xsl:if test="not(text()='2017.1')">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'Versienummer van standaard' bevat een waarde die niet gelijk is aan de verplichte waarde "2017.1".</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OG.03 -->
      <!-- lwoo einddatum format controle van veld "lwoo_einddatum" binnen "lwoo" (zie Tabel A.20): 
				Formaat "EEJJ-07-31"
				reguliere expressie: "[0-9][0-9][0-9][0-9]-07-31" -->
      <!-- 20160120: Validatie van deze veldwaarde toegevoegd (is verbodig want XSD controleert dit ook) -->
      <xsl:for-each select="/descendant::*/od:lwoo_einddatum">
        <xsl:if test="not(matches(text(),'[0-9][0-9][0-9][0-9]-07-31'))">
          <xsl:call-template name="melding">
            <xsl:with-param name="tekst">Het veld 'LWOO einddatum' bevat een waarde die niet gelijk is aan het formaat "EEJJ-07-31".</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
      <!-- ________________________________________________________________________________________ -->
      <!--                              Validatie van Categorie velden wanneer uitgezet             -->
      <!-- ________________________________________________________________________________________ -->
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_metadata -->
      <!-- Gegevens van categorie "Ouderinzage" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_metadata='OPT-UIT') and (//od:dossier/od:metadata))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Metadata" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_metadata='OPT-UIT') and (//od:dossier/od:overdrachtsoort))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens over de overdracht uit de categorie "Metadata" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_ouderinzage -->
      <!-- Gegevens van categorie "Ouderinzage" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_ouderinzage='OPT-UIT') and (//od:dossier/od:inzage))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Ouderinzage" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_oudersverzorgers -->
      <!-- Gegevens van categorie "Ouders/Verzorgers" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_oudersverzorgers='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:verzorgersaansprakelijk))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Ouders/Verzorgers" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_oudersverzorgers='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:verzorger))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen ouders/verzorger gegevens uit de categorie "Ouders/Verzorgers" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_oudersverzorgers='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:aansprakelijkeinstelling))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen aansprakelijke instelling gegevens bevatten uit de categorie "Ouders/Verzorgers" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_vve -->
      <!-- Gegevens van categorie "VVE" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regels toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vve='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:vanpeuterspeelzaal))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen PSZ gegevens uit de categorie "VVE" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vve='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:naampeuterspeelzaal))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen PSZ naam uit de categorie "VVE" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vve='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:voorschools))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Voorschoolse educatie gegevens uit de categorie "VVE" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vve='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:vroegschools))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Vroegschoolse educatie gegevens uit de categorie "VVE" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_schoolloopbaan -->
      <!-- Gegevens van categorie "Schoolloopbaan" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_schoolloopbaan='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:schoolloopbaanlijst))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Schoolloopbaan" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_overstapadvies -->
      <!-- Gegevens van categorie "Overstapadvies" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_overstapadvies='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:overstapadvies))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Overstapadvies" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_zorgenbegeleiding -->
      <!-- Gegevens van categorie "Zorg en Begeleiding" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regels toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_zorgenbegeleiding='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:zorg))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Zorg en Begeleiding" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_zorgenbegeleiding='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:sefunctioneren))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gevevens over SE functioneren uit de categorie "Zorg en Begeleiding" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_verzuim -->
      <!-- Gegevens van categorie "Verzuim" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_verzuim='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:verzuim))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Verzuim" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_eindtoetsbo -->
      <!-- Gegevens van categorie "Eindtoets bo" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_eindtoetsbo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:eindtoets_basisonderwijs))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Eindtoets bo" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_toetsresultaten -->
      <!-- Gegevens van categorie "Toetsresultaten" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_toetsresultaten='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:toetslijst))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Toetsresultaten" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_handelingsplannen -->
      <!-- Gegevens van categorie "Handelingsplannen" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_handelingsplannen='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:handelingsplanlijst))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Handelingsplannen" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_cijferlijsten -->
      <!-- Gegevens van categorie "Cijferlijsten" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_cijferlijsten='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:cijferlijstlijst))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Cijferlijsten" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_vombo -->
      <!-- Gegevens van categorie "Cijferlijsten" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regels toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vombo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:bevorderd))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Bevorderd gegevens uit de categorie "VO-MBO" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vombo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:examenresultaat))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Examens en uitslagen uit de categorie "VO-MBO" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vombo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:resultaatvakkenvo))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen VO vakken en resultaten uit de categorie "VO-MBO" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vombo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:certificaat))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Certificaat gegevens uit de categorie "VO-MBO" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vombo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:competenties))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Competentie gegevens uit de categorie "VO-MBO" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vombo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:stage))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Stage gegevens uit de categorie "VO-MBO" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_vombo='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:overigvombo))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen Overige VO-MBO gegevens uit de categorie "VO-MBO" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- Afspraak OSO gegevensset versie 2017.1, business rule OS.cat_bijlagedocs -->
      <!-- Gegevens van categorie "Bijlagedocumenten" zijn verboden wanneer uitgezet in dossier -->
      <!-- 20170308 volgende regel toegevoegd -->
      <xsl:if test="((//od:dossier/od:metadata/od:categorie_uitlevering/od:cat_bijlagedocs='OPT-UIT') and (//od:dossier/od:huidigeschool/od:leerling/od:overigdocumentlijst))">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">Een dossier mag geen gegevens uit de categorie "Bijlagedocumenten" bevatten wanneer deze categorie is uitgezet.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:apply-templates/>
    </meldingen>
  </xsl:template>
</xsl:stylesheet>
