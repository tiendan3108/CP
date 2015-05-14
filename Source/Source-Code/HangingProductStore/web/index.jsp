<%-- 
    Document   : index
    Created on : May 14, 2015, 8:59:14 AM
    Author     : HoangNHSE61007
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="TestServlet">
            <input type="submit" value="show" name="btnTest" />
        </form>     
        <c:set var="data" value="${requestScope.DATA}"/>
        <c:if test="${not empty data}">
            <c:forEach items="data">
                <h2>${data}</h2>
            </c:forEach>
        </c:if>
    </body>
</html>
