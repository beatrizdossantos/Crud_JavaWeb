<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--JQUERY-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        
        <!--CSS-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        
        <title>MStore | Painel de Controle</title>
        
        <!--IMPORTS-->
        <%@page import="java.sql.*"%>
        <%@page import="config.Conexao"%>
        <%@page import="com.mysql.jdbc.Driver"%>
    </head>
    <body>
        <%
           Statement st = null;
           Connection con = null;
           ResultSet rs = null; 

            String nome = (String) session.getAttribute("nome");
            
            if((nome == null)){
                session.invalidate();
                response.sendRedirect("index.jsp");                 
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
          <a class="navbar-brand" href="#">Estoque MStore | Produtos Encantados</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
              </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
              <span class="navbar-text" style="color: white; font-weight: bold;">Seja bem-vindo, <%out.print(nome);%></span>&nbsp&nbsp
              <a href="sair.jsp" class="btn btn-outline-light my-2 my-sm-0" type="submit">SAIR</a>
            </form>
          </div>
        </nav>
        
        <div class="container" style="padding-top: 30px">
            <form class="form-inline" style="padding-bottom: 30px;" method="post">
                <input class="form-control mr-sm-2" type="search" placeholder="Pesquise um produto" aria-label="Search" name="txtBuscar">
                <button class="btn btn-outline-primary my-2 my-sm-0" name="btnBuscar" type="submit">Pesquisar</button>
            </form>
            
            <table class="table table-hover">
                <thead class="thead-dark bg-primary">
                    <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Catgoria</th>
                    <th scope="col">Marca</th>
                    <th scope="col">Quantidade em Estoque</th>
                    <th scope="col">Preço Unitário</th>
                    <th scope="col">Opções</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    try {
                        st = new Conexao().conectar().createStatement();
                        
                        if (request.getParameter("btnBuscar") == null) {
                            rs = st.executeQuery("SELECT * FROM Produtos");
                        } else {
                            String busca = "%" + request.getParameter("txtBuscar") + "%";
                            rs = st.executeQuery("SELECT * FROM Produtos WHERE Nome LIKE '" + busca + "'");
                        }
                        
                        while(rs.next()) {

                 %>
                    
                  <tr class="table-info">
                    <th scope="row" class="table-info"><%= rs.getString(1)%></th>
                    <td class="table-info"><%= rs.getString(2)%></td>
                    <td class="table-info"><%= rs.getString(3)%></td>
                    <td class="table-info"><%= rs.getString(4)%></td>
                    <td class="table-info"><%= rs.getString(5)%></td>
                    <td class="table-info"><%= rs.getString(6)%></td>
                    <td class="table-info">
                        <a href="painel.jsp?funcao=atualizar&id=<%= rs.getString(1)%>" type="button" class="btn btn-primary">Editar</a>
                        <a href="painel.jsp?funcao=excluir&id=<%= rs.getString(1)%>" type="button" class="btn btn-dark">Deletar</a>
                    </td>
                  </tr>
                          
                  <%
                       }
                    } catch (Exception e) {
                        out.print(e);     
                    } 
                  %>
                </tbody>
            </table> 
                
            <!-- Button trigger modal -->
            <a href=restrita.jsp?funcao=novo" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Novo Produto</a>
                
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
          String categoria_edit = "";
          String marca_edit = "";
          String qtde_edit = "" ;
          String preco_edit = "" ;
              
          if(request.getParameter("funcao") != null &&request.getParameter("funcao").equals("atualizar")){ 
            titulo = "Alterar Dados do Produto";
            tituloBtn = "Alterar";
            btn = "atualizar-btn";
            out.print("<script>$('#exampleModal').modal('show');</script>");
            
            try {
                st = new Conexao().conectar().createStatement();
                rs = st.executeQuery("SELECT * FROM Produtos WHERE id = '" + id_edit + "'");
                
                while (rs.next()) {
                nome_edit = rs.getString(2);
                categoria_edit = rs.getString(3);
                marca_edit = rs.getString(4);
                qtde_edit = rs.getString(5);
                preco_edit = rs.getString(6);
                }
                
            } catch (Exception e) {

            }
          } else  {
            titulo = "Cadastro de Novo Produto";
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
           <div class="form-group">
            <label for="exampleInputEmail1">Nome</label>
            <input type="text" value="<%=nome_edit %>" name="nome" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Nome">
          </div>
          <div class="form-group">
            <label for="exampleInputEmail1">Categoria</label>
            <input type="text" value="<%=categoria_edit %>" name="categoria" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Categoria">
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">Marca</label>
            <input type="text" value="<%=marca_edit %>" name="marca" class="form-control" id="exampleInputPassword1" placeholder="Marca">
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">Quantidade no Estoque</label>
            <input type="text" value="<%=qtde_edit %>" name="qtde" class="form-control" id="exampleInputPassword1" placeholder="Quantidade">
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">Preço Unitário</label>
            <input type="text" value="<%=preco_edit %>" name="preco" class="form-control" id="exampleInputPassword1" placeholder="Preço">
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-dark" data-dismiss="modal">Cancelar</button>
        <button type="submit" name="<%=btn%>" class="btn btn-primary"><%out.print(tituloBtn);%></button>
      </div>
    </form>
    </div>
  </div>
</div>

<!--CADASTRAR PRODUTO -->
<%
 if(request.getParameter("salvar-btn") != null) {
     String nome_nv = request.getParameter("nome");
     String categoria_nv = request.getParameter("categoria");
     String marca_nv = request.getParameter("marca");
     String qtde = request.getParameter("qtde"); 
     String preco = request.getParameter("preco");
     
    try{
        int qtde_nv = Integer.parseInt(qtde); 
        double preco_nv = Double.parseDouble(preco);
        
        st = null;
        st = new Conexao().conectar().createStatement();
       
        //Inserir
        st.executeUpdate("INSERT INTO Produtos (Nome, Categoria, Marca, QtdeEstoque, PrecoUnidade)" 
        + "VALUES ( '" + nome_nv + "', '" + categoria_nv + "', '" + marca_nv + "', '" + qtde_nv + "', '" + preco_nv + "')");
        response.sendRedirect("painel.jsp");
        
    } catch (Exception e) {
        out.print(e);
    }
 }
%>

<!--ATUALIZAR PRODUTO -->
<%
 if(request.getParameter("atualizar-btn") != null) {
     String id = request.getParameter("id");
     String nome_nv = request.getParameter("nome");
     String categoria_nv = request.getParameter("categoria");
     String marca_nv = request.getParameter("marca");
     String qtde = request.getParameter("qtde"); 
     String preco = request.getParameter("preco");
     
    try{
        int qtde_nv = Integer.parseInt(qtde); 
        double preco_nv = Double.parseDouble(preco);
        
        st = new Conexao().conectar().createStatement();
        
        //Atualizar
        st.executeUpdate("UPDATE Produtos SET Nome = '" + nome_nv + "'," + " Categoria= '" + categoria_nv + "', Marca= '" + marca_nv + "', QtdeEstoque= '" + qtde_nv + "', " + "PrecoUnidade= '" + preco_nv + "' WHERE Id ='" + id + "' ");
        response.sendRedirect("painel.jsp");
        
    } catch (Exception e) {
        out.print(e);
    }
 }
%>

<!--DELETAR PRODUTO-->
<%
    if(request.getParameter("funcao")!= null && (request.getParameter("funcao").equals("excluir"))) {
        String id = request.getParameter("id");
        
        try{
           st = new Conexao().conectar().createStatement();
           st.executeUpdate("DELETE FROM Produtos WHERE Id ='" + id + "' ");
           response.sendRedirect("painel.jsp");
        
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
