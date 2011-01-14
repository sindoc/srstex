<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
    version="1.0">

  <xsl:param name="req.fields.size" select="'scriptsize'"/>

  <xsl:include href="common.xsl"/>

  <xsl:output encoding="UTF-8" method="text"/>

  <xsl:template match="/srs:reqs">
    <xsl:apply-templates select="srs:req" mode="tex-index"/>
    <xsl:apply-templates select="srs:req"/>
  </xsl:template>

  <xsl:template match="srs:*|@*">
  </xsl:template>

  <xsl:template match="srs:req">    

    <xsl:apply-templates select="srs:ttl"/>

    <xsl:call-template name="format-fields">
      <xsl:with-param 
	  name="field-nodes" 
	  select="@*|srs:*[(local-name(.) != 'ttl' ) and
		           (local-name(.) != 'des' ) and
			   (local-name(.) != 'use' ) and
			   (local-name(.) != 'deps')]"/>
    </xsl:call-template>

    <xsl:apply-templates select="srs:des|srs:use|srs:deps"/>

    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="srs:ttl">
    <xsl:call-template name="tex-subsection">
      <xsl:with-param name="title">
	<xsl:call-template name="cons-ttl-var"/>
      </xsl:with-param>
      <xsl:with-param name="label">
	<xsl:call-template name="cons-idn-var"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@xml:id">
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label">
	<xsl:call-template name="gentext"/>
      </xsl:with-param>
      <xsl:with-param name="content">
	<xsl:call-template name="cons-idn-var"/>
      </xsl:with-param>
      <xsl:with-param name="sizecmd" select="$req.fields.size"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@pty">
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label">
	<xsl:call-template name="gentext"/>
      </xsl:with-param>
      <xsl:with-param name="content">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="."/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="sizecmd" select="$req.fields.size"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@sts">
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="pattern" select="'@print'"/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="."/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="sizecmd" select="$req.fields.size"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="@res">
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="pattern" select="'@print'"/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="."/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="sizecmd" select="$req.fields.size"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:sum">
    <xsl:call-template name="tex-item">
      <xsl:with-param name="label">
	<xsl:call-template name="gentext"/>
      </xsl:with-param>
      <xsl:with-param name="content">
	<xsl:call-template name="cons-sum-var"/>
      </xsl:with-param>
      <xsl:with-param name="sizecmd" select="$req.fields.size"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:des">
    <xsl:variable name="title">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:call-template name="tex-subsubsection">
      <xsl:with-param name="title" select="$title"/>
    </xsl:call-template>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="srs:use">
    <xsl:variable name="title">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:call-template name="tex-subsubsection">
      <xsl:with-param name="title" select="$title"/>
    </xsl:call-template>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="srs:deps">
    <xsl:variable name="title">
      <xsl:call-template name="gentext"/>
    </xsl:variable>
    <xsl:call-template name="tex-subsubsection">
      <xsl:with-param name="title" select="$title"/>
    </xsl:call-template>
    <xsl:apply-templates select="srs:dep" mode="tex-index"/>
    <xsl:call-template name="tex-itemize">
      <xsl:with-param name="item-nodes" select="srs:dep"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:dep">

    <xsl:variable name="dst-idn">
      <xsl:call-template name="decode-idn">
	<xsl:with-param name="str" select="@ref"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="dst-ttl-var">
      <xsl:call-template name="cons-ttl-var">
	<xsl:with-param name="idn" select="$dst-idn"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="dst-idn-var">
      <xsl:call-template name="cons-idn-var">
	<xsl:with-param name="idn" select="$dst-idn"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="dst-pageref">
      <xsl:call-template name="tex-pageref">
	<xsl:with-param name="marker" select="$dst-idn-var"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:call-template name="tex-item">
      <xsl:with-param 
	  name="content" 
	  select="concat($dst-ttl-var, $tex-nbsp, $dst-pageref)"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template name="format-fields">
    <xsl:param name="field-nodes"/>
    <!-- Maybe later, I'll make tabular fields
	 <xsl:call-template name="make-tabular-fields">
	 <xsl:with-param name="field-nodes" select="$field-nodes"/>
	 </xsl:call-template>
    -->
    <xsl:call-template name="tex-description">
      <xsl:with-param name="item-nodes" select="$field-nodes"/>
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>