<?xml version="1.0" encoding="UTF-8"?>
<!--Overzicht van wijzigingen -->
<!-- 20180228: Update release versie 2017.1.2 van OV profielen: validatie van codelijst 43 (niveau eindtoets) uitgebreid met G -->
<!-- 20170308: Eerste officiele release van Validatie van Overstapprofielen versie 2017.1.1, inclusief wijzigingen: 
				Validatie van BR OVa.MD03 en OVb.MD03 (veld categorie_uitlevering) toegevoegd
				Validatie van BR OV.MD02 (veld validatieversie) gewijzigd
				Namespace definitie naar versie 2017.1 (ipv 2016.1) 
				Validatie van codelijsten aangepast: 48 toegevoegd 
				Validatie van codelijsten verplaatst naar apart bestand "ValideerOSOgegevensset_2017.1.xsl" -->
<!-- 20161223: Opheffen van verplichting van datum eindigend op "07-31" (31 juli) voor TLV einddatum. -->
<!-- 20161128: Validatie van codelijsten 42 t/m 47 m.b.t. eindtoets toegevoegd 
	 			Validatie van <validatieversie> (OS.M06) gewijzigd -->
<!-- 20160120: Wijzigingen n.a.v. nieuwe versie 2016.1: 
				Namespace definitie naar versie 2016.1 (ipv 1.2.1 en 1.2.2) 
				Validatie van codelijsten aangepast: 4 & 23 gewijzigd; 39 & 40 verwijderd en 41 toegevoegd 
				Validatie van veldwaarden communicatie e-mail & einddatum (tlv en lwoo) toegevoegd 
				Validatie van business rules t.b.v. profiel "Overstapdossier" (OS.Xyy) aangepast 
				Validatie van business rules t.b.v. profiel "Overstap-binnen-brin" (OVb.Xyy) toegevoegd  -->
