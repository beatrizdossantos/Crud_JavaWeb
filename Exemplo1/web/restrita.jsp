<%-- 
    Document   : restrita
    Created on : 03/09/2020, 13:51:01
    Author     : Beatriz dos Santos Silva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--JQUERY-->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        
        <!--CSS-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        
        <title>Restrita</title>
        
        <%@page import="java.sql.*"%>
        <%@page import="config.Conexao"%>
        <%@page import="com.mysql.jdbc.Driver"%>
    </head>
    <body>
        <%
            String nome = (String) session.getAttribute("nome");
            
            if((nome == null)){
                session.invalidate();
                response.sendRedirect("index.jsp");                 
            }
        %>
        
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
          <a class="navbar-brand" href="#">CRUD JavaWeb</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                <a class="nav-link" href="#">Lista de Usuários<span class="sr-only">(current)</span></a>
              </li>
            </ul>
              <p style="color: white; font-size:20px;" class="my-2 my-sm-0">Bem vindo(a), <strong><%out.print(nome);%></strong></p>&nbsp;&nbsp;
              <a class="btn btn-outline-danger" href="logout.jsp">SAIR</a>
          </div>
        </nav>
        
        <br>
     <div class="container">
         <form class="form-inline my-2 my-lg-0" method="post">
            <input class="form-control mr-sm-2" type="search" name="txtBuscar" placeholder="Buscar" aria-label="Search">
            <button class="btn btn-outline-info my-2 my-sm-0" name="btnBuscar" type="submit">Pesquisar usuário</button>
        </form>
         <br>
        <table class="table">
          <thead class="thead-dark">
            <tr>
              <th scope="col">Id</th>
              <th scope="col">Nome</th>
              <th scope="col">Email</th>
              <th scope="col">Senha</th>
              <th scope="col">Nível</th>
              <th scope="col">Operações</th>
            </tr>
          </thead>
          <tbody>
              
        <%
            Statement st = null;
            ResultSet rs = null;
            
            try {
                st = new Conexao().conectar().createStatement();
                
                if(request.getParameter("btnBuscar") == null){
                    rs = st.executeQuery("SELECT * FROM usuarios");
                } else {
                    String busca = "%" + request.getParameter("txtBuscar") + "%";
                    rs = st.executeQuery("SELECT * FROM usuarios WHERE nome LIKE '" + busca + "'");
                }
               
                
                while(rs.next()) {
                    

         %>            
            <tr>
              <th scope="row"><%= rs.getString(1)%></th>
              <td><%= rs.getString(2)%></td>
              <td><%= rs.getString(3)%></td>
              <td><%= rs.getString(4)%></td>
              <td><%= rs.getString(5)%></td>
              <td><a href="restrita.jsp?funcao=atualizar&id=<%= rs.getString(1)%>" class="btn btn-warning">Editar</a>&nbsp;&nbsp;&nbsp;
                  <a href="restrita.jsp?funcao=excluir&id=<%= rs.getString(1)%>" class="btn btn-danger">Excluir</a></td>
            </tr>     
         <% 
                }
            } catch(Exception e) {
                out.print(e);
            }
               
        %>
          </tbody>
        </table>
                    
        <br>
        <br>
        <a href="restrita.jsp?funcao=novo" type="button" class="btn btn-info" data-toggle="modal" data-target="#exampleModal">Novo usuário</a>
     </div>
    </body>
