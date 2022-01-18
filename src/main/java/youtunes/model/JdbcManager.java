package youtunes.model;

import java.util.Hashtable;
import java.util.ArrayList;
import java.util.Enumeration;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcManager 
{
	private String jdbcURL = "";
	private String jdbcUserName = "";
	private String jdbcPassword = "";

	public void setDbURL(String jdbcURL) 
	{
		this.jdbcURL = jdbcURL;
    }
	public String getDbURL() 
  	{
		return jdbcURL;
    }

	public void setDbUserName(String jdbcUserName) 
	{
		this.jdbcUserName = jdbcUserName;
    }
	public String getDbUserName() 
	{
		return jdbcUserName;
    }

	public void setDbPassword(String jdbcPassword) 
  	{
		this.jdbcPassword = jdbcPassword;
    }
	public String getDbPassword()
	{
		return jdbcPassword;
    }

	public Connection getConn() 
	{
	    Connection conn = null;
	    try 
	    {
	    	conn = DriverManager.getConnection(getDbURL(), getDbUserName(), getDbPassword());
	    	System.out.println("Successfully Connected to DB.");
	    }
	    catch (SQLException e) 
	    {
	    	System.out.println("Could not connect to DB: " + e.getMessage());
	    }
	    return conn;
    }
	
	public void closeConn(Connection conn) 
	{
		if (conn != null) 
		{
			try { conn.close(); }
			catch (SQLException e) { }
		}
    }
}
