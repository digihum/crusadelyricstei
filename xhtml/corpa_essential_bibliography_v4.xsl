<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="html tei" >

	<xsl:strip-space elements="*" />

    <xsl:output method="xhtml" encoding="UTF-8" indent="yes"
        />
<!-- trying to decypher what goes on here - looks like it gets from an intermediary file -->

<xsl:template match="/list/entry" mode="fetch">
						<xsl:apply-templates select="document(bibtest1.html)//tei:listBibl[contains(@type,'essential_bibliography')]"  mode="pass1">
						</xsl:apply-templates>
</xsl:template>

<xsl:template match="//ul"  mode="pass1">
	                    
	<xsl:for-each-group select="li"
                    group-by="substring(.,1,1)">
	<xsl:call-template name="indexanchor"/>
		                    	
   <xsl:apply-templates select="current-group()"/>
                
	</xsl:for-each-group>

</xsl:template>


	<xsl:template match="//i" mode="textTransform">
		<i><xsl:call-template name="anchor"/>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	
	
	<xsl:template match="//ul/li"  priority="2">

				<li>
					<xsl:apply-templates mode="textTransform"/>
				</li>

	</xsl:template>
	
	<xsl:template name="anchor">
		<xsl:element name="a">
			<xsl:attribute name="name" >
				<xsl:value-of select="tokenize(.,':')[1]" />
				
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="indexanchor">
		<xsl:element name="a">
			<xsl:attribute name="name" >
				<xsl:value-of select="substring(tokenize(.,':')[1],1,1)" />
				
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

<xsl:template match="/" >
	<ul>
	<xsl:apply-templates select="." mode="pass1" />
</ul>
</xsl:template>


</xsl:stylesheet>