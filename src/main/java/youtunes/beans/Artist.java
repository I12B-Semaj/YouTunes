package youtunes.beans;

public class Artist 
{
	private int artistID;
	private String firstName;
	private String lastName;
	
	public Artist()
	{
		
	}
	
	public Artist(int artistID, String firstName, String lastName)
	{
		this.artistID = artistID;
		this.firstName = firstName;
		this.lastName = lastName;		
	}

	public int getArtistID() {
		return artistID;
	}

	public void setArtistID(int artistID) {
		this.artistID = artistID;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@Override
	public String toString() {
		return "Artist{artistId=<id>, firstName=<firstName>, lastName=<lastName>}";
	}
	
	
}
