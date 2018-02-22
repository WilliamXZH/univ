/**
 *java����΢�Ŷ�ά��ͨѶ¼
 *@version 1.0
 *@author ****
 *
 */
public class QrcodImg{
	public static void main(String[] args){
		getQrcodeImg("","");
	}
	/**
	*���ɶ�ά��ͼƬ
	*@author ***
	*@param cintent ���ɶ�ά������
	*@param imgPath �����ά��
	*/
	public static void getQrcodeImg(String content,String imgPath){
		int width=235;
		int height=235;
		
		//ʵ����һ��qrcode
		Qrcode qrcode=new Qrcode();
		//�Ĵ��� L %7	M 15%	Q 25%	H 30%
		qcQrcode.setQrcodeErrorCorrect('M');
		//���뷽ʽ
		qcQrcode.setQrcodeEncodeMode('b');
		//�汾
		qcQrcode.setQrcodeVersion(15);
		//׼������ά��
		//����һ�黭��
		BufferedImage image=new BUfferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		//��ȡ����
		Graphics2D gs=image.createGraphics();
		//��ά��ı�����ɫ
		gs.setBackground(Color.white);
		//�������ݵ���ɫ
		gs.setColor(Color.black);
		//ȷ������ά�������
		gs.clearRect(0,0,width,height);
		//��ʼ�����ά�����Ϣ
		byte[] codeOut;

		try{
			//ͨ�����ݻ��byte����
			codeOut=content.getBytes("utf-8");
			//ͨ��byte������boolean����
			boolean[][] code=qcQrcode.calQrcode(codeOut);
			
			for(int i=0;i<code.length;i++){
				for(int j=0;j<code.length;j++){
					if(code[i][j]){
						gs.fileRect(j+3*2,i*3+2,3,3);
					}
				}
			}
			//�ͷ���Դ
			gs.dispose();
			image.flush();
			//����ָ��·��
			ImageIO.write(image,"png",new File(imgPath));
		}catch(Exception e){
			e.printStackTrace();
		}

	}
}