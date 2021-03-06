<?xml version="1.0" encoding="UTF-8"?>

<!--
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" 
  xmlns:d="http://docbook.org/ns/docbook" version='1.0'>
  <!-- width specifications: inside, center, outside -->
  <!-- OVERRIDE:  inside is large to accommodate large version strings without overflowing -->
  <xsl:param name="footer.column.widths">6 8 1</xsl:param>
  <xsl:param name="fop.version"/>
  <xsl:param name="docbook.xsl.root"/>
  <!-- selects fop or fop1 for 0.20.5 / 0.93 versions of FOP -->
  <xsl:param name="fop1.extensions">
    <xsl:choose>
      <xsl:when test="$fop.version = '0.93'">1</xsl:when>
      <xsl:when test="$fop.version = '0.95'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="fop.extensions">
    <xsl:choose>
      <xsl:when test="$fop.version = '0.20.5'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <!--xsl:param name="draft.watermark.image" select="concat($docbook.xsl.root, '/images/draft.png')"/-->
  <!-- Fonts, default alignment -->
  <xsl:param name="body.font.family" select="'Times Roman'"/> <!-- standard default pdf font -->
  <!--xsl:param name="body.font.family" select="'Palatino'"/--> <!-- disable per UIMA-1051 -->
  <xsl:param name="body.font.master" select="'10.5'"/>
  <!--###################################################
                      0.93 fixups
    ################################################### -->
  <!--  Need to verify OK for 0.20.5  -->
  <xsl:attribute-set name="table.properties">
    <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="orderedlist.properties">
    <xsl:attribute name="margin-left">0.25in</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="itemizedlist.properties">
    <xsl:attribute name="margin-left">0.25in</xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
                      olink styling
    ################################################### -->
  <xsl:param name="insert.xref.page.number" select="'yes'"/>
  <xsl:param name="insert.olink.pdf.frag" select="1"/>
  <!--###################################################
                      xref (and ulink) styling
    ################################################### -->
  <xsl:attribute-set name="xref.properties">
    <xsl:attribute name="color">blue</xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
                      Monospace font size
    ################################################### -->
  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-size">
      <xsl:choose>
        <xsl:when test="processing-instruction('db-font-size')">
          <xsl:value-of select="processing-instruction('db-font-size')"/>
        </xsl:when>
        <xsl:otherwise>9.5pt</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="font-size">
      <xsl:choose>
        <xsl:when test="processing-instruction('db-font-size')">
          <xsl:value-of select="processing-instruction('db-font-size')"/>
        </xsl:when>
        <xsl:otherwise>9pt</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
                      Center figure captions
    ################################################### -->
  <xsl:attribute-set name="informalfigure.properties">
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="figure.properties">
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
                      Page margins
    ################################################### -->
  <xsl:param name="page.margin.top" select="'1cm'"/>
  <!-- region.before.extent = height of the header -->
  <xsl:param name="region.before.extent" select="'1cm'"/>
  <xsl:param name="body.margin.top" select="'1.5cm'"/>
  <xsl:param name="body.margin.bottom" select="'1.5cm'"/>
  <!-- region.after.extent = height of area where footers are printed -->
  <xsl:param name="region.after.extent" select="'1cm'"/>
  <xsl:param name="page.margin.bottom" select="'1cm'"/>
  <xsl:param name="title.margin.left">
    <xsl:choose>
      <xsl:when test="$fop.extensions != 0">-4pc</xsl:when>
      <xsl:otherwise>0pt</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="body.start.indent">
    <xsl:choose>
      <xsl:when test="$fop.extensions != 0">0pt</xsl:when>
      <xsl:otherwise>4pc</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="page.margin.inner" select="'1.3in'"/>
  <xsl:param name="page.margin.outer" select="'.70in'"/>
  <!--###################################################
                      Header
    ################################################### -->
  <!-- More space in the center header for long text -->
  <xsl:param name="header.column.widths">1 90 1</xsl:param>
  <xsl:attribute-set name="header.content.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">0em</xsl:attribute>
    <xsl:attribute name="margin-right">0em</xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
                      Custom Footer
    ################################################### -->
  <xsl:attribute-set name="footer.content.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">0em</xsl:attribute>
    <xsl:attribute name="margin-right">0em</xsl:attribute>
  </xsl:attribute-set>
  <!-- width specifications: inside, center, outside -->
  <!--xsl:param name="footer.column.widths">2 6 1</xsl:param-->
  <xsl:template name="footer.content">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>
    <xsl:variable name="Version">
      <xsl:choose>
        <xsl:when test="//d:productname">
          <xsl:value-of select="//d:productname"/>
          <xsl:text>
          </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>please define productname in your docbook file!</xsl:text>
          <!--xsl:message>No productname found</xsl:message>
              <xsl:message>
                <xsl:for-each select="ancestor-or-self::*">
                  namespace: <xsl:value-of select="namespace-uri(.)"/>
                  node-name: <xsl:value-of select="name(.)"/>
                </xsl:for-each>
              </xsl:message>
              <xsl:message>
                firstParents children: <xsl:value-of select="name(../*)"/>
                2ndParents children: <xsl:value-of select="name(../../*)"/>
                Children of docroot: <xsl:for-each select="../../*">
                  <xsl:value-of select="name(.)"/></xsl:for-each>
                children of book: <xsl:for-each select="../*">
                  <xsl:value-of select="name(.)"/></xsl:for-each>
                children of bookinfo: <xsl:for-each select="../d:bookinfo/*">
                  <xsl:value-of select="name(.)"/></xsl:for-each>
              </xsl:message-->
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="//d:releaseinfo">
          <xsl:variable name="releaseInfo" select="//d:releaseinfo"/>
          <xsl:choose>
            <xsl:when test="contains($releaseInfo, '-SNAPSHOT')">
              <xsl:value-of select="substring-before($releaseInfo, '-SNAPSHOT')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$releaseInfo"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <!-- nop -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="Title">
      <!-- <xsl:value-of select="//title"/> -->
      <xsl:apply-templates select="." mode="titleabbrev.markup"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$sequence='blank'">
        <xsl:choose>
          <xsl:when test="$double.sided != 0 and $position = 'left'">
            <xsl:value-of select="$Version"/>
          </xsl:when>
          <xsl:when test="$double.sided = 0 and $position = 'center'">
            <!-- nop -->
          </xsl:when>
          <xsl:otherwise>
            <fo:page-number/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$pageclass='titlepage'">
        <!-- nop: other titlepage sequences have no footer -->
      </xsl:when>
      <xsl:when test="$double.sided != 0 and $sequence = 'even' and $position='left'">
        <fo:page-number/>
      </xsl:when>
      <xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first') and $position='right'">
        <fo:page-number/>
      </xsl:when>
      <xsl:when test="$double.sided = 0 and $position='right'">
        <fo:page-number/>
      </xsl:when>
      <xsl:when test="$double.sided != 0 and $sequence = 'odd' and $position='left'">
        <xsl:value-of select="$Version"/>
      </xsl:when>
      <xsl:when test="$double.sided != 0 and $sequence = 'even' and $position='right'">
        <xsl:value-of select="$Version"/>
      </xsl:when>
      <xsl:when test="$double.sided = 0 and $position='left'">
        <xsl:value-of select="$Version"/>
      </xsl:when>
      <xsl:when test="$position='center'">
        <xsl:value-of select="$Title"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- nop -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--###################################################
                      Extensions
    ################################################### -->
  <!-- These extensions are required for table printing and other stuff -->
  <xsl:param name="use.extensions">1</xsl:param>
  <!-- next set to 0 for now.  1 should work but an extension fn is missing 
      see: http://sourceware.org/ml/docbook-apps/2004-q4/msg00703.html -->
  <xsl:param name="tablecolumns.extension">0</xsl:param>
  <!--###################################################
                   Paper & Page Size
    ################################################### -->
  <!-- Paper type, no headers on blank pages, no double sided printing -->
  <xsl:param name="double.sided">1</xsl:param>
  <xsl:param name="headers.on.blank.pages">0</xsl:param>
  <xsl:param name="footers.on.blank.pages">0</xsl:param>
  <!--###################################################
                   Fonts & Styles
    ################################################### -->
  <xsl:param name="hyphenate">false</xsl:param>
  <!-- Line height in body text -->
  <!--xsl:param name="line-height">1.35</xsl:param--> <!-- for palatino -->
  <xsl:param name="line-height">1.15</xsl:param> <!-- for Times Roman -->
  
  <!--###################################################
                   Tables
    ################################################### -->
  <!-- Some padding inside tables -->
  <xsl:attribute-set name="table.cell.padding">
    <xsl:attribute name="padding-left">4pt</xsl:attribute>
    <xsl:attribute name="padding-right">4pt</xsl:attribute>
    <xsl:attribute name="padding-top">4pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
  </xsl:attribute-set>
  <!-- Only hairlines as frame and cell borders in tables -->
  <!-- note that 72 pt = 1 in, and values like 0.1pt cause problems
         in FOP 0.93 but work in FOP 0.20.5 -->
  <xsl:param name="table.frame.border.thickness">.7pt</xsl:param>
  <xsl:param name="table.cell.border.thickness">.7pt</xsl:param>
  <!--###################################################
                         Labels
    ################################################### -->
  <xsl:attribute-set name="component.title.properties">
    <xsl:attribute name="border-top">
      <xsl:text>solid black 2pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="border-top">
      <xsl:text>solid black 1pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.8"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="border-top">
      <xsl:text>solid black .75pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.6"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="border-top">
      <xsl:text>solid black .5pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.4"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:choose>
        <xsl:when test="$fop.extensions != 0">-2pc</xsl:when>
        <xsl:when test="$fop1.extensions != 0">2pc</xsl:when>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.3"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:choose>
        <xsl:when test="$fop.extensions != 0">-2pc</xsl:when>
        <xsl:when test="$fop1.extensions != 0">2pc</xsl:when>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level5.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:choose>
        <xsl:when test="$fop.extensions != 0">-2pc</xsl:when>
        <xsl:when test="$fop1.extensions != 0">2pc</xsl:when>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
                      Programlistings
    ################################################### -->
  <xsl:attribute-set name="verbatim.properties">
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
    <!-- alef: commented out because footnotes were screwed because of it -->
    <!--<xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.1em</xsl:attribute>-->
    <xsl:attribute name="border-color">#444444</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-width">0.1pt</xsl:attribute>
    <xsl:attribute name="padding-top">0.5em</xsl:attribute>
    <xsl:attribute name="padding-left">0.5em</xsl:attribute>
    <xsl:attribute name="padding-right">0.5em</xsl:attribute>
    <xsl:attribute name="padding-bottom">0.5em</xsl:attribute>
    <xsl:attribute name="margin-left">0.5em</xsl:attribute>
    <xsl:attribute name="margin-right">0.5em</xsl:attribute>
  </xsl:attribute-set>
  <!-- Shade (background) programlistings -->
  <xsl:param name="shade.verbatim">1</xsl:param>
  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="background-color">#F0F0F0</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="list.block.spacing">
    <xsl:attribute name="space-before.optimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.1em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.1em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="example.properties">
    <xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.1em</xsl:attribute>
    <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
        Title information for Figures, Examples etc.
    ################################################### -->
  <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="concat($body.font.master, 'pt')"/>
    </xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">0.1em</xsl:attribute>
  </xsl:attribute-set>
  <!--###################################################
                          Misc
    ################################################### -->
  <!-- FOP 0.25 doens't support body.start.indent 
  <xsl:param name="body.start.indent">.75in</xsl:param>
   -->
  <!-- Remove "Chapter" from the Chapter titles... 
  <xsl:param name="local.l10n.xml" select="document('')"/>
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en">
      <l:context name="title-numbered">
        <l:template name="chapter" text="%n.&#160;%t"/>
        <l:template name="section" text="%n&#160;%t"/>
      </l:context>
      <l:context name="title">
        <l:template name="example" text="Example&#160;%n&#160;%t"/>
      </l:context>
    </l:l10n>
  </l:i18n>
