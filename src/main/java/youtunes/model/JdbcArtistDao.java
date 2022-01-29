package youtunes.model;

import youtunes.beans.Artist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class JdbcArtistDao implements ArtistDao
{
	JdbcManager db = null;  
	
	public JdbcArtistDao() 
	{
		db = new JdbcManager();
	}
	
	//Method to add new artist record to database
	@Override
	public void add(Artist entity) 
	{
		Connection conn = db.getConn(); 
		Artist newArtist = entity;
		
		//Perform SQL INSERT INTO artists Table and output success or fail
		if(conn != null) 
		{
			try 
			{
				Statement stmt = conn.createStatement(); 
				String sql = "INSERT INTO artists(first_name, last_name) "
						+ "VALUES('" + newArtist.getFirstName() + "', '" + newArtist.getLastName() + "')";
				
				try
				{
					stmt.executeUpdate(sql);
					System.out.println("Inserted newArtist: {firstName=" + newArtist.getFirstName()
						+ ", lastName=" + newArtist.getLastName() + "}");
				}
				finally 
				{
					stmt.close();				
				}
			}
			catch(SQLException ex)
			{
				System.out.println("Unable to insert newArtist: {firstName="
						+ newArtist.getFirstName() + ", lastName=" + newArtist.getLastName() + "}");
				System.out.println("SQL Exception: " + ex.getMessage());
			}
		}
	}
	
	//Method to retrieve a list of all artists
	@Override
	public List<Artist> list() {
		Connection conn = db.getConn();
		ArrayList<Artist> artists = new ArrayList<Artist>();
		
		if(conn != null) 
		{
			try 
			{
				Statement stmt = conn.createStatement();
				String sql = "SELECT artist_id, first_name, last_name FROM artists";
				
				try 
				{
					ResultSet rs = stmt.executeQuery(sql);
					
					try 
					{
						while(rs.next()) 
						{
							Artist artist = new Artist();
							artist.setArtistID(rs.getInt(1));
							artist.setFirstName(rs.getString(2));
							artist.setLastName(rs.getString(3));
							artists.add(artist);
						}
					}
					finally 
					{
						rs.close();
					}
				}
				finally 
				{
					stmt.close();
				}
			}
			catch (SQLException ex)
			{
				System.out.println("Could not retrieve artists.");
				System.out.println("SQL Exception: " + ex.getMessage());
			}
			finally 
			{
				db.closeConn(conn);
			}
		}
		
		return artists;
	}
	
	//Method to retrieve an artist with artist_id
	@Override
	public Artist find(Integer key) {
		Connection conn = db.getConn(); 
		
		Artist artist = null;
		
		if (conn != null) 
		{
			try 
			{
				Statement stmt = conn.createStatement(); 
				String sql = "SELECT artist_id, first_name, last_name FROM artists WHERE artist_id =" + key;
				
				try 
				{
					ResultSet rs = stmt.executeQuery(sql);
					
					try 
					{
						if (rs.next()) 
						{
							artist = new Artist(rs.getInt(1), rs.getString(2), rs.getString(3));
						}
					}
					finally
					{
						rs.close();
					}
				}
				finally 
				{
					stmt.close();
				}				
			}
			catch (SQLException ex)
			{
				System.out.println("Could not retrieve artist.");
				System.out.println("SQL Exception: " + ex.getMessage());
			}
		}
		
		return artist;
	}
	
	//Method to update artist record with artist_id
	@Override
	public void update(Artist entity) 
	{
		Connection conn = db.getConn();
		
		if (conn != null) 
		{
			try 
			{
				Statement stmt = conn.createStatement();
				String sql = "UPDATE artists SET first_name = '" + entity.getFirstName()
					+ "', last_name = '" + entity.getLastName()
					+ "' WHERE artist_id = " + entity.getArtistID();
				
				try 
				{
					stmt.executeUpdate(sql);
					System.out.println("Updated artist: {artistID=" + entity.getArtistID() + "}");
				}
				finally
				{
					stmt.close();
				}
			}
			catch (SQLException ex)
			{
				System.out.println("Could not update artist.");
				System.out.println("SQL Exception: " + ex.getMessage());
			}
			finally 
			{
				db.closeConn(conn);
			}
		}
		
	}
	
	//Method to update artist record with artist_id
	@Override
	public void remove(Integer key) 
	{
		Connection conn = db.getConn(); 
		
		if (conn != null) 
		{
			try
			{
				Statement stmt = conn.createStatement(); 
				String sql = "DELETE FROM artists WHERE artist_id = " + key;
				
				try 
				{
					stmt.executeUpdate(sql);
					System.out.println("Deleted artist: {artistID=" + key + "}");
				}
				finally
				{
					stmt.close();
				}
			}
			catch (SQLException ex)
			{
				System.out.println("Could not delete artist.");
				System.out.println("SQL Exception: " + ex.getMessage());
			}
			finally 
			{
				db.closeConn(conn);
			}
		}
	}
}
