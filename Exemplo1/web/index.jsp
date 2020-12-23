<%-- 
    Document   : index
    Created on : 24/08/2020, 13:49:40
    Author     : Beatriz dos Santos Silva
--%>

<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
   Statement st = null;
   ResultSet rs = null;

%>

<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="css/style.css" rel="stylesheet">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AULA JAVA</title>
    </head>
    <body>
    <div id="login">
        <h3 class="text-center text-white pt-5">CRUD JAVA WEB</h3>
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form" action = "#" method="post">
                            <h3 class="text-center text-info">Login</h3>
                            <div class="form-group">
                                <label for="username" class="text-info">Email:</label><br>
                                <input type="text" name="email_usuario" id="nome_usuario" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Senha:</label><br>
                                <input type="password" name="senha_usuario" id="senha_usuario" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <input type="submit" name="submit" class="btn btn-info btn-md" value="Enviar">
                            </div>
                        </form>
                    </div>
                    <%
                            String email = request.getParameter("email_usuario");
                            String senha = request.getParameter("senha_usuario");
                            
                            String nome = "";
                            String email_bd = "";
                            String senha_bd = "";
                            
                            int i = 0;
                            
                           try {
                                 st = new Conexao().conectar().createStatement();
                                 rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '"+ email+"' and senha = '"+senha+"'");

                                 while(rs.next()){
                                   email_bd = rs.getString(3);
                                   senha_bd = rs.getString(4);
                                   nome = rs.getString(2);
                                   rs.last();
                                   i = rs.getRow();
                                 }
                           } catch (Exception e) {
                               out.println(e);
                           }

                            //int idade = Int.parseInt(request.getParameter("idade_usuario")); --> p/ converter
                            if((email == "") || (senha == "") ){
                                out.println("PREENCHA OS DADOS");
                                
                            } else {
                                if (i>0) {
                                    session.setAttribute("nome", nome);
                                    response.sendRedirect("restrita.jsp"); 
                                }
                            }
                    %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
