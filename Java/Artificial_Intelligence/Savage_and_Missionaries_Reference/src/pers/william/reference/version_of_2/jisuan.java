/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pers.william.reference.version_of_2;
//鐢ㄤ簬璁＄畻鍚勭


import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/**
 *
 * @author 閮槉鐒�
 */
public class jisuan {
    int people_num;
    int ship_num;
    boolean error=false;
    public jisuan(int peo,int ship)
    {
        this.people_num=peo;
        this.ship_num=ship;
    }
    public int get_peo_num()
    {
        return people_num;
    }
    public void set_peo_num(int peo)
    {
        this.people_num=peo;
    }
    public int get_ship_num()
    {
        return ship_num;
    }
    public void set_ship_num(int ship)
    {
        this.ship_num=ship;
    }
    public String addPeonum()//澧炲姞浜烘暟
    {
        if(people_num<15)//鏈�澶т负15
        {
             people_num++;
        }else
        {
            JOptionPane.showMessageDialog(null,"鏈�澶氫负15涓紶鏁欏＋鍜�15涓噹浜�", "淇℃伅鎻愮ず", JOptionPane.ERROR_MESSAGE);
        }
        return people_num+"";
       
    }
     public String jianPeonum()//鍑忓皯浜烘暟
    {
        if(people_num>2)//鏈�灏戜负2
        {
             people_num--;
        }else
        {
             JOptionPane.showMessageDialog(null,"鏈�灏戜负2涓紶鏁欏＋鍜�2涓噹浜�", "淇℃伅鎻愮ず", JOptionPane.ERROR_MESSAGE);
        }
        return people_num+"";
    }
     public String addshipnum()//澧炲姞鑸圭殑鏁伴噺
     {
        if(ship_num<15)//鏈�澶�15
        {
             ship_num++;
        }else
        {
            JOptionPane.showMessageDialog(null,"鑸硅浇瀹㈡渶澶氫负15", "淇℃伅鎻愮ず", JOptionPane.ERROR_MESSAGE);
        }
        return ship_num+"";
     }
     public String jianshipnum()
     {
          if(ship_num>2)//鏈�灏戜负2
        {
             ship_num--;
        }else
        {
            JOptionPane.showMessageDialog(null,"鑸硅浇瀹㈡渶灏戜负2", "淇℃伅鎻愮ず", JOptionPane.ERROR_MESSAGE);
        }
        return ship_num+"";
     }
     List<int[]> move=new ArrayList<int[]>();
     public String Axing_jisuan()//浣跨敤A*绠楁硶璁＄畻
     {
         move.clear();//娓呯┖鍏冪礌閲嶆柊璁＄畻
         error=false;
         //int[] a=new int[3];//0,1鍒嗗埆涓洪噹浜猴紝浼犳暀澹Щ鍔ㄤ汉鏁帮紝2涓哄悜宸︾Щ杩樻槸鍚戝彸绉伙紙0鍚戝彸绉伙紝1鍚戝乏绉伙級
         int yeren=0,chuanjiao=0;//宸﹁竟閲庝汉鍜屼紶鏁欏＋
          StringBuilder a=new StringBuilder("");
          yeren=people_num;
          chuanjiao=people_num;
          a.append("    鍒濆锛氬乏宀�:"+"銆愰噹浜�"+yeren+"浜猴紝浼犳暀澹�"+chuanjiao+"浜恒��---鍙冲哺锛�"+"銆愰噹浜�"+(people_num-yeren)+"浜猴紝浼犳暀澹�"+(people_num-chuanjiao)+"浜恒�慭n");
        // try
         //{
            yunxing(people_num,people_num,true,0);
           
            for(int i=move.size()-1;i>=0;i--)
            {
                if(move.get(i)[2]==0)//鍚戝彸绉�
                {
                    a.append("*绗�"+(move.size()-i)+"姝�:灏� "+move.get(i)[0]+" 涓噹浜哄拰 "+move.get(i)[1]+" 涓紶鏁欏＋绉诲姩鍒板彸宀搞��--->\n");
                    yeren-=move.get(i)[0];
                    chuanjiao-=move.get(i)[1];
                    a.append("    鏇存柊锛氬乏宀�:"+"銆愰噹浜�"+yeren+"浜猴紝浼犳暀澹�"+chuanjiao+"浜恒��---鍙冲哺锛�"+"銆愰噹浜�"+(people_num-yeren)+"浜猴紝浼犳暀澹�"+(people_num-chuanjiao)+"浜恒�慭n");
                }else//鍚戝乏绉�
                {
                    a.append("*绗�"+(move.size()-i)+"姝�:灏� "+move.get(i)[0]+" 涓噹浜哄拰 "+move.get(i)[1]+" 涓紶鏁欏＋绉诲姩鍒板乏宀搞��<---\n");
                    yeren+=move.get(i)[0];
                    chuanjiao+=move.get(i)[1];
                    a.append("    鏇存柊锛氬乏宀�:"+"銆愰噹浜�"+yeren+"浜猴紝浼犳暀澹�"+chuanjiao+"浜恒��---鍙冲哺锛�"+"銆愰噹浜�"+(people_num-yeren)+"浜猴紝浼犳暀澹�"+(people_num-chuanjiao)+"浜恒�慭n");
                }
            }
            // return a.toString();
//         }catch(Exception x)
//         {
                if(error)
                {
                     a=new StringBuilder("鏃犺В鎯呭喌锛乗n"+people_num+"涓噹浜烘垨浼犳暀澹� 鍜岃浇鑽蜂负"+ship_num+"鐨勮埞杩欑鍖归厤鏃犺В銆俓n璇疯皟鏁撮噹浜轰紶鏁欏＋鏁伴噺鎴栬埞鐨勮浇鑽�!");
                }
            
              return a.toString();
          //  return people_num+"涓噹浜烘垨浼犳暀澹拰杞借嵎涓�"+ship_num+"鐨勮埞杩欑鍖归厤鏃犺В銆俓n璇疯皟鏁撮噹浜轰紶鏁欏＋鏁伴噺鎴栬埞鐨勮浇鑽�!" ;
//         }
        
         //yunzou(people_num,people_num,true,0,2,0);
         
         
      // return move.size()+"";
     }
     
     
     private void yunxing(int zuoye,int zuoch,boolean xiangyou,int step)//鐩存帴鎵惧嚭鍙互杩愯鐨勭瓟妗�  鎴彇yunzou鏂规硶鐨勪竴閮ㄥ垎 鍗崇涓�娆″悜鍙宠繍鐨勬儏鍐�
     {
        if(zuoye+zuoch<=ship_num)//鍓╀笅鐨勫彲浠ョ洿鎺ヨ繍杩囧幓浜�
        {
            int[] x=new int[3];
            x[0]=zuoye;//閲庝汉鏁扮洰
            x[1]=zuoch;//浼犳暀澹暟鐩�
            x[2]=0;//鍚戝彸绉�
            move.add(x);
            return;
        }else
        {
            for(int allnum=ship_num;allnum>0;allnum--)//鍚戝彸杩愬垯浠庡ぇ鍚戝皬杩�
            {
                for(int ye=zuoye;ye>=0;ye--)//杩愯蛋鐨勯噹浜烘暟
                {
                    for(int ch=zuoch;ch>=0;ch--)//杩愯蛋鐨勪紶鏁欏＋鏁�
                    {
                        if(ye+ch==allnum)//绛変簬褰撳墠鍏佽杞借嵎
                        {
                            if((zuoch-ch)>=(zuoye-ye)||((zuoch-ch)==0&&(zuoye-ye)>0))//宸﹀哺杩愯蛋鍚庯紝浼犳暀澹汉鏁颁粛澶т簬閲庝汉浜烘暟鎴栬�呭彧鍓╀笅閲庝汉
                            {
                                if(ch>=ye||(ch==0&&ye>0))//鑸逛笂浼犳暀澹汉鏁板ぇ浜庣瓑浜庨噹浜烘垨鑰呭彧鏄噹浜�
                                {
                                    if((people_num-zuoch+ch)>=(people_num-zuoye+ye)||((people_num-zuoch+ch)==0&&(people_num-zuoye+ye)>0))//鍙冲哺绗﹀悎鏉′欢
                                    {
                                        //if(yun_ye!=ye||yun_chuan!=ch)//淇濊瘉鍜屼笂娆＄殑涓嶅悓
                                        {
                                           if(yunzou(zuoye,zuoch,true,step++,ye,ch)==true)//鍚﹀垯瑕佸鍑犺稛杩愯蛋
                                           {
                                               int[] x=new int[3];
                                               x[0]=ye;//閲庝汉鏁扮洰
                                               x[1]=ch;//浼犳暀澹暟鐩�
                                               x[2]=0;//鍚戝彸绉�
                                               move.add(x);
                                               return;
                                           }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }  
        } 
        //error=true;
     }
     //people_num浜烘暟  ship_num鑸圭殑杞借嵎
     //fn=gn+hn;gn涓哄綋鍓嶅凡缁忚蛋鐨勬鏁帮紝hn涓哄墿涓嬫病杩愯蛋鐨勪汉鏁�
     //鐢变簬绠楁硶閲囩敤宸﹀哺杈规�讳汉鏁拌秺灏戣秺濂斤紝鎵�浠ヤ笉闇�瑕佺壒鎰忓垪鍑烘墍鏈夋儏鍐垫潵鏍规嵁fn瓒婂皬鏉ラ�夋嫨锛岃�屾槸鐩存帴鎺掑垪浠庡皬鍒板ぇ鐨刦n锛屼緷娆℃煡鐪嬬鍚堢殑鎯呭喌涓嬭繍璧颁汉灏卞彲浠�
     //褰撳墠zuocye鍜寊uoch 骞朵笖xiangyou鏂瑰悜 杩恲un_ye閲庝汉鍜寉un_chuan浼犳暀澹繖绉嶆儏鍐垫槸鍙互鐨勫悧锛�
     
     private boolean yunzou(int zuoye,int zuoch,boolean xiangyou,int step,int yun_ye,int yun_chuan)//杩愯蛋浜烘柟娉曪紝宸﹂潰->鍙抽潰 xiangyou杩愭槸鍙互鐨勫槢锛�  宸﹂潰閲庝汉鏁伴噺锛屽乏闈紶鏁欏＋鏁伴噺 鑸瑰悜鍙宠繍琛屽悧锛� 姝ユ暟锛堝叾瀹炴病浠�涔堢敤锛� 杩愯蛋鐨勯噹浜猴紝杩愯蛋鐨勪紶鏁欏＋
     {
         if(step>100)
         {
             error=true;
             return true;
         }
              // List list = new ArrayList();
        // aaa.add(3);
         //List<dd> b=new List<d>();
         int fn=0;//
         int gn=step;
         int hn=0;
         //杩愯蛋绗﹀悎鐨勬潯浠讹細宸﹀哺鍓╀笅鐨勪紶鏁欏＋澶т簬绛変簬閲庝汉鏁伴噺鎴栬�呭彧鍓╀笅閲庝汉 鍙冲哺銆佽埞涓婂悓鐞�
         //杩愯蛋鐨勬�讳汉鏁板皬浜庤埞鐨勮浇鑽�
         //杩愯蛋鐨勬�讳汉鏁板ぇ浜�0 鍥犱负鑷冲皯涓�涓汉鍒掕埞
         //杩愯蛋鐨勬柟寮忓拰涓婃杩愭潵鐨勪笉鑳界浉鍚�
         //杩愯蛋鍚�
         if(xiangyou)//瑕佸悜鍙宠繍鍔紝鍒欏杩愪汉浣垮緱fn瓒婂皬瓒婂ソ 鍚戝彸杩愬姩鏄彲浠ョ殑鍚�
         {
            for(int allnum=1;allnum<=ship_num;allnum++)//鍚戝乏杩愬垯浠庡皬鍒板ぇ  濡傛灉鍚戝彸杩愬悗鍙互鍚戝乏杩� 鍒欏彲浠ュ悜鍙宠繍
            {
                for(int ye=0;ye<=people_num-zuoye+yun_ye&&ye<=allnum;ye++)//杩愯蛋鐨勯噹浜烘暟
                {
                    for(int ch=0;ch<=people_num-zuoch+yun_chuan&&ch<=allnum;ch++)//杩愯蛋鐨勪紶鏁欏＋鏁�
                    {
                        if(ye+ch==allnum)//绛変簬褰撳墠鍏佽杞借嵎
                        {
                            if(((zuoch-yun_chuan+ch)>=(zuoye-yun_ye+ye))||((zuoch-yun_chuan+ch)==0&&(zuoye-yun_ye+ye)>0))//鍙冲哺杩愯蛋鍚庯紝宸﹀哺浼犳暀澹汉鏁颁粛澶т簬閲庝汉浜烘暟鎴栬�呭彧鍓╀笅閲庝汉
                            {
                                if((ch>=ye)||(ch==0&&ye>0))//鑸逛笂浼犳暀澹汉鏁板ぇ浜庣瓑浜庨噹浜烘垨鑰呭彧鏄噹浜�
                                {
                                    if((people_num-zuoch+yun_chuan-ch)>=(people_num-zuoye+yun_ye-ye)||((people_num-zuoch+yun_chuan-ch)==0&&(people_num-zuoye+yun_ye-ye)>0))//鍙冲哺鍓╀笅鐨勭鍚堟潯浠�
                                    {
                                        if(yun_ye!=ye||yun_chuan!=ch)//淇濊瘉鍜屼笂娆＄殑涓嶅悓
                                        {
                                           if(yunzou(zuoye-yun_ye,zuoch-yun_chuan,false,step++,ye,ch)==true)//
                                           {
                                               int[] x=new int[3];
                                               x[0]=ye;//閲庝汉鏁扮洰
                                               x[1]=ch;//浼犳暀澹暟鐩�
                                               x[2]=1;//鍚戝乏绉�
                                               move.add(x);
                                               return true;
                                           }
                                        } 
                                    }
                                }
                            }
                        }
                    }
                }
            }
         }else//瑕佸悜宸﹁繍鍔紝鍒欏皯杩愪汉浣垮緱fn瓒婂皬瓒婂ソ 鍚戝乏杩愬姩鍙互鍚楋紵
         {
            if(zuoye+yun_ye+zuoch+yun_chuan<=ship_num)//鍓╀笅鐨勫彲浠ョ洿鎺ヨ繍杩囧幓浜�
            {
                int[] x=new int[3];
                x[0]=zuoye+yun_ye;//閲庝汉鏁扮洰
                x[1]=zuoch+yun_chuan;//浼犳暀澹暟鐩�
                x[2]=0;//鍚戝彸绉�
                move.add(x);
                return true;
            }else
            {
               for(int allnum=ship_num;allnum>0;allnum--)//鍚戝彸杩愬垯浠庡ぇ鍚戝皬杩�
                {
                    for(int ye=zuoye+yun_ye;ye>=0;ye--)//杩愯蛋鐨勯噹浜烘暟
                    {
                        for(int ch=zuoch+yun_chuan;ch>=0;ch--)//杩愯蛋鐨勪紶鏁欏＋鏁�
                        {
                            if(ye+ch==allnum)//绛変簬褰撳墠鍏佽杞借嵎
                            {
                                if((zuoch+yun_chuan-ch)>=(zuoye+yun_ye-ye)||((zuoch+yun_chuan-ch)==0&&(zuoye+yun_ye-ye)>0))//宸﹀哺杩愯蛋鍚庯紝浼犳暀澹汉鏁颁粛澶т簬閲庝汉浜烘暟鎴栬�呭彧鍓╀笅閲庝汉
                                {
                                    if(ch>=ye||(ch==0&&ye>0))//鑸逛笂浼犳暀澹汉鏁板ぇ浜庣瓑浜庨噹浜烘垨鑰呭彧鏄噹浜�
                                    {
                                        if((people_num-zuoch-yun_chuan+ch)>=(people_num-zuoye-yun_ye+ye)||((people_num-zuoch-yun_chuan+ch)==0&&(people_num-zuoye-yun_ye+ye)>0))//鍙冲哺绗﹀悎鏉′欢
                                        {
                                            if(yun_ye!=ye||yun_chuan!=ch)//淇濊瘉鍜屼笂娆＄殑涓嶅悓
                                            {
                                               //if(yunzou(zuoye+yun_ye-ye,zuoch+yun_chuan-ch,true,step++,ye,ch)==true)//鍚﹀垯瑕佸鍑犺稛杩愯蛋
                                               if(yunzou(zuoye+yun_ye,zuoch+yun_chuan,true,step++,ye,ch)==true)//鍚﹀垯瑕佸鍑犺稛杩愯蛋
                                               {
                                                   int[] x=new int[3];
                                                   x[0]=ye;//閲庝汉鏁扮洰
                                                   x[1]=ch;//浼犳暀澹暟鐩�
                                                   x[2]=0;//鍚戝彸绉�
                                                   move.add(x);
                                                   return true;
                                               }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } 
            }
             
         }
         return false;//榛樿蹇呴』杩斿洖涓嶅彲杈惧埌
     }
}
