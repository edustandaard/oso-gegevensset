<?xml version="1.0" encoding="UTF-8"?>
<!--Overzicht van wijzigingen -->
<!-- 20161223: Opheffen van verplichting van datum eindigend op "07-31" (31 juli) voor TLV einddatum. -->
<!-- 20161128: Validatie van codelijsten 42 t/m 47 m.b.t. eindtoets toegevoegd 
	 			Validatie van <validatieversie> (OS.M06) gewijzigd -->
<!-- 20160120: Wijzigingen n.a.v. nieuwe versie 2016.1: 
				Namespace definitie naar versie 2016.1 (ipv 1.2.1 en 1.2.2) 
				Validatie van codelijsten aangepast: 4 & 23 gewijzigd; 39 & 40 verwijderd en 41 toegevoegd 
				Validatie van veldwaarden communicatie e-mail & einddatum (tlv en lwoo) toegevoegd 
				Validatie van business rules t.b.v. profiel "Overstapdossier" (OS.Xyy) aangepast 
				Validatie van business rules t.b.v. profiel "Overdracht-binnen-brin" (BB.Xyy) toegevoegd  -->
<!-- 20151119: Validatie van code Nvt van codelijst 39 toegevoegd -->
<!-- 20150716: Validatie van code NAZ van codelijst 11 en Nvt van codelijst 31 toegevoegd -->
<!-- 20150529: Validatie van code LA van codelijst 11 toegevoegd 
				Business rule OS.T01 is vervallen 
				Validatie van leerlingadres gewijzigd naar adres of adresbuitenland verplicht indien adres niet geheim is -->
<!-- 20150218: validatie van gegevensvelden m.b.t. adres van leerling gewijzigd -->
<!-- 20150218: validatie van waarde van gegevensveld "profiel" met codelijst 21 code "ondersteuning" toegevoegd -->
<!-- 20150216: validatie van waarde van gegevensveld "toestemming" met codelijst 37, "soort_arrangement" met codelijst 39 en "niveau_eindtoets" met codelijst 40 toegevoegd 
				veld "toestemming" verplicht bij VOVO-overstap 
				validatie van business rules OS.I05, OS.E01, OS.E02, OS.E03 en OS.E04 toegevoegd 
				namespace definitie naar versie 1.2 (ipv 1.1) -->
