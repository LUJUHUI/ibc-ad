<%@ page language="java" isErrorPage="true"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
</head>
<body  class="body-500">
<div id="page">
<div id="content" class="clearfix">
<div id="main">
<h1>错误信息:</h1>
<% if (exception != null) { %> <pre>
<% exception.printStackTrace(new java.io.PrintWriter(out)); %>
</pre> <% } else if (request.getAttribute("javax.servlet.error.exception") != null) { %>
<pre>
<% ((Exception)request.getAttribute("javax.servlet.error.exception"))
                                           .printStackTrace(new java.io.PrintWriter(out)); %>
</pre> <% } %>
</div>
</div>
</div>
</body>
</html>
