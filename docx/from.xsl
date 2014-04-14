<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:iso="http://www.iso.org/ns/1.0"
  xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
  xmlns:o="urn:schemas-microsoft-com:office:office"
  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  xmlns:rel="http://schemas.openxmlformats.org/package/2006/relationships"
  xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
  xmlns:v="urn:schemas-microsoft-com:vml"
  xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
  xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
  xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
  xmlns:w10="urn:schemas-microsoft-com:office:word"
  xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
  xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:its="http://www.w3.org/2005/11/its"
  xmlns:tbx="http://www.lisa.org/TBX-Specification.33.0.html" version="2.0"
  exclude-result-prefixes="#all">

  <!-- import base conversion style -->

  <!-- the base would be <xsl:import href="../../../docx/from/docxtotei.xsl"/>-->

  <xsl:import href="../../../docx/from/docxtotei.xsl"/>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
    <desc>
      <p> TEI stylesheet for simplifying TEI ODD markup </p>
      <p>This software is dual-licensed: 1. Distributed under a Creative Commons
        Attribution-ShareAlike 3.0 Unported License http://creativecommons.org/licenses/by-sa/3.0/
        2. http://www.opensource.org/licenses/BSD-2-Clause All rights reserved. Redistribution and
        use in source and binary forms, with or without modification, are permitted provided that
        the following conditions are met: * Redistributions of source code must retain the above
        copyright notice, this list of conditions and the following disclaimer. * Redistributions in
        binary form must reproduce the above copyright notice, this list of conditions and the
        following disclaimer in the documentation and/or other materials provided with the
        distribution. This software is provided by the copyright holders and contributors "as is"
        and any express or implied warranties, including, but not limited to, the implied warranties
        of merchantability and fitness for a particular purpose are disclaimed. In no event shall
        the copyright holder or contributors be liable for any direct, indirect, incidental,
        special, exemplary, or consequential damages (including, but not limited to, procurement of
        substitute goods or services; loss of use, data, or profits; or business interruption)
        however caused and on any theory of liability, whether in contract, strict liability, or
        tort (including negligence or otherwise) arising in any way out of the use of this software,
        even if advised of the possibility of such damage. </p>
      <p>Author: See AUTHORS</p>
      <p>Id: $Id$</p>
      <p>Copyright: 2013, TEI Consortium</p>
    </desc>
  </doc>

  <!-- adapted from agora -->

  <!-- 1 : here's what we do in pass2 -->


  <xsl:template match="tei:TEI" mode="pass2">
    <xsl:variable name="Doctext">
      <xsl:copy>
        <xsl:apply-templates mode="pass2"/>
      </xsl:copy>
    </xsl:variable>
    <xsl:apply-templates select="$Doctext" mode="pass3"/>
  </xsl:template>

  <xsl:template match="tei:TEI" mode="pass3">
    <xsl:variable name="Doctext2">
      <xsl:copy>
        <xsl:apply-templates mode="pass3"/>
      </xsl:copy>
    </xsl:variable>
    <xsl:apply-templates select="$Doctext2" mode="pass4"/>
  </xsl:template>


  <!-- templates for pass3 start here -->

  <!-- jiggle around the paragraphs which should be in front -->

  <xsl:template match="tei:text" mode="pass3">
    <text>
      <front>
        <titlePage>
          <docTitle>
            <titlePart type="main">
              <xsl:value-of select="//tei:p[@rend='Title']/text()"/>
              <xsl:apply-templates select="//tei:p[@rend='Title']/*" mode="pass3"/>
            </titlePart>
            <titlePart type="sub">
              <xsl:copy-of select="//tei:p[@rend='Subtitle']/text()"/>
              <xsl:copy-of select="//tei:p[@rend='Subtitle']/*"/>
            </titlePart>

          </docTitle>
          <docAuthor>
            <xsl:value-of select="//tei:p[@rend='author']/text()"/>
            <xsl:copy-of select="//tei:p[@rend='author']/*"/>
          </docAuthor>
        </titlePage>
        <div type="abstract">
          <xsl:for-each select="//tei:p[@rend='abstract']">
            <p>
              <xsl:apply-templates mode="pass3"/>
            </p>
          </xsl:for-each>
        </div>
      </front>
      <body>
        <xsl:apply-templates mode="pass3" select="tei:body/*"/>
      </body>
      <!-- temlplate had bibliography in here
      <back>

   <xsl:for-each select="//tei:div[@type='historical' or @type='essential_bibliography' or @type='notes']">
          <xsl:element name="div">
            <xsl:attribute name="type" select="@type" />
            <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang" />
            </xsl:if>
            <xsl:apply-templates mode="pass3"/>       
          </xsl:element>
        </xsl:for-each>
      </back> -->
    </text>
  </xsl:template>

  <!-- suppress paragraphs which have been jiggled into front/back -->

  <xsl:template match="tei:p[@rend='Title']" mode="pass3"/>
  <xsl:template match="tei:p[@rend='author']" mode="pass3"/>
  <xsl:template match="tei:p[@rend='Subtitle']" mode="pass3"/>
  <xsl:template match="tei:p[@rend='abstract']" mode="pass3"/>
  <xsl:template match="tei:listBibl[@type='essential_bibliography']" mode="pass3"/>
  <xsl:template match="tei:div[@type='manuscripts']" mode="pass3"/>
  <xsl:template match="tei:div[@type='previous_editions']" mode="pass3"/>

  <!-- suppress empty head elements -->

  <xsl:template match="tei:head" mode="pass3">
    <xsl:if test="string-length(.)!=0">
      <head>
        <xsl:value-of select="."/>
      </head>
    </xsl:if>
  </xsl:template>


  <xsl:template match="tei:div[@type='essential_bibliography']" mode="pass2">
    <!-- creates bibliography -->
    <listBibl>
      <xsl:attribute name="type" select="@type"/>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang" select="@xml:lang"/>
      </xsl:if>
      <xsl:for-each select="tei:p[@rend='Bibliography']">
        <xsl:apply-templates mode="pass2"/>
      </xsl:for-each>
    </listBibl>

  </xsl:template>


  <!-- fix up the default header -->
  <xsl:template match="tei:encodingDesc" mode="pass3"/>
  <xsl:template match="tei:titleStmt/tei:author" mode="pass3">
    <xsl:choose>
      <xsl:when test="tei:surname and tei:name">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <author>
          <name>
            <xsl:value-of select="substring-before(.,' ')"/>
          </name>
          <surname>
            <xsl:value-of select="substring-after(.,' ')"/>
          </surname>
        </author>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- fix other styles which should be TEI elements -->
  <xsl:template match="tei:hi[@rend='Quote']" mode="pass3">
    <quote>
      <xsl:apply-templates mode="pass3"/>
    </quote>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='foreign']" mode="pass3">
    <foreign>
      <xsl:apply-templates mode="pass3"/>
    </foreign>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='Article_Title_Char']" mode="pass3">
    <title level="a">
      <xsl:apply-templates mode="pass3"/>
    </title>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='Date_Pub']" mode="pass3">
    <date>
      <xsl:apply-templates mode="pass3"/>
    </date>
  </xsl:template>

  <xsl:template match="tei:bibl/tei:hi[@rend='italic']" mode="pass3">
    <title>
      <xsl:apply-templates mode="pass3"/>
    </title>
  </xsl:template>


  <!-- now some word artefacts we want to suppress -->

  <xsl:template match="tei:hi[@rend='footnote_reference']" mode="pass3">
    <xsl:apply-templates mode="pass3"/>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='FootnoteReference']" mode="pass3">
    <xsl:apply-templates mode="pass3"/>
  </xsl:template>

  <xsl:template match="tei:note/tei:p" mode="pass4">
    <xsl:apply-templates mode="pass4"/>
  </xsl:template>

  <xsl:template match="tei:p" mode="pass4">
    <xsl:choose>
      <xsl:when test="ancestor::tei:div[contains(@type,'translation')]">
        <xsl:element name="div">
          <xsl:attribute name="n">
            <!-- generates stanza numbers automatically -->
            <xsl:number from="tei:div" count="tei:p[not(ancestor::tei:note)]" level="any"/>
          </xsl:attribute>
          <xsl:attribute name="type" select="'stanza'"/>
          <xsl:element name="p">
            <xsl:apply-templates mode="pass4"/>
          </xsl:element>
        </xsl:element>

      </xsl:when>
      <xsl:when test="ancestor::tei:div[contains(@type,'notes')]">
        <p>
          <xsl:choose>
            <xsl:when test="matches(.,'\[@n=')">
              <!-- matches range -->
              <xsl:attribute name="corresp">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="//tei:div[contains(@type,'text')]/@xml:id"/>
                <xsl:text>:[range(@n=</xsl:text>
                <xsl:value-of select="replace(tokenize(.,',')[1],'[','')"/>
                <!-- has gone through without testing -->
                <xsl:text>,@n=</xsl:text>
                <xsl:value-of select="replace(tokenize(.,',')[2],']','')"/>
                <xsl:text>)]</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="tokenize(.,'\]')[2]"/>
              <!-- might ignore some styling -->
            </xsl:when>
            <!-- matches single line -->
            <xsl:when test="matches(.,'\[n=')">
              <xsl:attribute name="corresp">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="//tei:div[contains(@type,'text')]/@xml:id"/>
                <xsl:text>:(</xsl:text>
                <xsl:value-of select="tokenize(tokenize(.,'\]')[1],'\[')[2]"/>
                <xsl:text>)</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="tokenize(.,'\]')[2]"/>
              <!-- might ignore some styling -->
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates mode="pass4"/>
            </xsl:otherwise>
          </xsl:choose>
        </p>

      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates mode="pass4"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:hi[matches(@rend,'color')]" mode="pass3"/>

  <xsl:template match="tei:div[contains(@type,'text')]//tei:lg" mode="pass3">
    <!-- this currently fails because of issues further up the chain -->

    <xsl:element name="lg">
      <xsl:attribute name="n">
        <!-- generates stanza numbers automatically -->
        <xsl:number from="tei:div" count="tei:lg" level="any"/>
      </xsl:attribute>
      <xsl:attribute name="type" select="'stanza'"/>
      <xsl:apply-templates select="text()" mode="pass3"/>
    </xsl:element>

  </xsl:template>

  <xsl:template match="tei:div[contains(@type,'text')]//tei:lg/text()" mode="pass3">
      <l>
        <xsl:attribute name="n">
          <!-- generates stanza numbers automatically -->
          <xsl:number from="tei:div" count="text()[not(self::head)]" level="any"/>
        </xsl:attribute>  
        
        <xsl:value-of select="."/>
      
      </l>
    
  </xsl:template>


  <xsl:template match="tei:hi[matches(@rend,'color')]" mode="pass3"/>


  <!-- contexta magic references -->

  <xsl:template match="tei:hi[@rend='reference']" mode="pass4">
    <xsl:variable name="magicString">
      <xsl:value-of select="substring-before(substring-after(., '&lt;'),'&gt;')"/>
    </xsl:variable>

    <xsl:variable name="parentN">
      <xsl:choose>
        <xsl:when test="ancestor::tei:note">
          <xsl:text>#N</xsl:text>
          <xsl:number from="tei:body" count="tei:note" level="any"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>#P</xsl:text>
          <xsl:number from="tei:body" count="tei:p[not(ancestor::tei:note)]" level="any"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:element name="ref">
      <xsl:attribute name="cRef">
        <xsl:value-of select="$magicString"/>
      </xsl:attribute>
      <xsl:attribute name="corresp">
        <xsl:value-of select="$parentN"/>
      </xsl:attribute>
      <xsl:apply-templates mode="pass4"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='reference']/tei:seg" mode="pass4">
    <hi rend="{@rend}">
      <xsl:value-of select="."/>
    </hi>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='reference']/text()" mode="pass4">
    <xsl:value-of select='substring-before(.,"&lt;")'/>
    <xsl:if test="not(contains(.,'&lt;'))">
      <xsl:value-of select="."/>
    </xsl:if>
    <xsl:value-of select='substring-after(.,"&gt;")'/>
  </xsl:template>


  <!-- now some attribute values we want to kill -->
  <xsl:template match="@rend[.='Body Text First Indent']" mode="pass3"/>
  <xsl:template match="@rend[.='Body Text']" mode="pass3"/>
  <xsl:template match="tei:p[@rend='FootnoteText']" mode="pass3">
    <xsl:apply-templates mode="pass3"/>
  </xsl:template>

  <!-- and copy everything else -->

  <xsl:template match="@*|comment()|processing-instruction()|text()" mode="pass3">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="*" mode="pass3">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass3"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="@*|comment()|processing-instruction()|text()" mode="pass4">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="*" mode="pass4">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass4"/>
    </xsl:copy>
  </xsl:template>

  <!-- end from agora -->



  <xsl:template match="@rend[.='Body Text']" mode="pass2"/>
  <xsl:template match="@rend[.='Body Text 2']" mode="pass2"/>
  <xsl:template match="@rend[.='Body Text 3']" mode="pass2"/>
  <xsl:template match="@rend[.='Text Body']" mode="pass2"/>
  <xsl:template match="@rend[.='Text body']" mode="pass2"/>
  <xsl:template match="@rend[.='Body Text Indent']" mode="pass2"/>
  <!--<xsl:template match="tei:div[@type='previous_editions']" mode="pass2"/>
  <xsl:template match="tei:div[@type='manuscripts']" mode="pass2"/>-->


  <!-- customisations from Steve -->


  <xsl:template name="create-tei-header">
    <teiHeader>
      <fileDesc>
        <titleStmt>
          <title>
            <xsl:call-template name="getDocTitle"/>
          </title>
          <author>Linda Paterson</author>
          <funder>AHRC</funder>
          <principal>Linda Paterson</principal>
          <editor>The person who did the editing</editor>
          <respStmt>
            <name>Steve Ranford</name>
            <resp>Conversion to TEI-conformant markup</resp>
          </respStmt>
          <respStmt>
            <name>joe bloggs</name>
            <resp>Translation to Italian of xyz</resp>
          </respStmt>
        </titleStmt>
        <editionStmt>
          <edition>
            <date>
              <xsl:call-template name="getDocDate"/>
            </date>
          </edition>
        </editionStmt>
        <publicationStmt>
          <publisher>University of Warwick? (The publisher is the person or institution by whose
            authority a given edition of the file is made public.)</publisher>
          <date>2014</date>
          <availability status="free">
            <licence target="http://creativecommons.org/licenses/by-sa/3.0/"> Distributed under a
              Creative Commons Attribution-ShareAlike 3.0 Unported License </licence>
          </availability>
        </publicationStmt>
        <sourceDesc> </sourceDesc>
      </fileDesc>
      <encodingDesc> </encodingDesc>
      <revisionDesc>
        <listChange>
          <change>
            <date>
              <xsl:value-of select="tei:whatsTheDate()"/>
            </date>
            <name>
              <xsl:call-template name="getDocAuthor"/>
            </name>
          </change>
        </listChange>
      </revisionDesc>
    </teiHeader>
  </xsl:template>

  <xsl:template match="//tei:sourceDesc" mode="pass3">
    <!-- have a mismatch between pass 3 and 2 here, so hopefully okay -->
    <sourceDesc>
      <xsl:apply-templates select="//tei:div[contains(@type,'previous_editions')]" mode="pass2"/>
      <xsl:apply-templates select="//tei:listBibl[contains(@type,'essential_bibliography')]"
        mode="pass2"/>
      <xsl:apply-templates select="//tei:div[contains(@type,'manuscripts')]" mode="pass2"/>
    </sourceDesc>
  </xsl:template>

  <xsl:template match="//tei:sourceDesc/tei:div/tei:p" mode="pass3">
    <bibl>
      <xsl:apply-templates mode="pass3"/>
    </bibl>
  </xsl:template>

  <xsl:template match="//tei:sourceDesc/tei:div" mode="pass4">
    <listBibl>
      <xsl:for-each select="@*">
        <xsl:attribute name="{name()}" select="."/>
      </xsl:for-each>
      <xsl:apply-templates mode="pass3"/>
    </listBibl>
  </xsl:template>

  <xsl:template match="tei:encodingDesc" mode="pass3">
    <encodingDesc>
      <xsl:apply-templates select="//tei:div[contains(@type,'music')]" mode="pass2"/>
    </encodingDesc>
  </xsl:template>

  <xsl:template match="tei:body//tei:div[contains(@type,'music')]" mode="pass3"/>



  <xsl:template name="generate-section-heading">
    <xsl:param name="Style"/>
    <xsl:param name="vars" select="."/>
    <xsl:variable name="tokenizeVars" select="tokenize($vars,',')"/>
    <xsl:for-each select="$tokenizeVars">
      <xsl:variable name="theKey" select="replace(replace(tokenize(.,'=')[1],'\[',''),'@','')"/>
      <xsl:attribute name="{$theKey}">
        <xsl:value-of select="replace(tokenize(.,'=')[2],'\]','')"/>
      </xsl:attribute>
    </xsl:for-each>
    <head>
      <xsl:if test="matches(.,'manuscripts')"> Mss. </xsl:if>
      <xsl:if test="matches(.,'essential_bibliography')"> Essential Bibliography/
        <!-- need to split this up -->
      </xsl:if>
      <xsl:if test="matches(.,'previous_editions')"> Previous Editions/Edizioni precedenti </xsl:if>
      <xsl:if test="matches(.,'tradition') and matches(.,'xml:lang=it')"> Analisi della tradizione
        manoscritta </xsl:if>
      <xsl:if test="matches(.,'tradition') and matches(.,'xml:lang=en')"> Analysis of the manuscript
        traditio </xsl:if>
      <xsl:if test="matches(.,'historical') and matches(.,'xml:lang=it')"> Contesto storico e
        datazione </xsl:if>
      <xsl:if test="matches(.,'historical') and matches(.,'xml:lang=en')"> Historical context and
        dating </xsl:if>
      <xsl:if test="matches(.,'translation') and matches(.,'xml:lang=it')"> Translation </xsl:if>
      <xsl:if test="matches(.,'translation') and matches(.,'xml:lang=en')"> Translation </xsl:if>
      <xsl:if test="matches(.,'notes') and matches(.,'xml:lang=it')"> Note </xsl:if>
      <xsl:if test="matches(.,'notes') and matches(.,'xml:lang=en')"> Notes </xsl:if>
      <xsl:if test="matches(.,'text') and matches(.,'xml:lang=fro')"></xsl:if>
      <xsl:for-each select="$tokenizeVars">
        <xsl:variable name="theKey" select="replace(replace(tokenize(.,'=')[1],'\[',''),'@','')"/>
        <xsl:if test="contains($theKey,'type')">
          <xsl:variable name="theValue" select="replace(tokenize(.,'=')[2],'\]','')"/>

        </xsl:if>
      </xsl:for-each>
    </head>
  </xsl:template>

</xsl:stylesheet>
