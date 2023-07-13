/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author van12
 */
public class Text {
    public String changeUTF8(String content) throws Exception{
         return new String(content.replace("\n", System.getProperty("line.separator")).getBytes("ISO-8859-1"), "UTF-8");
    }
}
