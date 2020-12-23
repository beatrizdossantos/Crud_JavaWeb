

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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MStore | Login</title>
        
        <!--JQUERY-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
        
        <!--CSS-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        
        <style>
            /* BASIC */

            html {
              background-color: #007bff;
            }

            body {
              font-family: "Poppins", sans-serif;
              height: 100vh;
            }

            a {
              color: #92badd;
              display:inline-block;
              text-decoration: none;
              font-weight: 400;
            }

            h2 {
              text-align: center;
              font-size: 16px;
              font-weight: 600;
              text-transform: uppercase;
              display:inline-block;
              margin: 40px 8px 10px 8px; 
              color: #cccccc;
            }



            /* STRUCTURE */

            .wrapper {
              display: flex;
              align-items: center;
              flex-direction: column; 
              justify-content: center;
              width: 100%;
              min-height: 100%;
              padding: 20px;
            }

            #formContent {
              -webkit-border-radius: 10px 10px 10px 10px;
              border-radius: 10px 10px 10px 10px;
              background: #fff;
              padding: 30px;
              width: 90%;
              max-width: 450px;
              position: relative;
              padding: 0px;
              -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
              box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
              text-align: center;
            }

            /* TABS */

            h2.inactive {
              color: #cccccc;
            }

            h2.active {
              color: #0d0d0d;
              border-bottom: 2px solid #5fbae9;
            }

            /* FORM TYPOGRAPHY*/

            input[type=button], input[type=submit], input[type=reset]  {
              background-color: #007bff;
              border: none;
              color: white;
              padding: 15px 80px;
              text-align: center;
              text-decoration: none;
              display: inline-block;
              text-transform: uppercase;
              font-size: 13px;
              -webkit-box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
              box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
              -webkit-border-radius: 5px 5px 5px 5px;
              border-radius: 5px 5px 5px 5px;
              margin: 5px 20px 40px 20px;
              -webkit-transition: all 0.3s ease-in-out;
              -moz-transition: all 0.3s ease-in-out;
              -ms-transition: all 0.3s ease-in-out;
              -o-transition: all 0.3s ease-in-out;
              transition: all 0.3s ease-in-out;
            }

            input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover  {
              background-color: #39ace7;
            }

            input[type=button]:active, input[type=submit]:active, input[type=reset]:active  {
              -moz-transform: scale(0.95);
              -webkit-transform: scale(0.95);
              -o-transform: scale(0.95);
              -ms-transform: scale(0.95);
              transform: scale(0.95);
            }

            input[type=text] {
              background-color: #f6f6f6;
              border: none;
              color: #0d0d0d;
              padding: 15px 32px;
              text-align: center;
              text-decoration: none;
              display: inline-block;
              font-size: 16px;
              margin: 5px;
              width: 85%;
              border: 2px solid #f6f6f6;
              -webkit-transition: all 0.5s ease-in-out;
              -moz-transition: all 0.5s ease-in-out;
              -ms-transition: all 0.5s ease-in-out;
              -o-transition: all 0.5s ease-in-out;
              transition: all 0.5s ease-in-out;
              -webkit-border-radius: 5px 5px 5px 5px;
              border-radius: 5px 5px 5px 5px;
            }

            input[type=text]:focus {
              background-color: #fff;
              border-bottom: 2px solid #5fbae9;
            }

            input[type=text]:placeholder {
              color: #cccccc;
            }



            /* ANIMATIONS */

            /* Simple CSS3 Fade-in-down Animation */
            .fadeInDown {
              -webkit-animation-name: fadeInDown;
              animation-name: fadeInDown;
              -webkit-animation-duration: 1s;
              animation-duration: 1s;
              -webkit-animation-fill-mode: both;
              animation-fill-mode: both;
            }

            @-webkit-keyframes fadeInDown {
              0% {
                opacity: 0;
                -webkit-transform: translate3d(0, -100%, 0);
                transform: translate3d(0, -100%, 0);
              }
              100% {
                opacity: 1;
                -webkit-transform: none;
                transform: none;
              }
            }

            @keyframes fadeInDown {
              0% {
                opacity: 0;
                -webkit-transform: translate3d(0, -100%, 0);
                transform: translate3d(0, -100%, 0);
              }
              100% {
                opacity: 1;
                -webkit-transform: none;
                transform: none;
              }
            }

            /* Simple CSS3 Fade-in Animation */
            @-webkit-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
            @-moz-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
            @keyframes fadeIn { from { opacity:0; } to { opacity:1; } }

            .fadeIn {
              opacity:0;
              -webkit-animation:fadeIn ease-in 1;
              -moz-animation:fadeIn ease-in 1;
              animation:fadeIn ease-in 1;

              -webkit-animation-fill-mode:forwards;
              -moz-animation-fill-mode:forwards;
              animation-fill-mode:forwards;

              -webkit-animation-duration:1s;
              -moz-animation-duration:1s;
              animation-duration:1s;
            }

            .fadeIn.first {
              -webkit-animation-delay: 0.4s;
              -moz-animation-delay: 0.4s;
              animation-delay: 0.4s;
            }

            .fadeIn.second {
              -webkit-animation-delay: 0.6s;
              -moz-animation-delay: 0.6s;
              animation-delay: 0.6s;
            }

            .fadeIn.third {
              -webkit-animation-delay: 0.8s;
              -moz-animation-delay: 0.8s;
              animation-delay: 0.8s;
            }

            .fadeIn.fourth {
              -webkit-animation-delay: 1s;
              -moz-animation-delay: 1s;
              animation-delay: 1s;
            }
            /* OTHERS */

            *:focus {
                outline: none;
            } 

            #icon {
              width:60%;
            }

        </style>
        
    </head>
    <body>
        <div class="wrapper fadeInDown">
          <div id="formContent">
            <!-- Tabs Titles -->

            <!-- Title -->
            <div class="fadeIn first">
                <br>
                <h1 style="color: #007bff;">Logar-se</h1>
            </div>

            <!-- Login Form
            
            USUÁRIO PARA LOGIN: 
            EMAIL: useradm@mstore.com
            SENHA: 4321
            
            -->
            <form action="" method="post">
              <input type="text" id="login" class="fadeIn second" name="email" placeholder="Email">
              <input type="text" id="password" class="fadeIn third" name="senha" placeholder="Senha">
              <input type="submit" class="fadeIn fourth" value="Fazer Login">
            </form>
            <%
              String email = request.getParameter("email");
              String senha = request.getParameter("senha");

              String email_bd = "";
              String nome = "";
              String senha_bd = "";
              
              int i = 0;
              
            try {
                st = new Conexao().conectar().createStatement();
                rs = st.executeQuery("SELECT * FROM usuario WHERE email = '"+ email+"' and senha = '"+senha+"'");

                while(rs.next()){
                email_bd = rs.getString(2);
                senha_bd = rs.getString(3);
                nome = rs.getString(4);
                rs.last();
                i = rs.getRow();
            }
            } catch (Exception e) {
                out.println(e);
            }
            
            if ((email == "") || (senha == "")) {
                out.println("PREENCHA OS DADOS PARA EFETUAR O LOGIN!");
            } else {
                if (i>0) {
                    session.setAttribute("nome", nome);
                    response.sendRedirect("painel.jsp"); 
                }
            } 
            %>
          </div>
        </div>
    </body>
</html>
