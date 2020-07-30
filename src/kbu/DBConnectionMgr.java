package kbu;

import java.sql.*;
import javax.naming.*;
import javax.sql.DataSource;

public class DBConnectionMgr {
    private static DBConnectionMgr instance = new DBConnectionMgr();

    public DBConnectionMgr() {
    }

    public static DBConnectionMgr getInstance() {
        return instance;
    }
    public Connection getConnection() throws Exception{ //JDNI
    Context ctx = new InitialContext();
    DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/kbubook");
        return ds.getConnection();
    }

}