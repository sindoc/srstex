<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:srs="http://sina.khakbaz.com/2011/01/srs/ns"
    version="1.0">

  <xsl:param name="req.fields.size" select="'footnotesize'"/>

  <xsl:include href="common.xsl"/>
  <xsl:include href="io.xsl"/>

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

  <xsl:template match="srs:par">
    <xsl:call-template name="tex-par">
      <xsl:with-param name="content">
	<xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:itm">
    <xsl:if test="srs:par">
      <xsl:message terminate="yes">
	<xsl:text>Multiple paragraphs are not allowed in item</xsl:text>
      </xsl:message>
    </xsl:if>
    <xsl:call-template name="tex-item">
      <xsl:with-param name="content">
	<xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:ols">
    <xsl:call-template name="tex-enumerate">
      <xsl:with-param name="items">
	<xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:uls">
    <xsl:call-template name="tex-itemize">
      <xsl:with-param name="items">
	<xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:des">
    <xsl:call-template name="tex-subsubsection">
      <xsl:with-param name="title">
	<xsl:call-template name="gentext"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="srs:use">
    <xsl:call-template name="tex-subsubsection">
      <xsl:with-param name="title">
	<xsl:call-template name="gentext"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="srs:deps">
    <xsl:call-template name="tex-subsubsection">
      <xsl:with-param name="title">
	<xsl:call-template name="gentext"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates select="srs:dep" mode="tex-index"/>
    <xsl:call-template name="tex-itemize">
      <xsl:with-param name="items">
	<xsl:apply-templates select="srs:dep"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:dep">

    <xsl:variable name="dst-idn">
      <xsl:call-template name="decode-idn">
	<xsl:with-param name="str" select="@ref"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="dst-idn-var">
      <xsl:call-template name="cons-idn-var">
	<xsl:with-param name="idn" select="$dst-idn"/>
      </xsl:call-template>      
    </xsl:variable>

    <xsl:call-template name="tex-item">
      <xsl:with-param name="content">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="key" select="@ref"/>
	  <xsl:with-param 
	      name="pattern" 
	      select="'Noun@custom-i~(@custom-ii PageNr@custom-iii)'"/>
	  <xsl:with-param name="custom-i">
	    <xsl:call-template name="cons-ttl-var">
	      <xsl:with-param name="idn" select="$dst-idn"/>
	    </xsl:call-template>
	  </xsl:with-param>
	  <xsl:with-param name="custom-ii">
	    <xsl:call-template name="tex-ref">
	      <xsl:with-param name="marker" select="$dst-idn-var"/>
	    </xsl:call-template>
	  </xsl:with-param>
	  <xsl:with-param name="custom-iii">
	    <xsl:call-template name="tex-pageref">
	      <xsl:with-param name="marker" select="$dst-idn-var"/>
	    </xsl:call-template>
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="srs:lnk">
    <xsl:variable name="dst-idn">
      <xsl:call-template name="decode-idn">
	<xsl:with-param name="str" select="@ref"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="dst-idn-var">
      <xsl:call-template name="cons-idn-var">
	<xsl:with-param name="idn" select="$dst-idn"/>
      </xsl:call-template>      
    </xsl:variable>
    
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="@ref"/>
      <xsl:with-param name="pattern" select="'Noun@custom-i~``Noun@custom-ii&quot;~(@custom-iii PageNr@custom-iv)'"/>
      <xsl:with-param name="custom-i">
	<xsl:call-template name="gentext">
	  <xsl:with-param name="context" select="'req'"/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="custom-ii">
	<xsl:call-template name="cons-ttl-var">
	  <xsl:with-param name="idn" select="$dst-idn"/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="custom-iii">
	<xsl:call-template name="tex-ref">
	  <xsl:with-param name="marker" select="$dst-idn-var"/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="custom-iv">
	<xsl:call-template name="tex-pageref">
	  <xsl:with-param name="marker" select="$dst-idn-var"/>
	</xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="format-fields">
    <xsl:param name="field-nodes"/>
    <xsl:if test="$field-nodes != ''">
      <xsl:call-template name="tex-description">
	<xsl:with-param name="items">
	  <xsl:apply-templates select="$field-nodes"/>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
