/**
 *java开发微信二维码通讯录
 *@version 1.0
 *@author ****
 *
 */
public class QrcodImg{
	public static void main(String[] args){
		getQrcodeImg("","");
	}
	/**
	*生成二维码图片
	*@author ***
	*@param cintent 生成二维码内容
	*@param imgPath 保存二维码
	*/
	public static void getQrcodeImg(String content,String imgPath){
		int width=235;
		int height=235;
		
		//实例化一个qrcode
		Qrcode qrcode=new Qrcode();
		//拍错率 L %7	M 15%	Q 25%	H 30%
		qcQrcode.setQrcodeErrorCorrect('M');
		//编码方式
		qcQrcode.setQrcodeEncodeMode('b');
		//版本
		qcQrcode.setQrcodeVersion(15);
		//准备画二维码
		//创建一块画板
		BufferedImage image=new BUfferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		//获取画笔
		Graphics2D gs=image.createGraphics();
		//二维码的背景白色
		gs.setBackground(Color.white);
		//设置内容的颜色
		gs.setColor(Color.black);
		//确定画二维码的区域
		gs.clearRect(0,0,width,height);
		//开始处理二维码的信息
		byte[] codeOut;

		try{
			//通过内容获得byte数组
			codeOut=content.getBytes("utf-8");
			//通过byte数组获得boolean数组
			boolean[][] code=qcQrcode.calQrcode(codeOut);
			
			for(int i=0;i<code.length;i++){
				for(int j=0;j<code.length;j++){
					if(code[i][j]){
						gs.fileRect(j+3*2,i*3+2,3,3);
					}
				}
			}
			//释放资源
			gs.dispose();
			image.flush();
			//设置指定路径
			ImageIO.write(image,"png",new File(imgPath));
		}catch(Exception e){
			e.printStackTrace();
		}

	}
}