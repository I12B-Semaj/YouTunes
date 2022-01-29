package youtunes.beans;

public class Album 
{
	private int albumID; 
	private String albumTitle;
	private String imgUrl;
	private int releaseYear;
	private int artistID;
	private String genre;
	private Double price;

	public Album()
	{
		
	}	
	
	public Album(int albumID, String albumTitle, String imgUrl, int releaseYear, int artistID, String genre, Double price)
	{
		this.albumID = albumID;
		this.albumTitle = albumTitle;
		this.imgUrl = imgUrl;
		this.releaseYear = releaseYear;
		this.artistID = artistID;
		this.genre = genre;
		this.price = price;
	}
	
	public int getAlbumID() {
		return albumID;
	}

	public void setAlbumID(int albumID) {
		this.albumID = albumID;
	}

	public String getAlbumTitle() {
		return albumTitle;
	}

	public void setAlbumTitle(String albumTitle) {
		this.albumTitle = albumTitle;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public int getReleaseYear() {
		return releaseYear;
	}

	public void setReleaseYear(int releaseYear) {
		this.releaseYear = releaseYear;
	}

	public int getArtistID() {
		return artistID;
	}

	public void setArtistID(int artistID) {
		this.artistID = artistID;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "Album [albumID=" + albumID + ", albumTitle=" + albumTitle + ", imgUrl=" + imgUrl + ", releaseYear="
				+ releaseYear + ", artistID=" + artistID + ", genre=" + genre + ", price=" + price + "]";
	}
}
