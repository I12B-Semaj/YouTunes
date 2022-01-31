<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="youtunes.beans.Artist"%>

<jsp:useBean id="artistDao" scope="application" class="youtunes.model.JdbcArtistDao"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Artist List</title>
<!--  Bootstrap StyleSheet CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	
<link rel="stylesheet" href="./css/mainSite.css" type="text/css" />
</head>
<body>
	<%@include file="../TopNav.jsp" %>

	<div class="py-5 container width-35">
	
		<h2 class="text-center">Artist List</h2>
		<br />
		
		
		<table class="table">
			<thead>
				<tr>
					<th>Artist ID</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Functions</th>
				</tr>
			</thead>
			
			<form>
					<tr>
						<td>
							<input type="hidden" name="action" value="createArtist"/>
						</td>
						<td>
							<div class="mb-3">
								<input type="text" class="form-control" id="firstName" name="firstName" />
							</div>
						</td>
						<td>
							<div class="mb-3">
								<input type="text" class="form-control" id="lastName" name="lastName" />
							</div>
						</td>
						<td>
							<button type="submit" class="btn btn-sm btn btn-secondary float-end">Add Artist</button>
						</td>									
					</tr>
				</form>
			
			<%
				List<Artist> artists = artistDao.list(); 
				Iterator<Artist> iterator = artists.iterator();
				while (iterator.hasNext())
				{
					Artist artist = (Artist)iterator.next();
					System.out.println(artist.getArtistID());
					System.out.println(artist.getFirstName());
					System.out.println(artist.getLastName());
					
					// build HTML content from artist list
					%>
						<tr>
							<td><%=artist.getArtistID()%></td>
							<td><%=artist.getFirstName()%></td>
							<td><%=artist.getLastName()%></td>
							<td>
								<div class="btn-toolbar">
			                  		<a href="discover?action=artistDetails&artistId=<%=artist.getArtistID()%>" class="btn btn-sm btn btn-secondary mx-1">Edit</a>
									<a href="discover?action=deleteArtist&artistId=<%=artist.getArtistID() %>" class="btn btn-sm btn btn-secondary mx-1">Delete</a>
			                	</div>
							</td>
						</tr>
				<% } %>
		</table>
	</div>

	<%@include file="../Footer.jsp" %>
	<%@include file="../ScriptFooter.jsp" %>
</body>
</html>