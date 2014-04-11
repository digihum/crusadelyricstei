<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:iso="http://www.iso.org/ns/1.0"
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
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:its="http://www.w3.org/2005/11/its"
  xmlns:tbx="http://www.lisa.org/TBX-Specification.33.0.html"
  version="2.0"
  exclude-result-prefixes="#all">
  <!-- import base conversion style -->
  
  <!-- the base would be <xsl:import href="../../../docx/from/docxtotei.xsl"/>-->
  
  <xsl:import href="../../agora/docx/from.xsl" />
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
    <desc>
      <p> TEI stylesheet for simplifying TEI ODD markup </p>
      <p>This software is dual-licensed:
        
        1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
        Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
        
        2. http://www.opensource.org/licenses/BSD-2-Clause
        
        All rights reserved.
        
        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are
        met:
        
        * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
        
        * Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
        
        This software is provided by the copyright holders and contributors
        "as is" and any express or implied warranties, including, but not
        limited to, the implied warranties of merchantability and fitness for
        a particular purpose are disclaimed. In no event shall the copyright
        holder or contributors be liable for any direct, indirect, incidental,
        special, exemplary, or consequential damages (including, but not
        limited to, procurement of substitute goods or services; loss of use,
        data, or profits; or business interruption) however caused and on any
        theory of liability, whether in contract, strict liability, or tort
        (including negligence or otherwise) arising in any way out of the use
        of this software, even if advised of the possibility of such damage.
      </p>
      <p>Author: See AUTHORS</p>
      <p>Id: $Id$</p>
      <p>Copyright: 2013, TEI Consortium</p>
    </desc>
  </doc>
  
  
  <xsl:template match="@rend[.='Body Text']" mode="pass2"/>
  <xsl:template match="@rend[.='Body Text 2']" mode="pass2"/>
  <xsl:template match="@rend[.='Body Text 3']" mode="pass2"/>
  <xsl:template match="@rend[.='Text Body']" mode="pass2"/>
  <xsl:template match="@rend[.='Text body']" mode="pass2"/>
  <xsl:template match="@rend[.='Body Text Indent']" mode="pass2"/>
  
  
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
          <publisher>University of Warwick? (The publisher is the person or institution by
            whose authority a given edition of the file is made public.)</publisher>
          <date>2014</date>
          <availability status="free">
            <licence target="http://creativecommons.org/licenses/by-sa/3.0/">
              Distributed under a Creative Commons Attribution-ShareAlike 3.0 Unported
              License </licence>
          </availability>
        </publicationStmt>
        <sourceDesc>
          <xsl:value-of select="//div[contains(@type,'previous_editions')]"/>
          <!--not working-->
          <xsl:value-of select="//div[contains(@type,'essential_bibliography')]"/>
          <!--not working-->
          <xsl:value-of select="//div[contains(@type,'manuscripts')]"/>
          <!--not working-->
        </sourceDesc>
      </fileDesc>
      <encodingDesc>
        <xsl:call-template name="generateAppInfo"/>
        <xsl:value-of select="//div[contains(@type,'music')]"/>
        <!--not working-->
      </encodingDesc>
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
        <xsl:if test="matches(.,'music') and matches(.,'xml:lang=it')"> Metrica, prosodia e
          musica </xsl:if>
        <xsl:if test="matches(.,'music') and matches(.,'xml:lang=en')"> Versification and music </xsl:if>
        <xsl:if test="matches(.,'manuscripts')"> Mss. </xsl:if>
        <xsl:if test="matches(.,'essential_bibliography')">
          Essential Bibliography/ <!-- need to split this up -->
        </xsl:if>
        <xsl:if test="matches(.,'previous_editions')"> Previous
          Editions/Edizioni
          precedenti </xsl:if>
        <xsl:if test="matches(.,'tradition') and matches(.,'xml:lang=it')"> Analisi della
          tradizione manoscritta </xsl:if>
        <xsl:if test="matches(.,'tradition') and matches(.,'xml:lang=en')"> Analysis of the
          manuscript traditio </xsl:if>
        <xsl:if test="matches(.,'historical') and matches(.,'xml:lang=it')"> Contesto storico e
          datazione </xsl:if>
        <xsl:if test="matches(.,'historical') and matches(.,'xml:lang=en')"> Historical context and
          dating </xsl:if>
        <xsl:if test="matches(.,'translation') and matches(.,'xml:lang=it')"> Translation </xsl:if>
        <xsl:if test="matches(.,'translation') and matches(.,'xml:lang=en')"> Translation </xsl:if>
        <xsl:if test="matches(.,'notes') and matches(.,'xml:lang=it')"> Note </xsl:if>
        <xsl:if test="matches(.,'notes') and matches(.,'xml:lang=en')"> Notes </xsl:if>
        <xsl:if test="matches(.,'text') and matches(.,'xml:lang=fro')"> Text</xsl:if>
        <xsl:for-each select="$tokenizeVars">
          <xsl:variable name="theKey"
            select="replace(replace(tokenize(.,'=')[1],'\[',''),'@','')"/>
          <xsl:if test="contains($theKey,'type')">
            <xsl:variable name="theValue" select="replace(tokenize(.,'=')[2],'\]','')"/>
            
          </xsl:if>
        </xsl:for-each>
      </head>
    </xsl:template>
  
  <xsl:template match="p" mode="pass1">
    <xsl:attribute name="abc">def</xsl:attribute>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="//tei:div[@type]/tei:head"> found! </xsl:template>
  
</xsl:stylesheet>
