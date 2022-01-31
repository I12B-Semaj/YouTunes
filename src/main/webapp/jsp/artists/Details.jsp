<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="youtunes.beans.Artist" %>
    
<jsp:useBean id="artistDao" scope="application" class="youtunes.model.JdbcArtistDao" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YouTunes | Artist Details</title>
<!--  Bootstrap StyleSheet CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	
<link rel="stylesheet" href="../css/mainSite.css" type="text/css" />
</head>
<body>
<%@include file="../TopNav.jsp" %>

<div class="container py-5 width-35">
	<h2 class="text-center">Artist Details</h2>
	
	<% 
		try 
		{
			String artistId = request.getParameter("artistId");
			Artist artist = artistDao.find(Integer.parseInt(artistId)); 
			
			if (artist != null)
			{
			%>
				<form>
					<input type="hidden" name="action" value="updateArtist" />
					<input type="hidden" name="artistId" value="<%=artist.getArtistID() %>" />
					
					<div class="mb-3">
						<label for="firstName" class="form-label">First name</label>
						<input type="text" class="form-control" id="firstName" name="firstName" value="<%=artist.getFirstName() %>" />
					</div>
					
					<div class="mb-3">
						<label for="lastName" class="form-label">Last name</label>
						<input type="text" class="form-control" id="lastName" name="lastName" value="<%=artist.getLastName() %>" />
					</div>
					
					<button type="submit" class="btn btn-secondary float-end">Save</button>
				</form>
				<%
				System.out.println(artist.getFirstName());
			}
		}
		catch (Exception ex)
		{
			System.out.println(ex.getMessage());
		}
		
	%>
	<br />
	<br />
	<a href="discover?action=showArtists">Return to artists</a>
</div>

	<%@include file="../Footer.jsp" %>
	<%@include file="../ScriptFooter.jsp" %>

</body>
</html>