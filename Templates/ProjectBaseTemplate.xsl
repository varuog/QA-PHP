<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : ProjectBaseTemplate.xsl
    Created on : June 25, 2013, 7:43 AM
    Author     : Gourav Sarkar
    Description:
        It formats xml data to HTML page. All transformation will go through this
        transformation.
        
        Usage: All objects have seperate transformation file. Transformation files
        are named same as class name. To access a SCALAR type property of object
        you need to use <xsl:value-of select="PROPERTY_NAME" /> (consult object API
        for list of available property)
        Currently unavailble property does not generate any error . it just skips
        the filed. [This behaviour could be changed later so that it can show any error]
        All associated REFERENCE type property can not be accessed via 'value-of'. Appropiate
        Template should be applied there. After that thos template can access its SCALAR type data
        as usual. Basically it itereate through each associated object untill it have only 
        scalar type value which can be printed using 'value-of'.
        
         Some static classes will be availble for direct usage in XSLT page. All PHP
         class and function usage may not be optimal (Discremnation needed). Currently
         'Utility' and 'User' Class seem to like a appropiate candidate for XSLT-PHP
         function registering 
         
         @see See Object specific API and XSLT document for any further detailed information
         
         DEVELOPER NOTE
         same form can be used for CREATE and EDIT
         LISTING and READING Dont need form
         DELETE May or may not need form
         
         @ISSUUES Handling unmatched tags for debugging
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    
    <xsl:include  href='QuestionTemplate.xsl'/>
    <xsl:include  href='UserTemplate.xsl'/>
    <xsl:include  href='AnswerTemplate.xsl'/>
    <xsl:include  href='commentTemplate.xsl'/>
    <xsl:include  href='tagTemplate.xsl'/>
    <xsl:include  href='VoteTemplate.xsl'/>
    <xsl:include  href='staticTemplate.xsl'/>
    
    
    <xsl:template match="page">
        <xsl:choose>
            <xsl:when test="current()/@mode='FRAGMENT'">
            <xsl:call-template name="document-fragment"></xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="document"></xsl:call-template>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!--
    # Core page structure
    -->
    <xsl:template name="document">
        <html>
            <head>
                <title>
                    <!-- <xsl:apply-templates match="/" /> -->
                </title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <!-- Bootstrap -->
                <link href="/Bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
            </head>
            <body>
                <!-- Header -->
                <xsl:call-template name="pageHeader"></xsl:call-template>
                
                <!--Content -->
                
                <section class="row-fluid">
                    <xsl:choose>
                        <xsl:when test="/page/@static!=''">
                            <xsl:apply-templates select="page" mode="static"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates />
                        </xsl:otherwise>
                    </xsl:choose>
                </section>
    
                <!-- footer -->
                <xsl:call-template name="pageFooter"></xsl:call-template>
            </body>
        </html>
    </xsl:template>
    <!-- ========================================================================-->
    
    
    <xsl:template name="document-fragment">
        <xsl:apply-templates />
    </xsl:template>
    
    <!--
    # Global Page header
    # It is an application specific header. Which means in one application there
    # would be this header in all pages
    -->
    <xsl:template name="pageHeader">
        
    <div class="navbar navbar-inverse navbar-static-top">

    <div class="row-fluid container-fluid">
        <div class="span4">
            <h1>StackOverflow</h1>
        </div>
        <div class="offset3 span1">
            <div class="btn-group">
                <a class="btn btn-medium btn-info dropdown-toggle" data-toggle="dropdown" href="#">
                    Action
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="?module=question&amp;action=ask">Write Article</a></li>
                    <li><a href="?module=question&amp;action=ask">Ask Question</a></li>
                    <li><a href="?module=question&amp;action=ask">Give Answer</a></li>
                    <li><a href="?module=question&amp;action=ask">Add File</a></li>
                </ul>

                <div class="switch switch-small">
            <input type="checkbox" />
        </div>
            </div>
             
        </div>
        <div class="span4">
            <ul class="nav">
                <!-- <?php if (User::getActiveUser()): ?> -->
                    <li><img src='/image/avatar/avatar.jpg' style="width:40px;height:40px;" class="img-polaroid"/></li>
                    <li>
                        <a data-toggle="modal" href="#">nick</a>
                    </li>
                <!-- <?php else: ?> -->
                    <li><a href="?static=staticUserLogin">Login</a></li>
                <!-- <?php endif; ?> -->

                <li><a href='#'><i class="icon-globe"></i></a></li>
                <li><a href='#'><i class="icon-bell"></i></a></li>
                <li><a href='#'><i class="icon-envelope"></i></a></li>
            </ul>
        </div>

    </div>
    </div>
    <hr/>
    </xsl:template>
    <!-- ========================================================================-->
    
    
    
    
    <!--
    # Global Page footer 
    # Just like Global page header. It will be used in all pages in one applicatiomn
    # as a footer
    -->
    <xsl:template name="pageFooter">
        <script src="/jquery/jquery-min.js"></script>
        <script src="/Bootstrap/js/bootstrap.min.js"></script>
        <script src="/Bootstrap/js/bootstrapSwitch.js"></script>
        <script src="js/stackoverflow.js"></script>
    </xsl:template>
    
    <!-- ========================================================================-->
    
    
    <!-- 
    GET link
    @PARAM currentNode Either a node or a string represnting node name
    @PARAM action String 
    -->
    <xsl:template name="getLink">
        
        <xsl:param name="currentNode" select="."/>
        <xsl:param name="action"/>
        <xsl:param name="module"></xsl:param>
        
        <!-- IF currentNode is string Dont add id part and use string directly-->
        <xsl:choose>
            <xsl:when test="string($module)!=''">
                <xsl:text>?module=</xsl:text><xsl:value-of select="$module" />
                <xsl:text>&amp;action=</xsl:text><xsl:value-of select="$action" />
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:text>? module=</xsl:text>
            <xsl:value-of select="local-name($currentNode)" />
            <xsl:text>&amp;</xsl:text><xsl:value-of select="local-name($currentNode)" />=<xsl:value-of select="$currentNode/id" />
            <xsl:text>&amp;action=</xsl:text><xsl:value-of select="$action" />
            
            <xsl:if test="local-name($currentNode/dependency) ='dependency'">
                <xsl:for-each select="$currentNode/dependency">
                    <xsl:text>&amp;</xsl:text> <xsl:value-of select="local-name(.)" /> = <xsl:value-of select="$currentNode/dependency" />
                </xsl:for-each>
            </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
            
    </xsl:template>
    
    <!-- Get anchor --> 
    <!--
    <xsl:template name="getAnchor">
        
        <xsl:param name="currentNode" select="."/>
        <xsl:param name="action"/>
           <a>
                <xsl:attribute name="href">
                <xsl:call-template name="getLink">
                    <xsl:with-param name="action">$action</xsl:with-param>
                </xsl:call-template>
                </xsl:attribute>
            <span>$action</span>
            </a>
    </xsl:template>
    -->
    
    <!-- ========================================================================-->
    
    <!-- INLINE form -->
    <xsl:template match="form-inline">
        <form method="post">
            
            <input type="submit" class="btn" />
            <input type="submit" class="btn" />
        </form>
    </xsl:template>
    
    
    
    
    
    <xsl:template match="node()|@*" mode="static">
        <xsl:message>
            <b>Warning 
                <xsl:value-of select="local-name()" />
            </b>
        </xsl:message>
    </xsl:template>
    
</xsl:stylesheet>
