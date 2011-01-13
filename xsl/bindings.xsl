<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
    version="1.0">

  <xsl:include href="common.xsl"/>

  <xsl:output encoding="UTF-8" method="text"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="//srs:req" mode="tex-bind"/>
  </xsl:template>

  <xsl:template match="srs:req" mode="tex-bind">
    <xsl:apply-templates select="@*|srs:*" mode="tex-bind"/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="@xml:id" mode="tex-bind">
    <xsl:variable name="var">
      <xsl:call-template name="cons-idn-var"/>
    </xsl:variable>
    <xsl:variable name="val">
      <xsl:call-template name="decode-idn">
	<xsl:with-param name="str" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="tex-bind">
      <xsl:with-param name="name" select="$var"/>
      <xsl:with-param name="value" select="$val"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@pty" mode="tex-bind">
    <xsl:variable name="var">
      <xsl:call-template name="cons-pty-var"/>
    </xsl:variable>
    <xsl:call-template name="tex-bind">
      <xsl:with-param name="name" select="$var"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:ttl" mode="tex-bind">
    <xsl:variable name="var">
      <xsl:call-template name="cons-ttl-var"/>
    </xsl:variable>
    <xsl:call-template name="tex-bind">
      <xsl:with-param name="name" select="$var"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@sts" mode="tex-bind">
    <xsl:variable name="var">
      <xsl:call-template name="cons-sts-var"/>
    </xsl:variable>
    <xsl:call-template name="tex-bind">
      <xsl:with-param name="name" select="$var"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@res" mode="tex-bind">
    <xsl:variable name="var">
      <xsl:call-template name="cons-res-var"/>
    </xsl:variable>
    <xsl:call-template name="tex-bind">
      <xsl:with-param name="name" select="$var"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:sum" mode="tex-bind">
    <xsl:variable name="var">
      <xsl:call-template name="cons-sum-var"/>
    </xsl:variable>
    <xsl:call-template name="tex-bind">
      <xsl:with-param name="name" select="$var"/>
      <xsl:with-param name="value" select="normalize-space(.)"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:*|@*" mode="tex-bind">
    <!-- Don't bind -->
  </xsl:template>

</xsl:stylesheet>