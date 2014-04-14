<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="html tei" >

    <xsl:output method="xhtml" encoding="UTF-8" indent="no"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />
<xsl:strip-space elements="tei:bibl tei:hi tei:metDecl" />  
    <xsl:template match="/">
    	
        <html>
            <head>
                <title>Text</title>
                <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

                <link rel="stylesheet" href="../bootstrap.min.css"></link>
                <link rel="stylesheet" href="../poem.css"></link>
                <link rel="stylesheet" href="../bootstrap-theme.min.css"></link>
                <script src="../bootstrap.min.js"></script>
                <script type="text/javascript" src="../poem.js"></script>
            </head>        
            <body>
            <div class="full-width">
                <div class="container">
                    <div class="row">
                        <div class=" col-sm-12">
                            <ul class="nav nav-tabs" id="pageSelector2">
                                <li class="active"><a href="#page1" data-toggle="tab">Text</a></li>
                                <li><a href="#page2" data-toggle="tab">About the text</a></li>
                            </ul>
                        </div>
                    </div>
                <div class="tab-content">
                <div id="page1" class="tab-pane active">
                <xsl:apply-templates select="//tei:front"/>

                <xsl:apply-templates select="//tei:body"/>
                    <div class="metadata">

                        <!-- Manuscripts-->
                        
                        <xsl:if test="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'manuscripts') and contains(@xml:lang,'en')]">
                            <div class="lang-en">
                                <h3>Mss.</h3>
                                <xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'manuscripts') and contains(@xml:lang,'en')]" />
                            </div>
                        </xsl:if>
                        <xsl:if test="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'manuscripts') and contains(@xml:lang,'it')]">
                            <div class="lang-it">
                                <h3>Mss.</h3>
                                <xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'manuscripts') and contains(@xml:lang,'it')]" />
                            </div>
                        </xsl:if>
                        <!-- Versification-->
                        <xsl:if test="//tei:teiHeader/tei:encodingDesc/tei:metDecl[contains(@xml:lang,'en')]">
                            <div class="lang-en">
                            <h3 >Versification and music</h3>
                            <xsl:apply-templates select="//tei:teiHeader/tei:encodingDesc/tei:metDecl[contains(@xml:lang,'en')]" />
                            </div>
                        </xsl:if>
                        <xsl:if test="//tei:teiHeader/tei:encodingDesc/tei:metDecl[contains(@xml:lang,'it')]">
                            <div class="lang-it">
                            <h3 >Metrica, prosodia e musica</h3>
                            <xsl:apply-templates select="//tei:teiHeader/tei:encodingDesc/tei:metDecl[contains(@xml:lang,'it')]" />
                            </div>
                        </xsl:if>
                        <xsl:if test="//tei:teiHeader/tei:encodingDesc/tei:metDecl[not(@xml:lang)]">
                            <div class="lang-it">
                                <h3 >Metrica, prosodia e musica</h3>
                                <xsl:apply-templates select="//tei:teiHeader/tei:encodingDesc/tei:metDecl" />
                            </div>
                            <div class="lang-en">
                                <h3 >Versification and music</h3>
                                <xsl:apply-templates select="//tei:teiHeader/tei:encodingDesc/tei:metDecl" />
                            </div>
                        </xsl:if>
                        <!--Previous Editions -->
                        <xsl:if test="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'previous_editions')]">
                            <h3 class="lang-en">Previous editions</h3>
                            <h3 class="lang-it">Edizioni precedenti</h3>
                            <xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'previous_editions')]" />
                        </xsl:if>
                        <!-- Analyisis of the Manuscript Tradition-->
                        <xsl:if test="//tei:teiHeader/tei:encodingDesc/tei:editorialDecl[contains(@xml:lang,'en')]">
                            <div class="lang-en">
                                <h3 >Analysis of the manuscript tradition</h3>
                                <xsl:apply-templates select="//tei:teiHeader/tei:encodingDesc/tei:editorialDecl[contains(@xml:lang,'en')]" />
                            </div>
                        </xsl:if>
                        <xsl:if test="//tei:teiHeader/tei:encodingDesc/tei:editorialDecl[contains(@xml:lang,'it')]">
                            <div class="lang-it">
                                <h3 >Analisi della tradizione manoscritta</h3>
                                <xsl:apply-templates select="//tei:teiHeader/tei:encodingDesc/tei:editorialDecl[contains(@xml:lang,'it')]" />
                            </div>
                        </xsl:if>
                        <!-- Essential Bibliography -->
                        <xsl:if test="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'essential_bibliography')]">
                            <h3 class="lang-en">Essential Bibliography</h3>
                            <h3 class="lang-it">Essential Bibliography</h3>
                            <div>
                                <xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl[contains(@type,'essential_bibliography')]" />
                            </div>
                        </xsl:if>
                    </div>
                </div>
    
                <div id="page2" class="tab-pane">
                    <!-- Historical Context-->
                    <xsl:if test="//tei:back/tei:div[contains(@type,'historical') and contains(@xml:lang,'en')]">
                        <div class="lang-en">
                        <h3 >Historical context and dating</h3>
                        <xsl:apply-templates select="//tei:back/tei:div[contains(@type,'historical') and contains(@xml:lang,'en')]" />
                        </div>
                    </xsl:if>
                    <xsl:if test="//tei:back/tei:div[contains(@type,'historical') and contains(@xml:lang,'it')]">
                        <div class="lang-it"><h3>Contesto storico e datazione</h3>
                        <xsl:apply-templates select="//tei:back/tei:div[contains(@type,'historical') and contains(@xml:lang,'it')]" />
                        </div>
                    </xsl:if>
                </div>
                    </div>
                </div>
            </div>
                <div data-spy="affix" data-offset-top="0" data-offset-bottom="50">
                    <ul class="nav nav-tabs tabbable invert" id="pageSelector">
                        <li><a href="#page1" data-toggle="tab">Text</a></li>
                        <li><a href="#page2" data-toggle="tab">About the text</a></li>
                        <li class="pull-right" id="langs">
                            <div class="form-inline row">
                                <div class="form-group">
                                    <label class="control-label col-sm-4">Language            </label>
                                    <div id="langs-toggle-buttons" class="col-sm-8"> 
                                        <div class="btn-group langs" data-toggle="buttons">
                                                <label class="btn btn-default" data-toggle="en">
                                                    <input type="radio" id='select-lang-en' name="lang" /><img class="flag" src='../en.png'/>En
                                                </label>
                                            <label class="btn btn-default" data-toggle="it">
                                                <input type="radio" id='select-lang-it' name="lang" /><img class="flag" src='../it.png'/>It
                                            </label>
                                        </div>
                                    </div>
                                    
                                </div>                     
                                
                            </div>
                        </li>
                    </ul>
                    
                </div>
            </body>
        </html>

    </xsl:template>


