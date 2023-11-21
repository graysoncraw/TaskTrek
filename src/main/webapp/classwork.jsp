<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<title>Using JSTL Functions</title>
</head>
	<body>
	<h3>JSTL contains()</h3>
	<c:set var="String" value="Welcome to JSTL Functions"/>
	<c:if test="${fn:contains(String, 'Functions')}">
		<p>Found Functions </p>
	</c:if>
	<c:if test="${fn:contains(String, 'FUNCTIONS')}">
		<p>Found FUNCTIONS </p>
	</c:if>
	
	<h3>JSTL containsIgnoreCase()</h3>
	<c:set var="String" value="Welcome to JSTL Functions"/>
	<c:if test="${fn:contains(String, 'Functions')}">
		<p>Found Functions </p>
	</c:if>
	<c:if test="${fn:containsIgnoreCase(String, 'FUNCTIONS')}">
		<p>Found FUNCTIONS </p>
	</c:if>
	
	<h3>JSTL endsWith()</h3>
	<c:set var="String" value="Welcome to JSP programming"/>
	<c:if test="${fn:endsWith(String, 'programming')}">
		<p>String ends with programming<p>
	</c:if>
	<c:if test="${fn:endsWith(String, 'JSP')}">
		<p>String ends with JSP<p>
	</c:if>
	
	<h3>JSTL endsWith()</h3>
	<c:set var="string1" value="This is a first String."/>
	<c:set var="string2" value="This is a <xyz>second String.</xyz>"/>
		<p>With escapeXml() Function:</p>
		<p>string-1 : ${fn:escapeXml(string1)}</p>
		<p>string-2 : ${fn:escapeXml(string2)}</p>
		
		<p>Without escapeXml() Function:</p>
		<p>string-1 : ${string1}</p>
		<p>string-2 : ${string2}</p>
		
	<h3>JSTL indexOf()</h3>
	<c:set var="string1" value="It is a first String."/>
	<c:set var="string2" value="It is a <xyz>second String.</xyz>"/>
		<p>Index-1 : ${fn:indexOf(string1, "first")}</p>
		<p>Index-2 : ${fn:indexOf(string2, "second")}</p>
		
	<h3>JSTL length()</h3>
	<c:set var="str1" value="Welcome to JSP programming "/>
		<p>String-1 Length is : ${fn:length(str1)}</p>
	<c:set var="str2" value="${fn:trim(str1)}" />
		<p>String-2 Length is : ${fn:length(str2)}</p>
		<p>Final value of string is : ${str2}</p>
		
	<h3>JSTL startsWith()</h3>
	<c:set var="msg" value="The Example of JSTL fn:startsWith() Function"/>
	The string starts with "The": ${fn:startsWith(msg, 'The')}<br>
	The string starts with "Example": ${fn:startsWith(msg, 'Example')}
	
	<h3>JSTL split()</h3>
	<c:set var="str1" value="Welcome-to-JSP-Programming."/>
	<c:set var="str2" value="${fn:split(str1, '-')}" />
	<c:set var="str3" value="${fn:join(str2, ' ')}" />
		<p>String-3 : ${str3}</p>
	<c:set var="str4" value="${fn:split(str3, ' ')}" />
	<c:set var="str5" value="${fn:join(str4, '-')}" />
		<p>String-5 : ${str5}</p>
	
	<h3>JSTL toLowerCase()</h3>
	<c:set var="string" value="Welcome to JSP Programming"/>
	${string.toLowerCase()}
	
	<h3>JSTL toUpperCase()</h3>
	<c:set var="univ" value="john brown university"/>
	<c:set var="place" value="siloam springs"/>
	Hi, This is ${univ.toUpperCase()} located in ${place.toUpperCase()}.
	
	<h3>JSTL substring()</h3>
	<c:set var="string" value="This is the first string."/>
	${fn:substring(string, 5, 17)}

	
	<h3>JTSL subStringAfter()</h3>
	<c:set var="string" value="Hepsiba Vivenkanandan"/>
	${fn:substringAfter(string, "Grayson")}
	
	<h3>JTSL subStringBefore()</h3>
	<c:set var="string" value="Hepsiba Vivenkanandan"/>
	${fn:substringBefore(string, "Crawford")}
	
	<h3>JTSL length()</h3>
	<c:set var="str1" value="Greetings"/><c:set var="str2" value="Dear Class"/>
	Length of the String-1 is: ${fn:length(str1)}<br>
	Length of the String-2 is: ${fn:length(str2)}
	
	<h3>JTSL replace()</h3>
	<c:set var="str1" value="Hello"/>
	<c:set var="str2" value="Everybody here!"/>
	${fn:replace(str1, "Hello", "Hi!")}
	${fn:replace(str2, "here", "around the world")}
	
	</body>
	
	
</html>
