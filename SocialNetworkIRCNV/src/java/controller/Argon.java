package controller;
import com.sun.jna.IntegerType;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

public class Argon {
    Argon2 argon2;

    public Argon() {
        argon2= Argon2Factory.create();
    }
    
    public String convertArgon2(String hash){
        char[] password= hash.toCharArray();
        String hash1= "";
        try {
             hash1= argon2.hash(28, 65536, 1, password);
        } catch (Exception e) {
        }
        return hash1.trim();
    }
    public boolean checkArgon2(String hash, String password){
        if(argon2.verify(hash, password))
            return true;
        return false;
    }
    public static void main(String[] args) {
        String pass= "nguyenanhviet";
        String hash= new Argon().convertArgon2(pass);
        System.out.println("hash : "+ hash);
        Argon2 argon2= Argon2Factory.create();
        if(new Argon().checkArgon2(hash, pass))
            System.out.println("match");
        else System.out.println("!match");
    }
}