<!-- 20151119: Validatie van code Nvt van codelijst 39 toegevoegd -->
<!-- 20150716: Validatie van code NAZ van codelijst 11 en Nvt van codelijst 31 toegevoegd -->
<!-- 20150529: Validatie van code LA van codelijst 11 toegevoegd 
				business rule OVa.T01 is vervallen 
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
<!-- 20140417: verplichting van communicatiegegevens bij leerling vervallen (zie business rule OVa.L05) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:od="http://www.edustandaard.nl/oso_gegevensset/2017/dossier" xmlns="http://www.edustandaard.nl/oso_gegevensset/2017/schemas/Meldingen" exclude-result-prefixes="xs" version="2.0" extension-element-prefixes="od">
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
  <!-- 20170308: Validatie van codelijsten verplaatst naar apart bestand dat wordt hieronder include -->
  <xsl:include href="include/ValideerOSOgegevensset_2017.1.xsl"/>
  <xsl:template match="*|text()|@*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="//od:dossier/od:metadata">
    <!-- _______________________________________________________ -->
    <!-- Algemene business rules t.b.v. profiel “Overstapdossier” -->
    <!-- _______________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen + binnen-brin versie 2017.1, business rule OVa.MD01 -->
    <!-- Afspraak OSO gegevensset + overstapprofielen + binnen-brin versie 2017.1, business rule OVb.MD01  -->
    <xsl:if test="$heeftLAS='N'">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het dossier voor overstap en overdracht-binnen-brin moet een LAS deel bevatten, en mag niet alleen een LVS of TIB deel bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.MD02 -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.MD02 -->
    <!-- 20180228: Validatie van deze waarde aangepast: voor deze versie is waarde "2017.1.2" toegestaan -->
    <!-- 20170308 Veld validatieversie heeft waarde "2017.1.1" -->
    <!-- 20161128 deze regel aangepast aan nieuwe XSD -->
    <!-- 20160223 volgende regel toegevoegd -->
    <xsl:if test="not(od:validatieversie='2017.1.2')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De validatieversie is niet correct voor deze versie van de validatie XSLT.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OS03 -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.OS01 -->
    <!-- Bij overstapdossier heeft veld soort overdracht de waarde overstapdossier of overdrachtbinnenbrin -->
    <!-- 20131128 volgende regel toegevoegd -->
    <xsl:if test="not($typeDocument='overstapdossier') and not($typeDocument='overdrachtbinnenbrin')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld Soort overdracht heeft waarde "overstapdossier" of "overdrachtbinnenbrin".</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- _______________________________________________________ -->
    <!-- Metadata business rules t.b.v. profiel “Overstapdossier” -->
    <!-- _______________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.MD03 -->
    <!-- Veld categorie_uitlevering is verplicht voor overstapdossiers -->
    <!-- 20170308 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:categorie_uitlevering)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een overstapdossier moet het blok "Categorie uitlevering" bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OS01 -->
    <!-- Veld Soort overstap verplicht bij alle overstapdossiers -->
    <!-- 20131128 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and  not(od:overstap)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een overstapdossier moet de aanduiding voor soort overstap bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OS02 -->
    <!-- Veld Soort overstap heeft waarde POPO, POVO of VOVO -->
    <!-- 20131128 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and not($typeOverstap='POPO') and not($typeOverstap='POVO') and not($typeOverstap='VOVO')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld 'Soort overstap' heeft waarde "POPO", "POVO" of "VOVO" binnen een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- ______________________________________________________________ -->
    <!-- Metadata business rules t.b.v. profiel “Overstap-binnen-brin” -->
    <!-- ______________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.MD03 -->
    <!-- Veld categorie_uitlevering is verplicht voor overstapdossiers -->
    <!-- 20170308 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and not(od:categorie_uitlevering)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een binnen-brin dossier moet het blok "Categorie uitlevering" bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template match="//od:dossier">
    <!-- ______________________________________________________ -->
    <!-- Dossier business rules t.b.v. profiel “Overstapdossier” -->
    <!-- ______________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.IZ01 -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.IZ02 -->
    <!--In een overstapdossier moet de inzage node aanwezig zijn.-->
    <!-- 20131128 volgende regel toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and not(xs:boolean(//od:inzage/od:inzage))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Elk overstapdossier moet zijn ingezien door ouders/verzorgers, ofwel het veld 'Inzage ouders' moet waarde "Ja" (true) bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.IZ03 -->
    <!--Als er ook inzage geweest is, is datum van inzage verplicht. -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:inzage) and not(od:inzagedatum)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In overstapdossier is 'Inzagedatum' verplicht als er inzage is geweest.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.IZ04 -->
    <!--Als er ook inzage geweest is, is een waarde van akkoord verplicht. -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:inzage) and not(od:akkoord)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In overstapdossier is de indicatie of ouders het wel of niet eens zijn met de inhoud verplicht als er inzage is geweest.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.IZ05 -->
    <!-- 20150216: Veld "toestemming" verplicht bij VOVO-overstap -->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='VOVO') and not(od:toestemming)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld 'Toestemming' is verplicht bij een VOVO-overstap.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:huidigeschool">
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.SL01 -->
    <!-- In een overstapdossier is bij school adres verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is minimaal één adres verplicht bij een school.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.SL02 -->
    <!-- In een overstapdossier is bij school communicatie verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:communicatielijst/od:communicatie)">
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL01 -->
    <!-- In een overstapdossier is bij leerling voornaam verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:voornaam)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is minimaal één voornaam verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL02 -->
    <!-- In een overstapdossier is bij leerling geboortedatum verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:geboortedatum)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de geboortedatum verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL03 -->
    <!-- In een overstapdossier is bij leerling geboortemaand verboden -->
    <!-- 20160120: validatie van business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:geboortemaand)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de geboortemaand verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL04 -->
    <!-- In een overstapdossier is bij leerling indicatie adresgeheim verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:adresgeheim)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de indicatie 'adres geheim' verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL05 -->
    <!-- Bij leerling adres of adresbuitenland verplicht (todo: toevoegen of NL-adres of buitenlands adres, niet beiden?) -->
    <!-- 20150529 gewijzigd naar adres of adresbuitenland verplicht indien adres niet geheim is -->
    <!-- 20131128 gewijzigd van adres verplicht naar adres of adresbuitenland verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:adreslijst/od:adres) and not(od:adresbuitenland) and not(xs:boolean(od:adresgeheim))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één Nederlands of buitenlands adres is verplicht bij een leerling waarvan het adres niet geheim is.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL06 -->
    <!-- Bij leerling is indien adres geheim adres verboden -->
    <!-- 20160120: validatie van business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is ieder leerlingadres in overstapdossier verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL07 -->
    <!-- In een overstapdossier is postcode4adrres verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:postcode4adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overstapdossier is de postcode4-adres verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL08 -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OV04 -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL09 -->
    <!-- Bij leerling is indien adres geheim adresbuitenland verboden -->
    <!-- 20160120: validatie van business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:adresgeheim)) and (od:adresbuitenland)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is een buitenlands leerlingadres verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL10 -->
    <!-- geboorteplaats verboden bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:geboorteplaats)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De geboorteplaats van de leerling is verboden in alle overstapdossiers.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL11 -->
    <!-- nationaliteit verboden bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (od:nationaliteit)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De nationaliteit van de leerling is verboden in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL12 -->
    <!-- BSN of onderwijsnummer is verplicht in alle overstapdossiers -->
    <xsl:if test="($typeDocument='overstapdossier') and (not(od:bsn) and not(od:onderwijsnummer))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">BSN of onderwijsnummer is verplicht bij een leerling in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL13 -->
    <!-- leerlingid alleen bij POVO overstapdossier -->
    <!--<xsl:if test="$typeDocument='overstapdossier' and $typeOverstap='POVO' and not(od:leerlingid) ">-->
    <!--<xsl:if test="($typeDocument='overstapdossier' or $typeDocument='verrijkingsinput') and $typeOverstap='POVO' and not(od:leerlingid) ">-->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='POVO') and not(od:leerlingid) ">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De code van de leerling in de schooladministratie is verplicht in een POVO-overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL14 -->
    <!-- datum van inschrijving verplicht bij overstapdossier -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:datuminschrijving)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Inschrijfdatum is verplicht bij een leerling in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.LL15 -->
    <!-- Een overstapdossier moet het veld “Verzorgers zijn aansprakelijk?” bevatten -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier')  and  not(od:verzorgersaansprakelijk)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De aanduiding of verzorgers wel of niet aansprakelijk zijn is verplicht in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.AI01 -->
    <!-- In een overstapdossier is Aansprakelijke instelling verplicht als de verzorgers niet aansprakelijk zijn -->
    <!-- 20170308 regel gewijzigd: alleen voor POPO en POVO; 20131128 volgende regel gewijzigd //od:huidigeschool/od:leerling/ ervoor -->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='POPO') and not(xs:boolean(od:verzorgersaansprakelijk)) and not(od:aansprakelijkeinstelling)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Aansprakelijke instelling is verplicht in een POPO-overstapdossier als de verzorgers niet aansprakelijk zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='POVO') and not(xs:boolean(od:verzorgersaansprakelijk)) and not(od:aansprakelijkeinstelling)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Aansprakelijke instelling is verplicht in een VOVO-overstapdossier als de verzorgers niet aansprakelijk zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.VV01 -->
    <!-- Voorschools alleen toegestaan bij POPO-overstap -->
    <xsl:if test="($typeDocument='overstapdossier') and not($typeOverstap='POPO') and od:voorschools">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Voorschools is alleen toegestaan bij een POPO-overstap.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.VV02 -->
    <!-- Vroegschools alleen toegestaan bij POPO-overstap -->
    <xsl:if test="($typeDocument='overstapdossier') and not($typeOverstap='POPO') and od:vroegschools">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Vroegschools is alleen toegestaan bij een POPO-overstap.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.SL01 -->
    <!-- In een overstapdossier is schoolloopbaan verplicht -->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:schoolloopbaanlijst/od:schoolloopbaan)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één schoolloopbaan is verplicht bij een leerling in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OA01 -->
    <!--In een overstapdossier moet de overstapadvies node aanwezig zijn.-->
    <xsl:if test="($typeDocument='overstapdossier') and not(od:overstapadvies)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een overstapdossier moet het gegevensblok 'Overstapadvies' bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.TR01 -->
    <!-- Minimaal 1 toets verplicht bij POVO-overstap in dossier met begeleidingsgegevens -->
    <!-- 20150529 Deze business rule is als verplichting vervallen, wel aanbevolen -->
    <!--<xsl:if test="($typeDocument='overstapdossier') and ($heeftLVS='Y') and $typeOverstap='POVO' and not(od:toetslijst/od:toets)">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Minimaal één toets is verplicht bij een leerling in een POVO-overstapdossier met begeleidingsgegevens.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>-->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OV01 -->
    <!-- Test of het blok verzorger afwezig is wanneer 'verzorgersaansprakelijk' waar is-->
    <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:verzorgersaansprakelijk)) and not(od:verzorger)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één verzorger is verplicht in een overstapdossier als de verzorgers aansprakelijk zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- ______________________________________________________________ -->
    <!-- Leerling business rules t.b.v. profiel “Overstap-binnen-brin” -->
    <!-- ______________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.LL01 -->
    <!-- In een Overstap-binnen-brin is bij leerling geboortemaand verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (od:geboortemaand)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overdracht-binnen-brin is de geboortemaand verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.LL02 -->
    <!-- Bij leerling is indien adres geheim adres in Overstap-binnen-brin verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is ieder leerlingadres in overdracht-binnen-brin verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.LL03 -->
    <!-- In een Overstap-binnen-brin is postcode4adrres verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (od:postcode4adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een overdracht-binnen-brin is de postcode4-adres verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.LL04 -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.OV02 -->
    <!-- In een Overstap-binnen-brin bij persoon (leerling,verzorger,etc.) geheimwaarde van communicatie doorgeven wanneer deze communicatie geheim is -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.LL05 -->
    <!-- Bij leerling is indien adres geheim adresbuitenland in een Overstap-binnen-brin verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overdrachtbinnenbrin') and (xs:boolean(od:adresgeheim)) and (od:adresbuitenland)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is een buitenlands leerlingadres in overdracht-binnen-brin verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- data dictionary regel 348: Bevorderd of Examenresultaat -->
    <!--<xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='VOMBO') and (not(od:bevorderd) and not(od:examenresultaat))">
			<xsl:call-template name="melding">
				<xsl:with-param name="tekst">Bij een VO-MBO overstap is of een waarde voor Bevorderd, of een waarde voor Examenresultaat verplicht.</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:apply-templates/>-->
  </xsl:template>
  <xsl:template match="od:verzorger">
    <!-- ________________________________________________________ -->
    <!-- Verzorger business rules t.b.v. profiel “Overstapdossier” -->
    <!-- ________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OV03 -->
    <!-- Bij verzorger is indien adres geheim adres verboden -->
    <!-- 20160120: validatie van deze business rule toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien het adres van de verzorger geheim, is ieder verzorgeradres in overstapdossier verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- _______________________________________________________________ -->
    <!-- Verzorger business rules t.b.v. profiel “Overstap-binnen-brin” -->
    <!-- _______________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVb.OV01 -->
    <!-- Bij verzorger is indien adres geheim adres in Overstap-binnen-brin verboden -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OA02 -->
    <!-- Advies VO is verplicht bij een POVO-overstap, WECVO-scholen zijn uitgezonderd -->
    <!-- 20131128 gewijzigd in uitzondering van advies voor SO-scholen -->
    <xsl:if test="($typeDocument='overstapdossier') and ($typeOverstap='POVO') and not($soortSchool='SO') and not(od:advies)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Advies VO is verplicht bij een POVO-overstap, SO-scholen uitgezonderd.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OA03 -->
    <!-- contactnodig verplicht bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier')  and  not(od:contactnodig)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De aanduiding of contact wel of niet nodig is, is verplicht in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OA04 -->
    <!-- contactpersoon verplicht bij contactnodig -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:contactnodig)">
      <xsl:if test="not(od:contactpersoon)">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In overstapdossier is Contactpersoon verplicht als contact nodig is.</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.OA05 -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.ZB01 -->
    <!-- naam ib-er verplicht bij lgf -->
    <xsl:if test="($typeDocument='overstapdossier') and od:lgf and not(od:naamib)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De naam van de interne begeleider is verplicht als er leerlinggebonden financiering (lgf) is.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.ZB02 -->
    <!-- vir verboden bij alle overstapdossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier')  and (od:vir)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De gegevens van de leerling m.b.t. VIR (Verwijsindex jongeren) zijn verboden in een overstapdossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.ZB03 -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.EB01 -->
    <!-- Aanbeveling: niet verplicht -->
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.EB02 -->
    <!-- Bij deelname van eindtoets is toetsresultaat verplicht -->
    <!-- 20150216 BR toegevoegd -->
    <xsl:if test="($typeDocument='overstapdossier') and xs:boolean(od:deelgenomen) and not(od:eindtoetsresultaat)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien leerling heeft deelgenomen aan de eindtoets basisonderwijs moet het blok 'eindtoets' aanwezig zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.EB03 -->
    <!-- Bij geen deelname of ontheffing van eindtoets is identificatie van toets (toetssoort) verplicht -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.EB04 -->
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
    <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.TR04 -->
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
  <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.TR05 -->
  <!-- Een toetsresultaat moet minimaal een score, een referentiescore of een bijlage bevatten	-->
  <xsl:template match="od:resultaat">
    <xsl:if test="($typeDocument='overstapdossier') and not(od:toetsscore) and not(od:referentiescore) and not(od:document)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een toetsresultaat moet minimaal een score, een referentiescore of een bijlage bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.TR06 -->
  <!-- Een toetsscore moet minimaal het aantal goed, het aantal fout, het aantal gelezen, de tijd of de vaardigeheidsscore bevatten -->
  <xsl:template match="od:toetsscore">
    <xsl:if test="($typeDocument='overstapdossier') and not(od:aantalopgaven)and not(od:aantalgoed) and not(od:aantalfout) and not(od:aantalgelezen) and not(od:tijd) and not(od:vaardigheidsscore)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een toetsscore moet minimaal het aantal oipgaven, het aantal goed, het aantal fout, het aantal gelezen, de tijd of de vaardigeheidsscore bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + overstapprofielen versie 2017.1, business rule OVa.CL01 -->
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
