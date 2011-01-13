<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
    version="1.0">

  <!-- INCOMPLETE. Maybe I'll continue later  -->

  <xsl:template name="make-tabular-fields">
    <xsl:param name="field-nodes"/>
    <xsl:call-template name="tex-tabular">
      <xsl:with-param name="content">
	<xsl:apply-templates select="$field-nodes" mode="table-head"/>
	<xsl:apply-templates select="$field-nodes" mode="table-body"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@*|srs:*" mode="table-head">
  </xsl:template>
  <xsl:template match="@*|srs:*" mode="table-body">
  </xsl:template>

  <xsl:template match="@sts[../@res]" mode="table-head">
  </xsl:template>

  <xsl:template match="@res">
    <xsl:variable name="var">
      <xsl:call-template name="gentext">
	<xsl:with-param name="key" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="lbl">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label" select="$lbl"/>
      <xsl:with-param name="content" select="$var"/>
    </xsl:call-template>
  </xsl:template>

<!--
  <xsl:template match="@xml:id" mode="table-head">
    
  </xsl:template>

  <xsl:template match="@pty">
    <xsl:variable name="lbl">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:variable name="val">
      <xsl:call-template name="gentext">
	<xsl:with-param name="key" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label" select="$lbl"/>
      <xsl:with-param name="content" select="$val"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@sts">
    <xsl:variable name="val">
      <xsl:call-template name="gentext">
	<xsl:with-param name="key" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="lbl">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label" select="$lbl"/>
      <xsl:with-param name="content" select="$val"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@res">
    <xsl:variable name="var">
      <xsl:call-template name="gentext">
	<xsl:with-param name="key" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="lbl">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label" select="$lbl"/>
      <xsl:with-param name="content" select="$var"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:sum">
    <xsl:variable name="var">
      <xsl:call-template name="cons-sum-var"/>
    </xsl:variable>
    <xsl:variable name="lbl">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label" select="$lbl"/>
      <xsl:with-param name="content" select="$var"/>
    </xsl:call-template>
  </xsl:template>
-->
</xsl:stylesheet>