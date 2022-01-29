package youtunes;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import youtunes.beans.Album;
import youtunes.model.JdbcAlbumDao;
import youtunes.model.JdbcManager;


/**
 * Servlet implementation class DiscoverServlet
 */
@WebServlet(name = "DiscoverServlet", urlPatterns = {"/discover/*"})
public class DiscoverServlet extends javax.servlet.http.HttpServlet
implements javax.servlet.Servlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DiscoverServlet() {
        super();
    }
    
    public void init(ServletConfig config) throws ServletException {
        System.out.println("*** initializing controller servlet.");
        super.init(config);
        
        ServletContext context = config.getServletContext();
        
        //Initialize a Database Connection Parameters
        JdbcManager dataManager = new JdbcManager();
        dataManager.setDbURL(config.getInitParameter("dbURL"));
        dataManager.setDbUserName(config.getInitParameter("dbUserName"));
        dataManager.setDbPassword(config.getInitParameter("dbPassword"));
        
        Connection connection = dataManager.getConn();

        context.setAttribute("dataManager", dataManager);
		context.setAttribute("base", config.getInitParameter("base"));
        context.setAttribute("imageURL", config.getInitParameter("imageURL"));
        
        try {  // load the database JDBC driver
          Class.forName(config.getInitParameter("jdbcDriver"));
          }
        catch (ClassNotFoundException e) {
          System.out.println(e.toString());
          }
        }
    	
    	
        

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Handle Navigation
		String base = "/jsp/";
	    String url = base + "index.jsp";
	    String action = request.getParameter("action");
	    if (action != null) {
	        switch (action) {
	        case "aboutUs":
	          url = base + "About.jsp";
	          break;
	        case "contactUs":
		          url = base + "Contact.jsp";
		          break;
	        case "newAlbum":
				url = base + "albums/New.jsp";
				break;
	        case "createAlbum":
				createAlbum(request, response);
				url = base + "index.jsp";
				break;
	        default:
	            url = base + "index.jsp";
	          break;
	        }
	      }
	    RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(url);
	    requestDispatcher.forward(request, response);
	}
	
	private void createAlbum(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String title = request.getParameter("title");
		String releaseYear = request.getParameter("release");
		String price = request.getParameter("price");
		String genre = request.getParameter("genre");
		String imgUrl = request.getParameter("img_url");
		String artistId = request.getParameter("artist");
		
		Album newAlbum = new Album(); 
		newAlbum.setAlbumTitle(title);
		newAlbum.setReleaseYear(Integer.parseInt(releaseYear));
		newAlbum.setPrice(Double.parseDouble(price));
		newAlbum.setGenre(genre);
		newAlbum.setImgUrl(imgUrl);
		newAlbum.setArtistID(Integer.parseInt(artistId));
		
		JdbcAlbumDao albumDao = new JdbcAlbumDao(); 
		albumDao.add(newAlbum);
		
		System.out.println(newAlbum.toString());
	}
}
