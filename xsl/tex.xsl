<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

  <xsl:param name="tex-nbsp" select="'~'"/>
  <xsl:param name="tex-index-key-sep" select="'!'"/>
  <xsl:param name="tex-index-val-sep" select="'@'"/>

  <xsl:output encoding="UTF-8" method="text"/>

  <xsl:template name="tex-description">
    <xsl:param name="items"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-list">
      <xsl:with-param name="items" select="$items"/>
      <xsl:with-param name="list-type" select="'description'"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-itemize">
    <xsl:param name="items"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-list">
      <xsl:with-param name="items" select="$items"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-enumerate">
    <xsl:param name="items"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-list">
      <xsl:with-param name="list-type" select="'enumerate'"/>
      <xsl:with-param name="items" select="$items"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-list">
    <xsl:param name="items"/>
    <xsl:param name="list-type" select="'itemize'"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:value-of select="$prefix"/>
    <xsl:call-template name="tex-env">
      <xsl:with-param name="name" select="$list-type"/>
      <xsl:with-param name="content" select="$items"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-env">
    <xsl:param name="name"/>
    <xsl:param name="content" select="''"/>
    <xsl:param name="options" select="''"/>
    <xsl:param name="arg-1"   select="''"/>
    <xsl:param name="arglist" select="''"/>
    <xsl:param name="prefix"  select="''"/>
    <xsl:param name="suffix"  select="''"/>
    <xsl:variable name="wrapped-options">
      <xsl:choose>
	<xsl:when test="$options != ''">
	  <xsl:value-of select="concat('[', $options, ']')"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="wrapped-arg-1">
      <xsl:choose>
	<xsl:when test="$arg-1 != ''">
	  <xsl:value-of select="concat('{', $arg-1, '}')"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of 
	select="concat($prefix, '\begin{', $name, '}', $wrapped-options, 
		$wrapped-arg-1, $arglist, $newline, $content, $newline, 
		'\end{', $name, '}', $suffix)"/>
  </xsl:template>

  <xsl:template name="tex-command">
    <xsl:param name="name"/>
    <xsl:param name="options" select="''"/>
    <xsl:param name="arg-1"   select="''"/>
    <xsl:param name="arglist" select="''"/>
    <xsl:param name="prefix"  select="''"/>
    <xsl:param name="suffix"  select="''"/>
    <xsl:variable name="wrapped-options">
      <xsl:choose>
	<xsl:when test="$options != ''">
	  <xsl:value-of select="concat('[', $options, ']')"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="wrapped-arg-1">
      <xsl:choose>
	<xsl:when test="$arg-1 != ''">
	  <xsl:value-of select="concat('{', $arg-1, '}')"/>
	</xsl:when>
	<xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of 
	select="concat($prefix, '\', $name, $wrapped-options, 
		$wrapped-arg-1, $arglist, $suffix)"/>
  </xsl:template>

  <xsl:template name="tex-item">
    <xsl:param name="content"/>
    <xsl:param name="label"   select="''"/>
    <xsl:param name="sizecmd" select="''"/>
    <xsl:param name="prefix"  select="$newline"/>
    <xsl:param name="suffix"  select="$newline"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'item'"/>
      <xsl:with-param name="options">
	<xsl:if test="$label != ''">
	  <xsl:call-template name="tex-size-dispatcher">
	    <xsl:with-param name="command" select="$sizecmd"/>
	    <xsl:with-param name="content" select="$label"/>
	  </xsl:call-template>
	</xsl:if>
      </xsl:with-param>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix">
	<xsl:call-template name="tex-size-dispatcher">
	  <xsl:with-param name="command" select="$sizecmd"/>
	  <xsl:with-param name="content" select="$content"/>
	</xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-pageref">
    <xsl:param name="marker"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="''"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name"   select="'pageref'"/>
      <xsl:with-param name="arg-1"  select="$marker"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-ref">
    <xsl:param name="marker"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="''"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name"   select="'ref'"/>
      <xsl:with-param name="arg-1"  select="$marker"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-size-dispatcher">
    <xsl:param name="command" select="''"/>
    <xsl:param name="content" select="''"/>
    <xsl:param name="prefix"  select="''"/>
    <xsl:param name="suffix"  select="''"/>
    <xsl:choose>
      <xsl:when test="$command = 'scriptsize'">
	<xsl:call-template name="tex-scriptsize">
	  <xsl:with-param name="content" select="$content"/>
	  <xsl:with-param name="prefix" select="$prefix"/>
	  <xsl:with-param name="suffix" select="$suffix"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:when test="$command = 'footnotesize'">
	<xsl:call-template name="tex-footnotesize">
	  <xsl:with-param name="content" select="$content"/>
	  <xsl:with-param name="prefix" select="$prefix"/>
	  <xsl:with-param name="suffix" select="$suffix"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="tex-normalsize">
	  <xsl:with-param name="content" select="$content"/>
	  <xsl:with-param name="prefix" select="$prefix"/>
	  <xsl:with-param name="suffix" select="$suffix"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="tex-textbf">
    <xsl:param name="content"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="''"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'textbf'"/>
      <xsl:with-param name="arg-1" select="$content"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-scriptsize">
    <xsl:param name="content"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="''"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'scriptsize'"/>
      <xsl:with-param name="arg-1" select="$content"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-normalsize">
    <xsl:param name="content"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="''"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'normalsize'"/>
      <xsl:with-param name="arg-1" select="$content"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-footnotesize">
    <xsl:param name="content"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="''"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'footnotesize'"/>
      <xsl:with-param name="arg-1" select="$content"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-textit">
    <xsl:param name="content"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="''"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'textit'"/>
      <xsl:with-param name="arg-1" select="$content"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-bind">
    <xsl:param name="name"/>
    <xsl:param name="value" select="."/>
    <xsl:param name="content"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'def'"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="substring-after($name, '\')"/>
      <xsl:with-param name="arg-1" select="$value"/>
      <xsl:with-param name="prefix" select="''"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-index">
    <xsl:param name="entry"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'index'"/>
      <xsl:with-param name="arg-1" select="$entry"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-label">
    <xsl:param name="marker"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="'label'"/>
      <xsl:with-param name="arg-1" select="$marker"/>
      <xsl:with-param name="prefix" select="''"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-section">
    <xsl:param name="title"/>
    <xsl:param name="label" select="''"/>
    <xsl:param name="command" select="'section'"/>
    <xsl:param name="prefix" select="$newline"/>
    <xsl:param name="suffix" select="$newline"/>

    <xsl:call-template name="tex-command">
      <xsl:with-param name="name" select="$command"/>
      <xsl:with-param name="arg-1" select="$title"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>

    <xsl:if test="$label != ''">
      <xsl:call-template name="tex-label">
	<xsl:with-param name="marker" select="$label"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="tex-subsubsection">
    <xsl:param name="title"/>
    <xsl:param name="label"/>
    <xsl:param name="prefix" select="$newline"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-section">
      <xsl:with-param name="command" select="'subsubsection'"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="label" select="$label"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-subsection">
    <xsl:param name="title"/>
    <xsl:param name="label"/>
    <xsl:param name="prefix" select="$newline"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:call-template name="tex-section">
      <xsl:with-param name="command" select="'subsection'"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="label" select="$label"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-tabular">
    <xsl:param name="content"/>
    <xsl:param name="spec" select="''"/>
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>
    <xsl:call-template name="tex-env">
      <xsl:with-param name="name" select="'tabular'"/>
      <xsl:with-param name="content" select="$content"/>
      <xsl:with-param name="arg-1" select="$spec"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="tex-par">
    <xsl:param name="content"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:param name="suffix" select="$newline"/>
    <xsl:value-of select="concat($prefix, $content, '\\', $suffix)"/>
  </xsl:template>

</xsl:stylesheet>