</html>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
          
          <%
          //TÍTULO DINÂMICO PARA O MODAL
          String titulo = null;
          String btn = null;
          String tituloBtn = null;
          String id_edit = request.getParameter("id");
          String nome_edit = "";
          String email_edit = "";
          String senha_edit = "";
          String nivel_edit = "" ;
              
          if(request.getParameter("funcao") != null &&request.getParameter("funcao").equals("atualizar")){ 
            titulo = "Alterar Dados do Usuário";
            tituloBtn = "Alterar";
            btn = "atualizar-btn";
            
            try {
                st = new Conexao().conectar().createStatement();
                rs = st.executeQuery("SELECT * FROM usuarios WHERE id = '" + id_edit + "'");
                
                while (rs.next()) {
                nome_edit = rs.getString(2);
                email_edit = rs.getString(3);
                senha_edit = rs.getString(4);
                nivel_edit = rs.getString(5);
                }
                
            } catch (Exception e) {

            }
            
            
          } else  {
            titulo = "Cadastro de Novo Usuário";
            btn = "salvar-btn";
            tituloBtn = "Cadastrar";
          }
          %>
          
        <h5 class="modal-title" id="exampleModalLabel"><%out.print(titulo);%></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        
    <form id="cadastro" action="" method="post">
      <div class="modal-body">
          
          <%   
           //ATUALIZAR USUÁRIO
          if(request.getParameter("funcao") != null &&request.getParameter("funcao").equals("atualizar")){ 
              out.print("<script>$('#exampleModal').modal('show');</script>");
          }
          %>
          
           <div class="form-group">
            <label for="exampleInputEmail1">Nome</label>
            <input type="text" value="<%=nome_edit %>" name="nome" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Nome">
          </div>
          <div class="form-group">
            <label for="exampleInputEmail1">Email</label>
            <input type="email" value="<%=email_edit %>" name="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Email">
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">Senha</label>
            <input type="password" value="<%=senha_edit %>" name="senha" class="form-control" id="exampleInputPassword1" placeholder="Senha">
          </div>
          <div class="form-group">
            <label for="exampleFormControlSelect1">Nível</label>
            <select class="form-control" name="nivel" id="exampleFormControlSelect1">
                <%
                if (nivel_edit != "") {
                    out.print("<option value=" + nivel_edit +  ">" + nivel_edit + "</option>");
                }  
                                
                if(!nivel_edit.equals("comum")){
                    out.print("<option>comum</option>");
                } 
                if (!nivel_edit.equals("top")){
                    out.print("<option>top</option>");
                }
                %>
            </select>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
        <button type="submit" name="<%=btn%>" class="btn btn-info"><%out.print(tituloBtn);%></button>
      </div>
    </form>
    </div>
  </div>
</div>

<!--CADASTRO DE USUÁRIO -->
<%
 if(request.getParameter("salvar-btn") != null) {
     String nome_nv = request.getParameter("nome");
     String email_nv = request.getParameter("email");
     String senha_nv = request.getParameter("senha");
     String nivel_nv = request.getParameter("nivel");   
     
    try{
        st = null;
        st = new Conexao().conectar().createStatement();
        
        //Validar email
        rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '" + email_nv + "' ");
        while(rs.next()) {
            rs.getRow(); //quantidade de registros
            if(rs.getRow() > 0) {
                out.print("<script>alert('Este email não está disponível, tente inserir um outro!');</script>");
                return;
            }
        }
        
        //Inserir
        st.executeUpdate("INSERT INTO usuarios (nome, email, senha, nivel)" 
        + "VALUES ( '" + nome_nv + "', '" + email_nv + "', '" + senha_nv + "', '" + nivel_nv + "')");
        response.sendRedirect("restrita.jsp");
        
    } catch (Exception e) {
        out.print(e);
    }
 }
%>

<!--EXCLUSÃO DE USUÁRIO -->
<%
    if(request.getParameter("funcao") != null && (request.getParameter("funcao").equals("excluir"))) {
        String id = request.getParameter("id");
        try{
           st = new Conexao().conectar().createStatement();
           st.executeUpdate("DELETE FROM usuarios WHERE id = '" + id + "' ");
           response.sendRedirect("restrita.jsp");
        
        } catch (Exception e) {
            out.print(e);
        }
            
    }

%>

<!--ATUALIZAÇÃO DE USUÁRIO -->
<%
 if(request.getParameter("atualizar-btn") != null) {
     String id = request.getParameter("id");
     String nome_nv = request.getParameter("nome");
     String email_nv = request.getParameter("email");
     String senha_nv = request.getParameter("senha");
     String nivel_nv = request.getParameter("nivel");   
     
    try{
        st = new Conexao().conectar().createStatement();
        
        //Validar email
        rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '" + email_nv + "' ");
        while(rs.next()) {
            rs.getRow(); //quantidade de registros
            if(rs.getRow() > 1) {
                out.print("<script>alert('Este email não está disponível, tente inserir um outro!');</script>");
                return;
            }
        }
        
        //Inserir
        st.executeUpdate("UPDATE usuarios SET nome = '" + nome_nv + "'," + " email= '" + email_nv + "', senha= '" + senha_nv + "', " + "nivel= '" + nivel_nv + "' WHERE id ='" + id + "' ");
        response.sendRedirect("restrita.jsp");
        
    } catch (Exception e) {
        out.print(e);
    }
 }
%>