package youtunes.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import youtunes.beans.Album;

/**
 * Sprint 3
 * @author RK
 */
public class JdbcAlbumDao implements AlbumDao {

	JdbcManager db; 
	
	public JdbcAlbumDao() 
	{
		db = new JdbcManager(); 
	}
	
	@Override
	public void add(Album entity) 
	{
		Connection conn = db.getConn(); 
		Album newAlbum = entity; 
		
		if (conn != null) 
		{
			try 
			{
				Statement stmt = conn.createStatement(); 
				
				String sql = String.format("INSERT INTO albums(album_title, img_url, release_year, artist_id, genre, price) VALUES('%s', '%s', %s, %s, '%s', %s);", 
						newAlbum.getAlbumTitle(), newAlbum.getImgUrl(), newAlbum.getReleaseYear(), newAlbum.getArtistID(), newAlbum.getGenre(), newAlbum.getPrice());
				
				System.out.println(sql);
				
				try 
				{
					stmt.executeUpdate(sql);
				}
				finally { stmt.close(); }
			}
			catch (SQLException ex)
			{
				System.out.println("Unable to insert newAlbum: " + newAlbum.toString()); 
				System.out.println(ex.getMessage());
			}
		}
	}

	@Override
	public List<Album> list() 
	{
		Connection conn = db.getConn(); 
		ArrayList<Album> albums = new ArrayList<Album>();
		
		if (conn != null) 
		{
			try 
			{
				Statement stmt = conn.createStatement();
				
				String sql = "SELECT album_id, album_title, img_url, release_year, genre, price FROM albums";
				
				System.out.println(sql);
				
				try 
				{
					ResultSet rs = stmt.executeQuery(sql);
					
					try 
					{
						while (rs.next()) 
						{
							Album album = new Album();
							album.setAlbumID(rs.getInt(1));
							album.setAlbumTitle(rs.getString(2));
							album.setImgUrl(rs.getString(3));
							album.setReleaseYear(rs.getInt(4));
							album.setGenre(rs.getString(5));
							album.setPrice(rs.getDouble(6));
							albums.add(album);
						}
					}
					finally { rs.close(); }
				}
				finally { stmt.close(); }
			}
			catch (SQLException ex)
			{
				System.out.println("Could not get albums: " + ex.getMessage()); 
			}
			finally
			{
				db.closeConn(conn);
			}
		}
		
		return albums;
	}

	@Override
	public Album find(Integer key) 
	{
		Connection conn = db.getConn(); 
		
		Album album = null; 
		
		if (conn != null) 
		{
			try 
			{
				Statement stmt = conn.createStatement(); 
				
				String sql = "SELECT album_id, album_title, img_url, release_year, artist_id, genre, price FROM albums WHERE album_id = " + key;
				
				System.out.println(sql);
				
				try 
				{
					ResultSet rs = stmt.executeQuery(sql);
					
					try 
					{
						if (rs.next()) 
						{
							album = new Album(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getDouble(7)); 
						}
					}
					finally { rs.close(); }
				}
				finally { stmt.close(); }
				
			}
			catch (SQLException ex)
			{
				System.out.println("Could not get album: " + ex.getMessage());
			}
		}
		return album;
	}

	@Override
	public void update(Album entity) {
		Connection conn = db.getConn(); 
		
		Album updatedAlbum = entity; 
		
		if (conn != null) 
		{
			try {
				Statement stmt = conn.createStatement(); 
				
				String sql = String.format("UPDATE albums SET album_title = '%s', img_url = '%s', release_year = %s, artist_id = %s, genre = '%s', price = %s WHERE album_id = %s;", 
						updatedAlbum.getAlbumTitle(), updatedAlbum.getImgUrl(), updatedAlbum.getReleaseYear(), updatedAlbum.getArtistID(), updatedAlbum.getGenre(), updatedAlbum.getPrice(), updatedAlbum.getAlbumID());
				
				System.out.println(sql);
				
				try {
					stmt.executeUpdate(sql);
				} finally { stmt.close(); }
			}
			catch (SQLException ex) {
				System.out.println("Could not update album: " + updatedAlbum.toString());
				System.out.println(ex.getMessage());
			}
		}
	}

	@Override
	public void remove(Integer key) {
		Connection conn = db.getConn(); 
		
		if (conn != null) 
		{	
			try 
			{	
				Statement stmt = conn.createStatement(); 
				
				String sql = String.format("DELETE FROM albums WHERE album_id = %s", key);
				
				System.out.println(sql);
				
				try 
				{
					stmt.executeUpdate(sql);
				} 
				finally { stmt.close(); }
			} 
			catch (SQLException ex) 
			{
				System.out.println("Could not delete ablum: " + key);
				System.out.println(ex.getMessage());
			}
		}
	}
}