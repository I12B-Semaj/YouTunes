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
	        default:
	            url = base + "index.jsp";
	          break;
	        }
	      }
	    RequestDispatcher requestDispatcher =
	      getServletContext().getRequestDispatcher(url);
	    requestDispatcher.forward(request, response);
	}

}