<xsl:template match="tei:head"/><!-- removes all redundant head fields -->

    <xsl:template match="//tei:text/tei:body"><!-- This holds the poetry itself -->
        <div class="poem-container">
            <div class="row">
                <div class="ol-xs-10 col-xs-offset-2 col-sm-offset-0 col-sm-6 ">

                        <div class="text-top-spacing">

                        </div>
                    
                        <div id="top-lhs" >
                            <div id="fro" class="lang-fro poem text " >
                                <xsl:apply-templates  select="tei:div[contains(@type,'text')]"/>
                            </div>
                        </div>
                    
                </div>
                <div class="ol-xs-10 col-xs-offset-2 col-sm-offset-0 col-sm-6">
                    <div class="text-top-spacing"><div id="switcher" class="btn-group">
                            <a class="btn btn-default active"  role="menuitem" tabindex="2" id="showTranslation"  href="translation" data-toggle="tab" >Translation</a>
                            <a class="btn btn-default" role="menuitem" tabindex="1" id="showNotes" href="notes" data-toggle="tab">Notes</a>
                        </div>
                      
                    </div>
                    
                    <div id="top-rhs">
                        <div class="translations">
                            <xsl:for-each select="tei:div[contains(@type,'translation')]">
                                <div id="{translate(@xml:id,'.','-')}" class="lang-{@xml:lang} translation text  ">
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                        </div>
                        <div id="notes-container" style="display:none;" >
    
                            <div class="lang-en" >
                                <xsl:apply-templates select="//tei:back/tei:div[contains(@type,'notes') and contains(@xml:lang,'en')]"/>
                            </div>
    
                            <div class="lang-it">
                                <xsl:apply-templates select="//tei:back/tei:div[contains(@type,'notes') and contains(@xml:lang,'it')]"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="//tei:div/tei:lg|//tei:div[contains(@type,'stanza')]"><!-- formatting the stanzas -->
        <xsl:choose>
        <xsl:when test="@n=1">
            <p class="stanza first">
                <span class="stanza-number"><xsl:number value="@n" format="I"/></span>
                <xsl:apply-templates/>
            </p>
        </xsl:when>
        <xsl:otherwise>
             <p class="stanza">
                 <span class="stanza-number"><xsl:number value="@n" format="I"/></span>
                 <xsl:apply-templates/>
             </p>
        </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    <xsl:template match="//tei:div/tei:lg/tei:l"> <!-- formatting the lines -->
            <xsl:if test="(number(@n) mod 4 = 0)">
            	<span class="line-number muted">
                    <xsl:value-of select="@n"/>
                </span>
			</xsl:if>
        <span class="line"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:front/tei:div[contains(@type,'preface')]"/> <!-- hiding the preface -->


    <xsl:template match="//tei:hi[@rend,'italic']"><!-- keeping italics --><i><xsl:apply-templates/></i></xsl:template>
    <xsl:template match="//tei:hi[contains(@rend,'italic') and contains(@rend,'superscript')]"><!-- keeping italics -->
        <i><sup><xsl:apply-templates/></sup></i>
    </xsl:template>
    <xsl:template match="tei:back//tei:p" priority="1"><!-- working -->
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="tei:back//tei:div[@xml:lang]" priority="1"><!--working-->
        <div class="lang-{@xml:lang}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:listBibl[contains(@type,'previous_editions')]/tei:bibl">
        <xsl:apply-templates /> 
    </xsl:template>
    <xsl:template match="tei:listBibl[contains(@type,'essential_bibliography')]/tei:bibl">
        <xsl:if test="position() > 2">; </xsl:if><xsl:value-of select="tokenize(.,':')[1]" />
    </xsl:template>
 
    <xsl:template match="tei:div[contains(@type,'notes')]/tei:p[@corresp]" priority="2"><!--- needs to extract line number from here. -->
        <p class="corresp"><span class="reference"><xsl:value-of select="replace(@corresp, '#[A-Za-z\.0-9]+:\(n=([0-9]+)\)|#[A-Za-z\.0-9]+\[range\(@n=([0-9]+),@n=([0-9]+)\)\]', '$1')"/><xsl:value-of select="replace(replace(@corresp, '#[A-Za-z\.0-9]+\[range\(@n=([0-9]+)(,)@n=([0-9]+)\)\]|#[A-Za-z\.0-9]+:\(n=([0-9]+)\)', '$1$2$3'),',','-')"/></span><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="tei:hi[contains(@rend,'superscript')]">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>
    <xsl:template match="tei:hi[contains(@rend,'underline')]">
        <span class="underline"><xsl:apply-templates/></span>
    </xsl:template>

</xsl:stylesheet>
