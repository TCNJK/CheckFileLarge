/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import java.util.HashMap;
import java.util.Random;
/**
 *
 * @author 84384
 */
public class Rand {
     public String getStringNum(int kk) {
        String c = "";
        Random random = new Random();
        for (int k = 0; k < kk + 1; k++) {
            c += ""+random.nextInt(10);
        }
        return c;
    }
    
    public String getString(int kk) {
        String c = "";
        Random random = new Random();
        for (int k = 0; k < kk + 1; k++) {
            c += (char) ('a' - 1 + (random.nextInt(26)));
        }
        return c;
    }
}
