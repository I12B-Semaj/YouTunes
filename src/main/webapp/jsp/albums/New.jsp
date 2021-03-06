<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="youtunes.beans.Artist"%>

<jsp:useBean id="artistDao" scope="application"	class="youtunes.model.JdbcArtistDao"/>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Album</title>
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
<%@include file="../TopNav.jsp" %>

<div class="container py-5 width-35">
	<h2>New Album Form</h2>
	<form id="albumForm">
		<input type="hidden" name="action" value="createAlbum"/>
					
		<div class="mb-3">
			<label for="title" class="form-label">Album title</label>
			<input type="text" class="form-control" id="title" name="title" />
		</div>
		
		<div class="mb-3">
			<label for="release" class="form-label">Release Year</label>
			<input type="text" class="form-control" id="release" name="release" />
		</div>
					
		<div class="mb-3">
			<label for="price" class="form-label">Price</label>
			<input type="text" class="form-control" id="price" name="price" />
		</div>
		
		<div class="mb-3">
			<label for="img" class="form-label">Image URL</label>
			<input type="text" class="form-control" id="img_url" name="img_url" />
		</div>
		
		<div class="mb-3">
			<label for="genre" class="form-label">Genre</label>
			<select class="form-select" id="genre" name="genre">
				<option value="0" selected>--Select--</option>
				<option value="Blues">Blues</option>
				<option value="Classical">Classical</option>
				<option value="Country">Country</option>
				<option value="Jazz">Jazz</option>
				<option value="Pop/Rock">Pop/Rock</option>
				<option value="R&B">R&#38;B</option>
				<option value="Rock">Rock</option>
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
						<option value="<%=artist.getArtistID()%>"><%=artist.getLastName()%>, <%=artist.getFirstName()%></option>
					<% } %>
			</select>
		</div>
		
		<div class="alert alert-danger" id="alert-artist-message" role="alert">
  			
		</div>
					
		<button id="btnSubmit" type="submit" class="btn btn-secondary float-end">Save</button>
	</form>
	
	<br /><br />
	<a href="discover">Return home</a>
</div>

<%@include file="../Footer.jsp" %>
<%@include file="../ScriptFooter.jsp" %>

<script type="text/javascript">
	let albumForm = document.getElementById("albumForm");
	
	albumForm.onsubmit = function() {
		let genre = document.getElementById("genre").value;
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