-->
  <!-- workaround for FOP 0.20.5 switch to symbol fonts -->
  <xsl:template match="d:symbol[@role = 'symbolfont']">
    <!--xsl:message>found arrow symbol</xsl:message-->
    <fo:inline font-family="Symbol">
      <xsl:call-template name="inline.charseq"/>
    </fo:inline>
  </xsl:template>
  
  <!-- workaround to get rid of intermittent duplicate ids
       which always seem to be around the external graphics element 
       This template is identical to the original except for:
       calling out "d:" namespace and 
       changing the wrapping fo:block to ***NOT*** have a generated ID
       because the generate-id() method seems to sometimes generate 
       duplicate IDs (it's very intermittant, on a Windows machine with
       4 cores )  -->
       
  <xsl:template match="d:mediaobject[d:imageobject[@role='fo']]">
  
    <xsl:variable name="olist" select="d:imageobject|d:imageobjectco
                       |d:videoobject|d:audioobject
                       |d:textobject"/>
  
    <xsl:variable name="object.index">
      <xsl:call-template name="select.mediaobject.index">
        <xsl:with-param name="olist" select="$olist"/>
        <xsl:with-param name="count" select="1"/>
      </xsl:call-template>
    </xsl:variable>
  
    <xsl:variable name="object" select="$olist[position() = $object.index]"/>
  
    <xsl:variable name="align">
      <xsl:value-of select="$object/descendant::d:imagedata[@align][1]/@align"/>
    </xsl:variable>
  
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
  
    <fo:block> 
      <xsl:if test="$align != '' ">
        <xsl:attribute name="text-align">
          <xsl:value-of select="$align"/>
        </xsl:attribute>
      </xsl:if>
  
      <xsl:apply-templates select="$object"/>
      <xsl:apply-templates select="d:caption"/>
    </fo:block>
  </xsl:template>

  <!-- bold-italic formatting -->
  <xsl:template match="d:emphasis[@role='bold-italic']">
    <fo:inline font-weight="bold" font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
  <xsl:attribute-set name="admonition.title.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.05"/>
    </xsl:attribute>
  </xsl:attribute-set>
  <!-- Make notes display inline for 1st para -->
  <xsl:template name="nongraphical.admonition">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="child::*[1]/self::d:para">
        <fo:block id="{$id}" xsl:use-attribute-sets="nongraphical.admonition.properties">
          <fo:block>
            <fo:inline keep-with-next.within-line='always' xsl:use-attribute-sets="admonition.title.properties">
              <xsl:apply-templates select="." mode="object.title.markup"/>
              <xsl:text>: </xsl:text>
            </fo:inline>
            <xsl:apply-templates select="d:para[1]/node()"/>
          </fo:block>
          <xsl:apply-templates select="*[not(self::d:para[1])]"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="inline.monoseq">
    <xsl:param name="content">
      <xsl:call-template name="simple.xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:param>
    <fo:inline xsl:use-attribute-sets="monospace.properties">
      <xsl:call-template name="anchor"/>
      <xsl:if test="@dir">
        <xsl:attribute name="direction">
          <xsl:choose>
            <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
            <xsl:otherwise>rtl</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:copy-of select="$content" />
    </fo:inline>
  </xsl:template>
</xsl:stylesheet>

