<?xml version="1.0" encoding="UTF-8"?>
<!--Overzicht van wijzigingen -->
<!-- 20180228: Update release versie 2017.1.2 van SWV PaO profielen: validatie van codelijst 43 (niveau eindtoets) uitgebreid met G -->
<!-- 20170308: Eerste officiele release van Validatie van SWV PaO profielen versie 2017.1.1, gemaakt op basis van Overstapprofielen validatie XSLT -->
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
  <xsl:include href="include/ValideerOSOgegevensset_2017.1.xsl"/>
  <xsl:template match="*|text()|@*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="//od:dossier/od:metadata">
    <!-- _______________________________________________________ -->
    <!-- Metadata business rules t.b.v. SWV-profielen            -->
    <!-- _______________________________________________________ -->
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.MD01 -->
    <!-- Elk dossier moet minimaal LAS bevatten -->
    <xsl:if test="$heeftLAS='N'">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het dossier voor SWV-profielen moet een LAS deel bevatten, en mag niet alleen een LVS of TIB deel bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.MD02 -->
    <!-- 20180228: Validatie van deze waarde aangepast: voor deze versie is waarde "2017.1.2" toegestaan -->
    <!-- 20170308: Veld validatieversie heeft waarde "2017.1.1" -->
    <xsl:if test="($typeDocument='swv-dossier') and  not(od:validatieversie='2017.1.2')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De validatieversie is niet correct voor deze versie van de standaard.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.MD03 -->
    <!-- Veld categorie_uitlevering is verplicht  -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:categorie_uitlevering)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een SWV-dossier moet het blok "Categorie uitlevering" bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.SO01 -->
    <!-- Veld Soort overstap/dossier is verplicht bij alle SWV-dossiers -->
    <xsl:if test="($typeDocument='swv-dossier') and  not(od:overstap)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een SWV-dossier moet de aanduiding voor soort overstap/dossier bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.SO02 -->
    <!-- Veld Soort overstap/dossier heeft waarde POSWV of VOSWV -->
    <xsl:if test="($typeDocument='swv-dossier') and not($typeOverstap='POSWV') and not($typeOverstap='VOSWV')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld 'Soort overstap/dossier' heeft waarde "POSWV" of "VOSWV" binnen een SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.SO03 -->
    <!-- Veld Soort overstap verboden bij alle SWV-dossiers -->
    <xsl:if test="not($typeDocument='swv-dossier')">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een SWV-dossier moet de aanduiding "swv-dossier" voor soort overdracht bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template match="od:huidigeschool">
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.SL01 -->
    <!-- In een SWV-dossier is bij school adres verplicht -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een SWV-dossier is minimaal één adres verplicht bij een school.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.SL02 -->
    <!-- In een SWV-dossier is bij school communicatie verplicht -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:communicatielijst/od:communicatie)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een SWV-dossier is minimaal één set communicatiegegevens verplicht bij een school.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:leerling">
    <!-- ________________________________________________________ -->
    <!-- Leerling business rules t.b.v. SWV-profielen -->
    <!-- ________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL01 -->
    <!-- In een SWV-dossier is bij leerling voornaam verplicht -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:voornaam)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een SWV-dossier is minimaal één voornaam verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL02 -->
    <!-- In een SWV-dossier is bij leerling geboortedatum verplicht -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:geboortedatum)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een SWV-dossier is de geboortedatum verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL03 -->
    <!-- In een SWV-dossier is bij leerling geboortemaand verboden -->
    <xsl:if test="($typeDocument='swv-dossier') and (od:geboortemaand)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een SWV-dossier is de geboortemaand verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL04 -->
    <!-- In een SWV-dossier is bij leerling indicatie adresgeheim verplicht -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:adresgeheim)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een SWV-dossier is de indicatie 'adres geheim' verplicht bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL05 (=ALGEMEEN?) -->
    <!-- Bij leerling adres of adresbuitenland verplicht (todo: toevoegen of NL-adres of buitenlands adres, niet beiden?) -->
    <!-- 20150529 gewijzigd naar adres of adresbuitenland verplicht indien adres niet geheim is -->
    <!-- 20131128 gewijzigd van adres verplicht naar adres of adresbuitenland verplicht -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:adreslijst/od:adres) and not(od:adresbuitenland) and not(xs:boolean(od:adresgeheim))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één Nederlands of buitenlands adres is verplicht bij een leerling waarvan het adres niet geheim is.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL06 (=ALGEMEEN?) -->
    <!-- Bij leerling is indien adres geheim adres verboden -->
    <xsl:if test="($typeDocument='swv-dossier') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is ieder leerlingadres in SWV-dossier verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL07 -->
    <!-- In een SWV-dossiers is postcode4adrres verboden -->
    <xsl:if test="($typeDocument='swv-dossier') and (od:postcode4adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">In een SWV-dossier is de postcode4-adres verboden bij een leerling.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL08 (=ALGEMEEN?) -->
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.OV04 (=ALGEMEEN?) -->
    <!-- In een SWV-dossier bij persoon (leerling, verzorger, etc.) geheimwaarde van communicatie doorgeven wanneer deze communicatie geheim is -->
    <xsl:for-each select="/descendant::*/od:communicatie">
      <xsl:if test="($typeDocument='swv-dossier') and (xs:boolean(od:geheim)) and (xs:string(od:soort)='telefoon') and not(xs:string(od:nummer)='9999999999')">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In een SWV-dossier is geheime communicatieinfo over telefoon verplicht middels de geheimwaarde "9999999999".</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="($typeDocument='swv-dossier') and (xs:boolean(od:geheim)) and (xs:string(od:soort)='e-mail') and not(xs:string(od:nummer)='geheim@geheim.geheim')">
        <xsl:call-template name="melding">
          <xsl:with-param name="tekst">In een SWV-dossier is geheime communicatieinfo over e-mail verplicht middels de geheimwaarde "geheim@geheim.geheim".</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL09 (=ALGEMEEN?) -->
    <!-- Bij leerling is indien adres geheim adresbuitenland verboden -->
    <xsl:if test="($typeDocument='swv-dossier') and (xs:boolean(od:adresgeheim)) and (od:adresbuitenland)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien een adres van leerling geheim, is een buitenlands leerlingadres verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL10 -->
    <!-- geboorteplaats verboden bij alle SWV-dossiers -->
    <xsl:if test="($typeDocument='swv-dossier') and (od:geboorteplaats)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De geboorteplaats van de leerling is verboden in alle SWV-dossiers.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL11 -->
    <!-- nationaliteit verboden bij alle SWV-dossiers -->
    <!-- 20131128 toegevoegd -->
    <xsl:if test="($typeDocument='swv-dossier') and (od:nationaliteit)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De nationaliteit van de leerling is verboden in een SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.LL12 -->
    <!-- BSN of onderwijsnummer is verboden in alle SWV-dossiers -->
    <xsl:if test="($typeDocument='swv-dossier') and ((od:bsn) or (od:onderwijsnummer))">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">BSN of onderwijsnummer is verboden bij een leerling in een SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VV01 -->
    <!-- Afkomstig van PSZ niet toegestaan bij VO-SWV -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='VOSWV') and od:vanpeuterspeelzaal">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld "Afkomstig van PSZ" is niet toegestaan in een VO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VV02 -->
    <!-- Naam PSZ niet toegestaan bij VO-SWV -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='VOSWV') and od:naampeuterspeelzaal">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het veld "Naam van PSZ" is niet toegestaan in een VO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VV03 -->
    <!-- Voorschools niet toegestaan bij VO-SWV -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='VOSWV') and od:voorschools">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Voorschools is niet toegestaan in een VO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VV04 -->
    <!-- Vroegschools niet toegestaan bij VO-SWV  -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='VOSWV') and od:vroegschools">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Vroegschools is niet toegestaan in een VO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.SL01 -->
    <!-- In een SWV-profiel is schoolloopbaan verplicht -->
    <xsl:if test="($typeDocument='swv-dossier') and not(od:schoolloopbaanlijst/od:schoolloopbaan)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één schoolloopbaan is verplicht bij een leerling in een SWV-dossier .</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.EB01 -->
    <!-- Eindtoets basisonderwijs niet toegestaan bij PO-SWV  -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:eindtoets_basisonderwijs">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "Eindtoets basisonderwijs" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.OV01 -->
    <!-- Test of het blok verzorger afwezig is wanneer 'verzorgersaansprakelijk' waar is-->
    <xsl:if test="($typeDocument='swv-dossier') and  (xs:boolean(od:verzorgersaansprakelijk)) and not(od:verzorger)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Minimaal één verzorger is verplicht in een SWV-dossier als de verzorgers aansprakelijk zijn.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VM01 -->
    <!-- Bevorderd niet bij PO-SWV toegstaan -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:bevorderd">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "Bevorderd" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VM02 -->
    <!-- Examenresultaten niet bij PO-SWV toegstaan -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:examenresultaat">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "Examens en uitslagen" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VM03 -->
    <!-- Resultaat vakken VO niet bij PO-SWV toegstaan -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:resultaatvakkenvo">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "VO vakresultaat" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VM04 -->
    <!-- Certificaten niet bij PO-SWV toegstaan -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:certificaat">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "Certificaat" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VM05 -->
    <!-- Competenties niet bij PO-SWV toegstaan -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:competenties">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "Competentie" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VM06 -->
    <!-- Stages niet bij PO-SWV toegstaan -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:stage">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "Stages" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.VM07 -->
    <!-- overige VO-MBO niet bij PO-SWV toegstaan -->
    <xsl:if test="($typeDocument='swv-dossier') and ($typeOverstap='POSWV') and od:overigvombo">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Het blok "Overige vo-mbo gegevens" is niet toegestaan in een PO SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:verzorger">
    <!-- ________________________________________________________ -->
    <!-- Verzorger business rules t.b.v. SWV-profielen -->
    <!-- ________________________________________________________ -->
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.OV03 (=ALGEMEEN?)-->
    <!-- Bij verzorger is indien adres geheim adres verboden -->
    <xsl:if test="($typeDocument='swv-dossier') and (xs:boolean(od:adresgeheim)) and (od:adreslijst/od:adres)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Indien het adres van de verzorger geheim, is ieder verzorgeradres in SWV-dossier verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.OV05 (=ALGEMEEN?)-->
    <!-- Bij verzorger is banknummer verboden -->
    <xsl:if test="($typeDocument='swv-dossier') and (od:banknummer)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Voor een verzorger is een banknummer in SWV-dossier verboden.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:overstapadvies">
    <!-- _____________________________________________________________ -->
    <!-- Overstapadvies business rules t.b.v. SWV-profielen -->
    <!-- _____________________________________________________________ -->
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:zorg">
    <!-- ___________________________________________________ -->
    <!-- Zorg business rules t.b.v. SWV-profielen -->
    <!-- ___________________________________________________ -->
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.ZB01 -->
    <!-- vir verboden bij alle SWV-dossiers -->
    <xsl:if test="($typeDocument='swv-dossier')  and (od:vir)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De gegevens van de leerling m.b.t. VIR (Verwijsindex jongeren) zijn verboden in een SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.ZB02 -->
    <!-- zat afgeraden bij alle SWV-dossiers -->
    <xsl:if test="($typeDocument='swv-dossier')  and (od:zat)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">De gegevens van de leerling m.b.t. ZAT (Zorgadviesteam) zijn verboden in een SWV-dossier.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="od:eindtoets_basisonderwijs">
    <!-- ________________________________________________________ -->
    <!-- Eindtoets business rules t.b.v. SWV-profielen -->
    <!-- ________________________________________________________ -->
    <xsl:apply-templates/>
  </xsl:template>
  <!-- ______________________________________________________________ -->
  <!-- Toetsresultaten Business rules t.b.v. SWV-profielen -->
  <!-- ______________________________________________________________ -->
  <xsl:template match="od:toets">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.TR01 (=ALGEMEEN?) -->
  <!-- Een toetsresultaat moet minimaal een score, een referentiescore of een bijlage bevatten	-->
  <xsl:template match="od:resultaat">
    <xsl:if test="($typeDocument='swv-dossier') and not(od:toetsscore) and not(od:referentiescore) and not(od:document)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een toetsresultaat moet minimaal een score, een referentiescore of een bijlage bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.TR02 (=ALGEMEEN?) -->
  <!-- Een toetsscore moet minimaal het aantal goed, het aantal fout, het aantal gelezen, de tijd of de vaardigeheidsscore bevatten -->
  <xsl:template match="od:toetsscore">
    <xsl:if test="($typeDocument='swv-dossier') and not(od:aantalopgaven)and not(od:aantalgoed) and not(od:aantalfout) and not(od:aantalgelezen) and not(od:tijd) and not(od:vaardigheidsscore)">
      <xsl:call-template name="melding">
        <xsl:with-param name="tekst">Een toetsscore moet minimaal het aantal oipgaven, het aantal goed, het aantal fout, het aantal gelezen, de tijd of de vaardigeheidsscore bevatten.</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Afspraak OSO gegevensset + SWV-profielen versie 2017.1, business rule PaO.CL01 (=ALGEMEEN?) -->
  <!-- Een score moet minimaal een waarde of een kwalificatie bevatten -->
  <xsl:template match="od:score">
    <xsl:if test="($typeDocument='swv-dossier') and not(od:waarde) and not(od:kwalificatie)">
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