<!-- 20140919: correcte waarde van veld 'Versienummer van afspraak' is "1.1.1"; validatie van waarde "1.1.1" van dit veld tijdelijk verwijderd zodat "1.1" niet tot foutmelding leidt -->
<!-- 20140530: validatie van waarde "1.1" van veld 'Versienummer van afspraak' toegevoegd -->
<!-- 20140519: validatie van 4 velden met codelijst (akkoord, lgfindicatierec, rvcindicatie, examenuitslag en beoordelingexamenvak) toegevoegd, na verwijdering uit XSD -->
<!-- 20140509: validatie van veel gegevensvelden met codelijsten (enumeraties) toegevoegd, na verwijdering uit XSD -->
<!--           validatie van veld Herzien VO advies (herzienadvies) toegevoegd -->
<!-- 20140417: verplichting van communicatiegegevens bij leerling vervallen (zie business rule OS.L05) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:od="http://www.edustandaard.nl/oso_gegevensset/2016/dossier" xmlns="http://www.edustandaard.nl/oso_gegevensset/2016/schemas/Meldingen" exclude-result-prefixes="xs" version="2.0" extension-element-prefixes="od">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <!-- We lezen een paar gegevens uit het dossier die we later goed kunnen gebruiken -->
  <!--<xsl:variable name="typeDocument" select="local-name(/node())"/>-->
  <xsl:variable name="typeDocument" select="//od:overdrachtsoort/text()"/>
  <xsl:variable name="typeOverstap" select="/descendant-or-self::*/od:metadata/od:overstap/text()"/>
  <xsl:variable name="soortSchool" select="//od:huidigeschool/od:soort/text()"/>
  <xsl:variable name="dossierdeel" select="//od:metadata/od:deeldossier/text()"/>
  <xsl:variable name="heeftLAS">
    <xsl:choose>
      <xsl:when test="$dossierdeel='LAS' or $dossierdeel='LASLVS'">
        <xsl:text>Y</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>N</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="heeftLVS">
    <xsl:choose>
      <xsl:when test="$dossierdeel='LVS' or $dossierdeel='LASLVS'">
        <xsl:text>Y</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>N</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!--<xsl:template match="/">
        <meldingen>
            <xsl:if test="not(($typeDocument='overstapdossier') or ($typeDocument='verrijkingsinput') or ($typeDocument='verrijkingsoutput'))">
                <xsl:call-template name="melding">
                    <xsl:with-param name="tekst">Het document moet een Overstapdossier, Verrijkingsinput of Verrijkingsoutput zijn.</xsl:with-param>
                </xsl:call-template>
            </xsl:if>

            <xsl:apply-templates/>
        </meldingen>
    </xsl:template>-->
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
      <!-- Is de waarde van veld dossier.metadata.overstap conform codelijst 16. Soort overstap -->
      <xsl:for-each select="/descendant::*/od:metadata/od:overstap">
        <xsl:if test="not(text()='VSPO') and not(text()='VSWEC') and not(text()='POPO') and not(text()='POWEC') and      not(text()='POVO') and not(text()='VOVO') and not(text()='VOMBO') and not(text()='VOHBO') and      not(text()='VOWO') and not(text()='WECWEC') and not(text()='WECVO') and not(text()='WECMBO') and      not(text()='WECHBO') and not(text()='WECWO') and not(text()='OVERIG')">
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
      <xsl:for-each select="/descendant::*/od:overdrachtsoort">
        <xsl:if test="not(text()='overstapdossier') and not(text()='overdrachtbinnenbrin')">
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
      <!-- ________________________________________________________________________________________ -->
      <!--                              Validatie van veldwaarden                                   -->
      <!-- ________________________________________________________________________________________ -->
      <!-- Afspraak OSO gegevensset: validatie van veldwaarde conform eisen in bijlage van afspraak -->
      <!-- versienummer controle van veld "eldversie" binnen "metadata" (zie Tabel A.2) -->
      <!-- Is de waarde van veld dossier.metadata.eldversie conform afspraak -->
      <!-- 20150216: In deze versie wordt de waarde "1.2.1" aanbevolen: Validatie van deze veldwaarde verwijderd -->
      <!-- 20140919: Verplichte waarde had beter niet "1.1" maar "1.1.1" moeten zijn; dit om onderlinge onderscheid te kunnen maken -->
      <!-- 20140919: Om geen verdere verwarring te krijgen, wordt de validatie van dit versienummer in deze versie van de afspraak losgelaten -->
      <!-- 20140530: Afspraak OSO gegevensset: validatie van veldwaarde van veld 'Versienummer van afspraak' -->
      <!--<xsl:for-each select="/descendant::*/od:metadata/od:eldversie">
				<xsl:if test="not(text()='2016.1')">
					<xsl:call-template name="melding">
						<xsl:with-param name="tekst">Het veld 'Versienummer van afspraak' bevat een waarde die niet gelijk is aan de verplichte waarde "2016.1".</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>-->
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
        <!-- telefoonnummer format controle van veld "nummer" binnen "communicatie" (zie Tabel A.6): 
				Beschrijving aanbevolen controles: 
				Het telefoonnummer bevat alleen cijfers (geen alfanumerieke karakters). 
				Het telefoonnummer moet minimaal 10 cijfers bevatten.  -->
        <!-- 20160120: Validatie van deze veldwaarde toegevoegd (is aanbeveling, dus is commentaar) -->
        <!--<xsl:if test="($csoort='telefoon') and not(matches($cadres,'([0-9])+$'))">
					<xsl:call-template name="melding">
						<xsl:with-param name="tekst">In een telefoonnummer komen alleen cijfers voor.</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="($csoort='telefoon') and (string-length($cadres) lt 10)">
					<xsl:call-template name="melding">
						<xsl:with-param name="tekst">Een telefoonnummer is minimaal 10 cijfers.</xsl:with-param>
					</xsl:call-template>-->
        <!--</xsl:if>-->
      </xsl:for-each>
      <!-- tlv einddatum format controle van veld "tlveinddatum" binnen "tlv" (zie Tabel A.18): 
				Formaat "EEJJ-07-31"
				reguliere expressie: "[0-9][0-9][0-9][0-9]-07-31" -->
      <!-- 20161223: Opheffen van verplichting van datum eindigend op "07-31" (31 juli) voor TLV einddatum -->
      <!-- 20160120: Validatie van deze veldwaarde toegevoegd (is verbodig want XSD controleert dit ook) -->
      <!--<xsl:for-each select="/descendant::*/od:tlveinddatum">
				<xsl:if test="not(matches(text(),'[0-9][0-9][0-9][0-9]-07-31'))">
					<xsl:call-template name="melding">
						<xsl:with-param name="tekst">Het veld 'TLV einddatum' bevat een waarde die niet gelijk is aan het formaat "EEJJ-07-31".</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>-->
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
      <xsl:apply-templates/>
    </meldingen>
  </xsl:template>
  <xsl:template match="*|text()|@*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="//od:dossier/od:metadata">
    <!-- _______________________________________________________ -->
    <!-- Metadata business rules t.b.v. profiel “Overstapdossier” -->
    <!-- _______________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen + binnen-brin versie 2016.1, business rule OS.M01 -->
    <!-- ELD fase 2 doet niet aan deeldossiers, dus elk document moet minimaal LAS bevatten -->
    <!-- Zie data dictionary, tagnaam 'deeldossier' -->
    <xsl:if test="$heeftLAS='N'">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het dossier voor overstap en overdracht-binnen-brin moet een LAS deel bevatten, en mag niet alleen een LVS of TIB deel bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.M02 -->
    <!-- Veld Soort overstap verplicht bij alle overstapdossiers -->
    <!-- 20131128 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier')  and  not(od:overstap)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een overstapdossier moet de aanduiding voor soort overstap bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.M03 -->
    <!-- Veld Soort overstap heeft waarde POPO, POVO of VOVO -->
    <!-- 20131128 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and not($typeOverstap='POPO') and not($typeOverstap='POVO') and not($typeOverstap='VOVO')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld 'Soort overstap' heeft waarde "POPO", "POVO" of "VOVO" binnen een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.M04 -->
    <!-- Bij overstapdossier heeft veld soort overdracht de waarde overstapdossier -->
    <!-- 20131128 volgende regel toegevoegd -->
    <!--<xsl:if test="not($typeDocument='overstapdossier')">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Het veld Soort overdracht heeft waarde "overstapdossier".</xsl:with-param>
			</xsl:call-template>
		</xsl:if>-->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.M05 -->
    <!-- Veld standaardversie heeft waarde "2016.1" -->
    <!-- 20160223 volgende regel toegevoegd -->
    <xsl:if test="not(od:standaardversie='2016.1')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De correcte aanduiding voor deze versie van de standaard is "2016.1".</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.M06 -->
    <!-- Veld validatieversie heeft waarde "2016.1.2" -->
    <!-- 20161128 deze regel aangepast aan nieuwe XSD -->
    <!-- 20160223 volgende regel toegevoegd -->
    <xsl:if test="not(od:validatieversie='2016.1.2')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De validatieversie is niet correct voor deze versie van de standaard.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template match="//od:dossier">
    <!-- ______________________________________________________ -->
    <!-- Dossier business rules t.b.v. profiel “Overstapdossier” -->
    <!-- ______________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.I01 -->
    <!--In een overstapdossier moet de inzage node aanwezig zijn.-->
    <xsl:if test="($typeDocument='overstapdossier') and not(//od:dossier/od:inzage)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een overstapdossier moet het gegevensblok 'Inzage' bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="//od:dossier/od:inzage">
    <!-- _____________________________________________________ -->
    <!-- Inzage business rules t.b.v. profiel “Overstapdossier” -->
    <!-- _____________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.I02 -->
    <!--In een overstapdossier moet de inzage node aanwezig zijn.-->
    <!-- 20131128 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and not(xs:boolean(//od:inzage/od:inzage))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Elk overstapdossier moet zijn ingezien door ouders/verzorgers, ofwel het veld 'Inzage ouders' moet waarde "Ja" (true) bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.I03 -->
    <!--Als er ook inzage geweest is, is datum van inzage verplicht. -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:inzage) and not(od:inzagedatum)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In overstapdossier is 'Inzagedatum' verplicht als er inzage is geweest.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.I04 -->
    <!--Als er ook inzage geweest is, is een waarde van akkoord verplicht. -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:inzage) and not(od:akkoord)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In overstapdossier is de indicatie of ouders het wel of niet eens zijn met de inhoud verplicht als er inzage is geweest.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.I05 -->
    <!-- 20150216: Veld "toestemming" verplicht bij VOVO-overstap -->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='VOVO') and not(od:toestemming)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld 'Toestemming' is verplicht bij een VOVO-overstap.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:huidigeschool">
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.S01 -->
    <!-- In een overstapdossier is bij school adres verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is minimaal één adres verplicht bij een school.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.S02 -->
    <!-- In een overstapdossier is bij school communicatie verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(od:communicatielijst/od:communicatie)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is minimaal één set communicatiegegevens verplicht bij een school.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:leerling">
    <!-- ________________________________________________________ -->
    <!-- Leeerling business rules t.b.v. profiel “Overstapdossier” -->
    <!-- ________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L01 -->
    <!-- In een overstapdossier is bij leerling voornaam verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:voornaam)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is minimaal één voornaam verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L02 -->
    <!-- In een overstapdossier is bij leerling geboortedatum verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:geboortedatum)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de geboortedatum verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L02A -->
    <!-- In een overstapdossier is bij leerling geboortemaand verboden -->
    <!-- 20160120: validatie van business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:geboortemaand)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de geboortemaand verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L03 -->
    <!-- In een overstapdossier is bij leerling indicatie adresgeheim verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(od:adresgeheim)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de indicatie 'adres geheim' verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L04 -->
    <!-- Bij leerling adres of adresbuitenland verplicht (todo: toevoegen of NL-adres of buitenlands adres, niet beiden?) -->
    <!-- 20150529 gewijzigd naar adres of adresbuitenland verplicht indien adres niet geheim is -->
    <!-- 20131128 gewijzigd van adres verplicht naar adres of adresbuitenland verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(od:adreslijst/od:adres) and not(od:adresbuitenland) and not(xs:boolean(od:adresgeheim))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één Nederlands of buitenlands adres is verplicht bij een leerling waarvan het adres niet geheim is.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L04A -->
    <!-- Bij leerling is indien adres geheim adres verboden -->
    <!-- 20160120: validatie van business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is ieder leerlingadres in overstapdossier verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- 20131128 volgende regel verwijderd -->
    <!--data dictionary regel 83-->
    <!--<xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(xs:boolean(od:adresgeheim)) and not(od:adreslijst/od:adres[od:soortadres/text()='gba'])">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Minimaal één gba-adres is verplicht bij een leerling, behalve als het adres geheim is.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>-->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L04B -->
    <!-- In een overstapdossier is postcode4adrres verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:postcode4adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de postcode4-adres verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L05 -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.V04 -->
    <!-- In een overstapdossier bij persoon (leerling, verzorger, etc.) geheimwaarde van communicatie doorgeven wanneer deze communicatie geheim is -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:for-each select="/descendant::*/od:communicatie">
      <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:geheim)) and (xs:string(od:soort)='telefoon') and not(xs:string(od:nummer)='9999999999')">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In een overstapdossier is geheime communicatieinfo over telefoon verplicht middels de geheimwaarde "9999999999".</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:geheim)) and (xs:string(od:soort)='e-mail') and not(xs:string(od:nummer)='geheim@geheim.geheim')">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In een overstapdossier is geheime communicatieinfo over e-mail verplicht middels de geheimwaarde "geheim@geheim.geheim".</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L05A -->
    <!-- Bij leerling is indien adres geheim adresbuitenland verboden -->
    <!-- 20160120: validatie van business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:adresgeheim)) and (od:adresbuitenland)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is een buitenlands leerlingadres verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L06 -->
    <!-- geboorteplaats verboden bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:geboorteplaats)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De geboorteplaats van de leerling is verboden in alle overstapdossiers.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L07 -->
    <!-- nationaliteit verboden bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:nationaliteit)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De nationaliteit van de leerling is verboden in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L08 -->
    <!-- BSN of onderwijsnummer is verplicht in alle overstapdossiers -->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and (not(od:bsn) and not(od:onderwijsnummer))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">BSN of onderwijsnummer is verplicht bij een leerling in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L09 -->
    <!-- leerlingid alleen bij POVO overstapdossier -->
    <!--<xsl:if test="$typeDocument='overstapdossier' and $typeOverstap='POVO' and not(od:leerlingid) ">-->
    <!--<xsl:if test="($typeDocument='overstapdossier' or $typeDocument='verrijkingsinput') and $typeOverstap='POVO' and not(od:leerlingid) ">-->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='POVO') and not(od:leerlingid) ">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De code van de leerling in de schooladministratie is verplicht in een POVO-overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L10 -->
    <!-- datum van inschrijving verplicht bij overstapdossier -->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(od:datuminschrijving)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Inschrijfdatum is verplicht bij een leerling in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L11 -->
    <!-- Een overstapdossier moet het veld “Verzorgers zijn aansprakelijk?” bevatten -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier')  and  not(od:verzorgersaansprakelijk)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De aanduiding of verzorgers wel of niet aansprakelijk zijn is verplicht in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L12 -->
    <!-- In een overstapdossier is Aansprakelijke instelling verplicht als de verzorgers niet aansprakelijk zijn -->
    <!-- 20131128 volgende regel gewijzigd //od:huidigeschool/od:leerling/ ervoor??-->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(xs:boolean(od:verzorgersaansprakelijk)) and not(od:aansprakelijkeinstelling)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Aansprakelijke instelling is verplicht in een overstapdossier als de verzorgers niet aansprakelijk zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L13 -->
    <!-- Voorschools alleen toegestaan bij POPO-overstap -->
    <xsl:if test="($typeDocument='overstapdossier') and not($typeOverstap='POPO') and od:voorschools">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Voorschools is alleen toegestaan bij een POPO-overstap.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L14 -->
    <!-- Vroegschools alleen toegestaan bij POPO-overstap -->
    <xsl:if test="($typeDocument='overstapdossier') and not($typeOverstap='POPO') and od:vroegschools">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Vroegschools is alleen toegestaan bij een POPO-overstap.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.L15 -->
    <!-- In een overstapdossier is schoolloopbaan verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and not(od:schoolloopbaanlijst/od:schoolloopbaan)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één schoolloopbaan is verplicht bij een leerling in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.O01 -->
    <!--In een overstapdossier moet de overstapadvies node aanwezig zijn.-->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:overstapadvies)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een overstapdossier moet het gegevensblok 'Overstapadvies' bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 1.2.2, business rule OS.T01 -->
    <!-- Minimaal 1 toets verplicht bij POVO-overstap in dossier met begeleidingsgegevens -->
    <!-- 20150529 Deze business rule is als verplichting vervallen, wel aanbevolen -->
    <!--<xsl:if test="($typeDocument='overstapdossier') and ($heeftLVS='Y') and $typeOverstap='POVO' and not(od:toetslijst/od:toets)">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Minimaal één toets is verplicht bij een leerling in een POVO-overstapdossier met begeleidingsgegevens.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>-->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.V01 -->
    <!-- Test of het blok verzorger afwezig is wanneer 'verzorgersaansprakelijk' waar is-->
    <xsl:if test="($typeDocument='overstapdossier') and ($heeftLAS='Y') and  (xs:boolean(od:verzorgersaansprakelijk)) and not(od:verzorger)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één verzorger is verplicht in een overstapdossier als de verzorgers aansprakelijk zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- ______________________________________________________________ -->
    <!-- Leerling business rules t.b.v. profiel “Overdracht-binnen-brin” -->
    <!-- ______________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule BB.L01 -->
    <!-- In een overdracht-binnen-brin is bij leerling geboortemaand verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (od:geboortemaand)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overdracht-binnen-brin is de geboortemaand verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule BB.L02 -->
    <!-- Bij leerling is indien adres geheim adres in overdracht-binnen-brin verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is ieder leerlingadres in overdracht-binnen-brin verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule BB.L03 -->
    <!-- In een overdracht-binnen-brin is postcode4adrres verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (od:postcode4adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overdracht-binnen-brin is de postcode4-adres verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule BB.L04 -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule BB.V02 -->
    <!-- In een overdracht-binnen-brin bij persoon (leerling,verzorger,etc.) geheimwaarde van communicatie doorgeven wanneer deze communicatie geheim is -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:for-each select="/descendant::*/od:communicatie">
      <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (xs:boolean(od:geheim)) and (xs:string(od:soort)='telefoon') and not(xs:string(od:nummer)='9999999999')">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In een overdracht-binnen-brin is geheime communicatieinfo over telefoon verplicht middels de geheimwaarde "9999999999".</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (xs:boolean(od:geheim)) and (xs:string(od:soort)='e-mail') and not(xs:string(od:nummer)='geheim@geheim.geheim')">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In een overdracht-binnen-brin is geheime communicatieinfo over e-mail verplicht middels de geheimwaarde "geheim@geheim.geheim".</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule BB.L05 -->
    <!-- Bij leerling is indien adres geheim adresbuitenland in een overdracht-binnen-brin verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (xs:boolean(od:adresgeheim)) and (od:adresbuitenland)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is een buitenlands leerlingadres in overdracht-binnen-brin verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- data dictionary regel 348: Bevorderd of Examenresultaat -->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='VOMBO') and (not(od:bevorderd) and not(od:examenresultaat))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Bij een VO-MBO overstap is of een waarde voor Bevorderd, of een waarde voor Examenresultaat verplicht.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:verzorger">
    <!-- ________________________________________________________ -->
    <!-- Verzorger business rules t.b.v. profiel “Overstapdossier” -->
    <!-- ________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.V03 -->
    <!-- Bij verzorger is indien adres geheim adres verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien het adres van de verzorger geheim, is ieder verzorgeradres in overstapdossier verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- _______________________________________________________________ -->
    <!-- Verzorger business rules t.b.v. profiel “Overdracht-binnen-brin” -->
    <!-- _______________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule BB.V01 -->
    <!-- Bij verzorger is indien adres geheim adres in overdracht-binnen-brin verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van verzorger geheim, is ieder verzorgeradres in overdracht-binnen-brin verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:overstapadvies">
    <!-- _____________________________________________________________ -->
    <!-- Overstapadvies business rules t.b.v. profiel “Overstapdossier” -->
    <!-- _____________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.O02 -->
    <!-- Advies VO is verplicht bij een POVO-overstap, WECVO-scholen zijn uitgezonderd -->
    <!-- 20131128 gewijzigd in uitzondering van advies voor SO-scholen -->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='POVO') and not($soortSchool='SO') and not(od:advies)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Advies VO is verplicht bij een POVO-overstap, SO-scholen uitgezonderd.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.O03 -->
    <!-- contactnodig verplicht bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier')  and  not(od:contactnodig)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De aanduiding of contact wel of niet nodig is, is verplicht in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.O04 -->
    <!-- contactpersoon verplicht bij contactnodig -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:contactnodig)">
      <xsl:if test="not(od:contactpersoon)">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In overstapdossier is Contactpersoon verplicht als contact nodig is.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.O05 -->
    <!-- contacttelefoon verplicht bij contactnodig -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:contactnodig)">
      <xsl:if test="not(od:contacttelefoon)">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In overstapdossier is Telefoonnummer verplicht als contact nodig is.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:zorg">
    <!-- ___________________________________________________ -->
    <!-- Zorg business rules t.b.v. profiel “Overstapdossier” -->
    <!-- ___________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.Z01 -->
    <!-- naam ib-er verplicht bij lgf -->
    <xsl:if test="($typeDocument='overstapdossier') and od:lgf and not(od:naamib)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De naam van de interne begeleider is verplicht als er leerlinggebonden financiering (lgf) is.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.Z02 -->
    <!-- vir verboden bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier')  and (od:vir)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De gegevens van de leerling m.b.t. VIR (Verwijsindex jongeren) zijn verboden in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.Z03 -->
    <!-- zat afgeraden bij alle overstapdossiers -->
    <!-- 20131128 BR toegevoegd (is aanbeveling, dus is commentaar) -->
    <!--<xsl:if test="($typeDocument='overstapdossier')  and (od:zat)">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">De gegevens van de leerling m.b.t. ZAT (Zorgadviesteam) worden afgeraden in een overstapdossier.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>-->
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:eindtoets_basisonderwijs">
    <!-- ________________________________________________________ -->
    <!-- Eindtoets business rules t.b.v. profiel “Overstapdossier” -->
    <!-- ________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.E00 -->
    <!-- Aanbeveling: niet verplicht -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.E01 -->
    <!-- Bij deelname van eindtoets is toets verplicht -->
    <!-- 20150216 BR toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:deelgenomen) and not(od:eindtoetsresultaat)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien leerling heeft deelgenomen aan de eindtoets basisonderwijs moet het blok 'eindtoets' aanwezig zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.E02 -->
    <!-- Bij deelname van eindtoets is identificatie, afname en resultaat binnen toets verplicht -->
    <!-- 20160120 BR verwijderd, dus commentaar -->
    <!-- 20150216 BR toegevoegd -->
    <!--<xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:deelgenomen) and not(od:eindtoets/od:toetsidentificatie)">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Indien leerling heeft deelgenomen aan de eindtoets basisonderwijs moet binnen eindtoets het blok 'toetsidentificatie' aanwezig zijn.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:deelgenomen) and not(od:eindtoets/od:afname)">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Indien leerling heeft deelgenomen aan de eindtoets basisonderwijs moet binnen eindtoets het blok 'afname' van de eindtoets aanwezig zijn.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:deelgenomen) and not(od:eindtoets/od:resultaat)">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Indien leerling heeft deelgenomen aan de eindtoets basisonderwijs moet binnen eindtoets het blok 'resultaat' van de eindtoets aanwezig zijn.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>-->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.E03 -->
    <!-- 20150216: Bij geen deelname of ontheffing van eindtoets is identificatie van toets verplicht -->
    <!-- 20160120 BR gewijzigd (ontheffing en toetsidentificatie vervangen door eindtoetsresultaat/wettelijke_ontheffing resp. toetssoort) -->
    <!-- 20150216 BR toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and not(xs:boolean(od:deelgenomen)) and not(od:eindtoetsresultaat/od:toetssoort)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien leerling niet heeft deelgenomen aan de eindtoets basisonderwijs moet binnen eindtoets het 'Soort eindtoets' aanwezig zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:wettelijke_ontheffing) and not(od:eindtoetsresultaat/od:toetssoort)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien leerling ontheffing heeft voor deelname aan de eindtoets basisonderwijs moet binnen eindtoets het 'Soort eindtoets' aanwezig zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.E04 -->
    <!-- 20150216: Bij deelname van eindtoets is toets verplicht -->
    <!-- 20160120 BR gewijzigd (toetsadvies vervangen door eindtoetsresultaat/toets_advies) -->
    <!-- 20150216 BR toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:deelgenomen) and not(od:eindtoetsresultaat/od:toets_advies)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien leerling heeft deelgenomen aan de eindtoets basisonderwijs moet het veld 'Toetsadvies' aanwezig zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- ______________________________________________________________ -->
  <!-- Toetsresultaten Business rules t.b.v. profiel “Overstapdossier” -->
  <!-- ______________________________________________________________ -->
  <xsl:template match="od:toets">
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.T04 -->
    <!-- alleen de toetsen van huidig, vorig en eervorig schooljaar zijn toestaan bij een POVO-overstap. Een schooljaar loopt van 1 augustus t/m 31 juli -->
    <xsl:variable name="documentdatum" select="xs:date(//od:metadata/od:datum)"/>
    <xsl:variable name="beginSchooljaar" select="xs:date(concat(year-from-date($documentdatum),'-08-01'))"/>
    <xsl:variable name="toetsdatumVanaf">
      <xsl:choose>
        <xsl:when test="$documentdatum lt $beginSchooljaar">
          <xsl:value-of select="xs:date(concat(year-from-date($documentdatum) - 3, '-08-01'))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="xs:date(concat(year-from-date($documentdatum) - 2, '-08-01'))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="$typeOverstap='POVO' and od:afname[xs:date(od:afnamedatum) lt xs:date($toetsdatumVanaf)]">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Alleen toetsen uit het huidige en twee voorgaande schooljaren mogen aanwezig zijn in de POVO-overstap.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.T05 -->
  <!-- Een toetsresultaat moet minimaal een score, een referentiescore of een bijlage bevatten	-->
  <xsl:template match="od:resultaat">
    <xsl:if test="($typeDocument='overstapdossier') and not(od:toetsscore) and not(od:referentiescore) and not(od:document)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een toetsresultaat moet minimaal een score, een referentiescore of een bijlage bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.T06 -->
  <!-- Een toetsscore moet minimaal het aantal goed, het aantal fout, het aantal gelezen, de tijd of de vaardigeheidsscore bevatten -->
  <xsl:template match="od:toetsscore">
    <xsl:if test="($typeDocument='overstapdossier') and not(od:aantalopgaven)and not(od:aantalgoed) and not(od:aantalfout) and not(od:aantalgelezen) and not(od:tijd) and not(od:vaardigheidsscore)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een toetsscore moet minimaal het aantal oipgaven, het aantal goed, het aantal fout, het aantal gelezen, de tijd of de vaardigeheidsscore bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + overstapprofielen versie 2016.1, business rule OS.C01 -->
  <!-- Een score moet minimaal een waarde of een kwalificatie bevatten -->
  <xsl:template match="od:score">
    <xsl:if test="($typeDocument='overstapdossier') and not(od:waarde) and not(od:kwalificatie)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een score moet minimaal een waarde of een kwalificatie bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template name="melding">
    <xsl:param name="tekst"/>
    <melding>
      <type>Fout</type>
      <locatie>
        <xsl:call-template name="xpath">
          <xsl:with-param name="postfix"/>
        </xsl:call-template>
      </locatie>
      <tekst>
        <xsl:value-of select="$tekst"/>
      </tekst>
    </melding>
  </xsl:template>
  <xsl:template name="xpath">
    <xsl:param name="postfix"/>
    <xsl:variable name="local" select="local-name()"/>
    <xsl:variable name="name" select="concat('/', $local, '[', count(preceding-sibling::*[local-name()=$local])+1, ']', $postfix)"/>
    <xsl:choose>
      <xsl:when test="not(parent::*)">
        <xsl:value-of select="$name"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="parent::*">
          <xsl:call-template name="xpath">
            <xsl:with-param name="postfix" select="$name"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
