<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
    version="1.0">

  <xsl:output encoding="UTF-8" method="text"/>

  <xsl:template match="srs:in[not(@ref)]">
    <xsl:call-template name="io-define"/>
  </xsl:template>

  <xsl:template match="srs:out[not(@ref)]">
    <xsl:call-template name="io-define"/>
  </xsl:template>

  <xsl:template name="io-define">
    <xsl:apply-templates/>
    <xsl:value-of select="$tex-nbsp"/>
    <xsl:call-template name="io-format">
      <xsl:with-param name="ref">
	<xsl:apply-templates select="." mode="counter"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="io-format">
    <xsl:param name="ref"/>
    <xsl:call-template name="gentext">
      <xsl:with-param name="pattern" select="'(@abbr@custom-i)'"/>
      <xsl:with-param name="custom-i" select="$ref"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:in[@ref]">
    <xsl:variable name="ref" select="@ref"/>
    <xsl:call-template name="io-format">
      <xsl:with-param name="ref">
	<xsl:apply-templates 
	    mode="counter"
	    select="parent::*/preceding-sibling::*/srs:in[@name=$ref]"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:out[@ref]">
    <xsl:variable name="ref" select="@ref"/>
    <xsl:call-template name="io-format">
      <xsl:with-param name="ref">
	<xsl:apply-templates 
	    mode="counter"
	    select="parent::*/preceding-sibling::*/srs:out[@name=$ref]"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:in[not(@ref)]" mode="counter">
    <xsl:value-of 
	select="count(parent::*/preceding-sibling::*/srs:in[not(@ref)]) + 1"/>
  </xsl:template>

  <xsl:template match="srs:out[not(@ref)]" mode="counter">
    <xsl:value-of 
	select="count(parent::*/preceding-sibling::*/srs:out[not(@ref)]) + 1"/>
  </xsl:template>

  <xsl:template match="srs:lin">
    <xsl:call-template name="io-format">
      <xsl:with-param name="ref">
	<xsl:apply-templates 
	    select="parent::*/preceding-sibling::*[srs:in[not(@ref)]][1]/srs:in" 
	    mode="counter"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:lout">
    <xsl:call-template name="io-format">
      <xsl:with-param name="ref">
	<xsl:apply-templates 
	    select="parent::*/preceding-sibling::*[srs:out[not(@ref)]][1]/srs:in" 
	    mode="counter"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>