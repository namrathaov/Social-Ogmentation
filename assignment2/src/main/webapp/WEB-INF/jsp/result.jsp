<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <style>
        li:nth-child(odd)    { background-color:#1111ff; }
        li:nth-child(even)    {
            background-color: transparent; }
        .rowstyle { overflow-y: scroll; height:200px;}
    </style>
</head>


<body>
<h1>Results!</h1>

<div style="padding-bottom: 20px;">
    <% List eList = (ArrayList)request.getAttribute("recommendations");%>
    <table>
        <%
            for(int i=0; i<eList.size();i++){%>
        <tr>
            <td><div class="rowstyle"><h3>Recommendation <%=(i+1)+"\n"%></h3><%= (eList.get(i)) %></div></td>
        </tr>
        <%}%>
    </table>
</div>
<a href="<%=request.getContextPath()%>">See another query</a>
</body>
</html>