/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wild_man_and_chuanjiaoshi.picture;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JOptionPane;

/**
 *
 * @author 郭昊然
 */
public  class anquan {
    static int ye,mo,da;
    public  anquan()
    {
        
    }
    public static void chushihua()//先执行
    {
        ye=2017;
        mo=1;
        da=6;
       // 2016,12,4
    }
    public static boolean isok()//当前jzrq
    {
        /////////////////////////////////////如果时间允许
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
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
        JOptionPane.showMessageDialog(null,"学号：20131003526\n 姓名：郭昊然\n 班级：软件工程1301", "信息", JOptionPane.ERROR_MESSAGE);
    }
    public static void tui()
    {
        System.exit(0);
    }
}
