<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
    version="1.0">

  <xsl:param name="newline" select="'&#10;'"/>
  <xsl:param name="req.idn.prefix"></xsl:param>

  <xsl:include href="gentext.xsl"/>
  <xsl:include href="tex.xsl"/>
  <xsl:include href="index.xsl"/>

  <xsl:template name="newline">
    <xsl:value-of select="$newline"/>
  </xsl:template>

  <xsl:template name="decode-idn">
    <xsl:param name="str"/>
    <xsl:value-of select="substring-after($str, 'r')"/>
  </xsl:template>

  <xsl:template name="cons-req-label">
    <xsl:if test="$req.idn.prefix != ''">
      <xsl:value-of select="$req.idn.prefix"/>
    </xsl:if>
    <xsl:call-template name="decode-idn">
      <xsl:with-param name="str" select="."/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="req-idn">
    <xsl:param name="node" select="../@xml:id"/>
    <xsl:call-template name="decode-idn">
      <xsl:with-param name="str" select="$node"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-var">
    <xsl:param name="req-idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:param name="field" select="''"/>
    <xsl:variable name="resolved-field">
      <xsl:call-template name="gentext">
	<xsl:with-param name="context" select="$field"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="concat('iPicoReq', $req-idn, 
					  $resolved-field)"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-sum-var">
    <xsl:param name="idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:call-template name="cons-var">
      <xsl:with-param name="req-idn" select="$idn"/>
      <xsl:with-param name="field" select="'sum'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-sts-var">
    <xsl:param name="idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:call-template name="cons-var">
      <xsl:with-param name="req-idn" select="$idn"/>
      <xsl:with-param name="field" select="'sts'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-res-var">
    <xsl:param name="idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:call-template name="cons-var">
      <xsl:with-param name="req-idn" select="$idn"/>
      <xsl:with-param name="field" select="'res'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-use-var">
    <xsl:param name="idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:call-template name="cons-var">
      <xsl:with-param name="req-idn" select="$idn"/>
      <xsl:with-param name="field" select="'use'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-ttl-var">
    <xsl:param name="idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:call-template name="cons-var">
      <xsl:with-param name="req-idn" select="$idn"/>
      <xsl:with-param name="field" select="'ttl'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-idn-var">
    <xsl:param name="idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:call-template name="cons-var">
      <xsl:with-param name="req-idn" select="$idn"/>
      <xsl:with-param name="field" select="'idn'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="cons-pty-var">
    <xsl:param name="idn">
      <xsl:call-template name="req-idn"/>
    </xsl:param>
    <xsl:call-template name="cons-var">
      <xsl:with-param name="req-idn" select="$idn"/>
      <xsl:with-param name="field" select="'pty'"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>