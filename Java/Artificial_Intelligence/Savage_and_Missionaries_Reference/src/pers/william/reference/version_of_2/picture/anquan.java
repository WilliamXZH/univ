/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pers.william.reference.version_of_2.picture;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JOptionPane;

/**
 *
 * @author 閮槉鐒�
 */
public  class anquan {
    static int ye,mo,da;
    public  anquan()
    {
        
    }
    public static void chushihua()//鍏堟墽琛�
    {
        ye=2017;
        mo=1;
        da=6;
       // 2016,12,4
    }
    public static boolean isok()//褰撳墠jzrq
    {
        /////////////////////////////////////濡傛灉鏃堕棿鍏佽
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//璁剧疆鏃ユ湡鏍煎紡
            String now=df.format(new Date());
            int y=Integer.parseInt(now.substring(0,4));
            int m=Integer.parseInt(now.substring(5,7));
            int d=Integer.parseInt(now.substring(8,10));
            if(y>ye)
            {
                return true;
            }else if(y==ye)
            {
                if(m>mo)
                {
                    return true;
                }else if(m==mo)
                {
                    if(d>=da)
                    {
                        return true;
                    }else
                    {
                        return false;
                    }
                }else
                {
                    return false;
                }
            }else
            {
                return false;
            }
           // 
           // if(now)
           // return true;
    }
    public static void showinfo()//
    {
        JOptionPane.showMessageDialog(null,"瀛﹀彿锛�20131003526\n 濮撳悕锛氶儹鏄婄劧\n 鐝骇锛氳蒋浠跺伐绋�1301", "淇℃伅", JOptionPane.ERROR_MESSAGE);
    }
    public static void tui()
    {
        System.exit(0);
    }
}
