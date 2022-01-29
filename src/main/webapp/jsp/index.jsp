<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="youtunes.beans.Album"%>

<jsp:useBean id="albumDao" scope="application" class="youtunes.model.JdbcAlbumDao" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Index</title>
	<link rel="stylesheet" href="css/mainSite.css" />
	<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<%@include file="TopNav.jsp" %>
	<div class="wrapper middle">
		<h1>Discover</h1>
		<h2>News &#38; Announcements</h2>
		
		<div id="slideshow-wrapper">
			<div class="mySlides">
	    		<h3><b>Announcement 1</b></h3>
	    		<h4><i>News about newly released album.</i></h4>
	  		</div>
	  		<div class="mySlides">
	    		<h3><b>Announcement 2</b></h3>
	    		<h4><i>News about an upcoming concert.</i></h4>
	  		</div>
	  		<div class="mySlides">
	    		<h3><b>Announcement 3</b></h3>
	    		<h4><i>News about an up and coming artist.</i></h4>
	  		</div>
	
	    	<button class="btn btn-sm btn-outline-secondary" onclick="plusDivs(-1)">&#8592; Prev</button>
	    	<button class="btn btn-sm btn-outline-secondary" onclick="plusDivs(1)">Next &#8594;</button>
	    	<br>
		  	<button class="demo btn btn-sm btn-outline-secondary" onclick="currentDiv(1)">1</button> 
		  	<button class="demo btn btn-sm btn-outline-secondary" onclick="currentDiv(2)">2</button> 
		  	<button class="demo btn btn-sm btn-outline-secondary" onclick="currentDiv(3)">3</button>
		</div>
		<h2>Albums</h2>
		<div class="album py-5 bg-light">
			<div class="container">
		
		    	<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
		    		<%
						List<Album> albums = albumDao.list();
						Iterator<Album> iterator = albums.iterator();
						while (iterator.hasNext())
						{
							Album album = (Album)iterator.next();
					%>
			        <div class="col">
			          	<div class="card shadow-sm">
			            	<img src="/youtunes/<%=album.getImgUrl()%>" height="300" class="card-img-top" />
			            	<div class="card-body">
			              		<p class="card-text">
									<span><%=album.getAlbumTitle()%></span>
									<br />
									<small class="text-muted"><em><%=album.getGenre()%></em></small>
								</p>
			              <div class="d-flex justify-content-between align-items-center">
			                <div class="btn-group">
			                  	<a href="discover?action=albumDetails&albumId=<%=album.getAlbumID()%>" class="btn btn-sm btn-outline-secondary">Edit</a>
								<a href="discover?action=deleteAlbum&albumId=<%=album.getAlbumID()%>" class="btn btn-sm btn-outline-secondary">Delete</a>
			                </div>
			                <small class="text-muted">$<%=album.getPrice()%></small>
			              </div>
			            </div>
			          </div>
			        </div>
			        <% } %>
		    	</div>
			</div>
		</div>
	</div>
	<%@include file="Footer.jsp" %>
	<%@include file="ScriptFooter.jsp" %>
</body>
</html>