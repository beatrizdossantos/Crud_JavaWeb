package config;

import java.sql.*;
import com.mysql.jdbc.Driver;
import java.sql.SQLException;

public class Conexao {
    public Connection conectar() throws SQLException { 
        try { 
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost/dbmstore?user=root&password=");
            
        } catch (ClassNotFoundException e) { 
            throw new RuntimeException (e);
        }
        
    }
}
