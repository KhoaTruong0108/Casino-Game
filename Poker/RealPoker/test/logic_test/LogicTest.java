package logic_test;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author KIDKID
 */
public abstract class LogicTest {
    public Boolean RunTest(){
        return false;
    }
    public void AssertTrue(boolean value, String expression){
        if(value == false)
            System.out.println(expression + " FAIL");
        else{
            System.out.println(expression + " SUCCESS");
        }
    }
    
    
}
