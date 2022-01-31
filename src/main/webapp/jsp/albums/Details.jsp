<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="youtunes.beans.Artist"%>   
<%@page import="youtunes.beans.Album" %>

<jsp:useBean id="albumDao" scope="application" class="youtunes.model.JdbcAlbumDao" />
<jsp:useBean id="artistDao" scope="application" class="youtunes.model.JdbcArtistDao" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Album Details</title>

<!--  Bootstrap StyleSheet CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	
<link rel="stylesheet" href="../css/mainSite.css" type="text/css" />

<style>
	#alert-genre-message {
		display: none;
	}
	
	#alert-artist-message {
		display: none;
	}
</style>

</head>
<body>
<jsp:include page="../TopNav.jsp" flush="true" />

<div class="container py-5 width-35">

	<% 
		try 
		{
			String albumId = request.getParameter("albumId");
			Album album = albumDao.find(Integer.parseInt(albumId));
			System.out.println(album.toString());
			
			if (album != null) {
			%>
				<form id="albumForm">
					<input type="hidden" name="action" value="updateAlbum" />
					<input type="hidden" name="albumId" value="<%=album.getAlbumID()%>" />
					
					<div class="mb-3">
						<label for="title" class="form-label">Album title</label>
						<input type="text" class="form-control" id="title" name="title" value="<%=album.getAlbumTitle() %>" />
					</div>
					
					<div class="mb-3">
						<label for="release" class="form-label">Release Year</label>
						<input type="text" class="form-control" id="release" name="release" value="<%=album.getReleaseYear() %>" />
					</div>
					
					<div class="mb-3">
						<label for="price" class="form-label">Price</label>
						<input type="text" class="form-control" id="price" name="price" value="<%=album.getPrice() %>" />
					</div>
					
					<div class="mb-3">
						<label for="url" class="form-label">Image URL</label>
						<input type="text" class="form-control" id="img_url" name="img_url" value="<%=album.getImgUrl()%>" />
					</div>
		
					<div class="mb-3">
						<label for="genre" class="form-label">Genre</label>
						<select class="form-select" id="genre" name="genre">
							<option value="0">--Select--</option>
							<% System.out.println("Selected Genre: " + album.getGenre()); %>
							
							<option value="Blues" <% if (album.getGenre().equals("Blues")) { %> selected <% } %> >Blues</option>
							<option value="Classical" <% if (album.getGenre().equals("Classical")) { %> selected <% } %> >Classical</option>
							<option value="Country" <% if (album.getGenre().equals("Country")) { %> selected <% } %> >Country</option>
							<option value="Jazz" <% if (album.getGenre().equals("Jazz")) { %> selected <% } %> >Jazz</option>
							<option value="Pop/Rock" <% if (album.getGenre().equals("Pop/Rock")) { %> selected <% } %> >Pop/Rock</option>
							<option value="R&B" <% if (album.getGenre().equals("R&B")) { %> selected <% } %> >R&#38;B</option>
							<option value="Rock" <% if (album.getGenre().equals("Rock")) { %> selected <% } %> >Rock</option>
						</select>
					</div>
		
					<div class="alert alert-danger" id="alert-genre-message" role="alert">
			  			
					</div>
		
					<div class="mb-3">
						<label for="artist" class="form-label">Artist</label>
						<select class="form-select" id="artist" name="artist">
							<option value="0" selected>--Select--</option>
							
							<%
								List<Artist> artists = artistDao.list();
								Iterator<Artist> iterator = artists.iterator();
								while (iterator.hasNext())
								{
									Artist artist = (Artist)iterator.next();
								
							%>
									<option value="<%=artist.getArtistID()%>" <% if (album.getArtistID() == artist.getArtistID()) { %> selected <% } %> >
										<%=artist.getLastName()%>, <%=artist.getFirstName()%>
									</option>
								<% } %>
						</select>
					</div>
		
					<div class="alert alert-danger" id="alert-artist-message" role="alert">
  			
					</div>
					
					<button id="btnSubmit" type="submit" class="btn btn-primary float-end">Save</button>
				</form>
				
				<br /><br />
				<a href="discover">Return Home</a>
			<% 	
			}
		}
		catch (Exception ex)
		{
			System.out.println(ex.getMessage());
		}
		
	%>
</div>

<script type="text/javascript">
	let albumForm = document.getElementById("albumForm");
	
	albumForm.onsubmit = function() {
		let genre = document.getElementById('genre').value;
		let artist = document.getElementById('artist').value;
		let alertGenreDiv = document.getElementById('alert-genre-message'); 
		let alertArtistDiv = document.getElementById('alert-artist-message');
		
		console.log('Genre: ' + genre);
		console.log('Artist: ' + artist);
		
		if (genre.localeCompare('0') === 0) {	
			showAlertBox(alertGenreDiv, 'Invalid genre selection.');
			
			return false;
		} else if (artist.localeCompare('0') === 0) {
			hideAlertBox(alertGenreDiv, ''); 
			showAlertBox(alertArtistDiv, 'Invalid artist selection.');
			
			return false;
		}
		else {
			hideAlertBox(alertGenreDiv, '');
			hideAlertBox(alertArtistDiv, '');
			albumForm.submit(); 
		} 
	}
	
	function hideAlertBox(div, msg) {
		div.style.display = 'none';
		div.innerHTML = msg;
	}
	
	function showAlertBox(div, msg) {
		div.style.display = 'block';
		div.innerHTML = msg;
	}
</script>

</body>
</html>