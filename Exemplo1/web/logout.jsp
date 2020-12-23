<%-- 
    Document   : logout
    Created on : 24/09/2020, 11:33:01
    Author     : Beatriz dos Santos Silva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sair</title>
    </head>
    
    <%
        session.invalidate();
        response.sendRedirect("index.jsp");                 

    %>
</html>
