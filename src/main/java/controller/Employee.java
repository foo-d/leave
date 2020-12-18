package controller;

public class Employee {
    private int id;
    private String lastName;
    private String firstName;
    private String email;
    private String dateOfBirth;
    private String country;
    private String city;
    private String zipCode;
    private String dateOfHire;
    private String password;
    private float remaining;
    private float used;

    public Employee (int id, String lastName, String firstName, String email,
                     String dateOfBirth, String country, String city,
                     String zipCode, String dateOfHire, String password,
                     float remaining, float used) {
        this.id = id;
        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.dateOfBirth = dateOfBirth;
        this.country = country;
        this.city = city;
        this.zipCode = zipCode;
        this.dateOfHire = dateOfHire;
        this.password = password;
        this.remaining = remaining;
        this.used = used;
    }

    public Employee (String lastName, String firstName, String email,
                     String dateOfBirth, String country, String city,
                     String zipCode, String dateOfHire, String password,
                     float remaining, float used) {
        this.id = 0;
        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.dateOfBirth = dateOfBirth;
        this.country = country;
        this.city = city;
        this.zipCode = zipCode;
        this.dateOfHire = dateOfHire;
        this.password = password;
        this.remaining = remaining;
        this.used = used;
    }

    public Employee () {
        this.id = 0;
        this.lastName = "";
        this.firstName = "";
        this.email = "";
        this.dateOfBirth = "";
        this.country = "";
        this.city = "";
        this.zipCode = "";
        this.dateOfHire = "";
        this.password = "";
        this.remaining = 0;
        this.used = 0;
    }

    public int getId () {
        return id;
    }

    public String getLastName () {
        return lastName;
    }

    public String getFirstName () {
        return firstName;
    }

    public String getEmail () {
        return email;
    }

    public String getDateOfBirth () {
        return dateOfBirth;
    }

    public String getCountry () {
        return country;
    }

    public String getCity () {
        return city;
    }

    public String getZipCode () {
        return zipCode;
    }

    public String getDateOfHire () {
        return dateOfHire;
    }

    public String getPassword () {
        return password;
    }

    public float getRemaining () {
        return remaining;
    }

    public float getUsed () {
        return used;
    }

    public void setId (int id) {
        this.id = id;
    }

    public void setLastName (String lastName) {
        this.lastName = lastName;
    }

    public void setFirstName (String firstName) {
        this.firstName = firstName;
    }

    public void setEmail (String email) {
        this.email = email;
    }

    public void setDateOfBirth (String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public void setCountry (String country) {
        this.country = country;
    }

    public void setCity (String city) {
        this.city = city;
    }

    public void setZipCode (String zipCode) {
        this.zipCode = zipCode;
    }

    public void setDateOfHire (String dateOfHire) {
        this.dateOfHire = dateOfHire;
    }

    public void setPassword (String password) {
        this.password = password;
    }

    public void setRemaining (float remaining) {
        this.remaining = remaining;
    }

    public void setUsed (float used) {
        this.used = used;
    }
}
