package com.group3.controller;

import java.io.IOException;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.group3.po.User;
import com.group3.service.PartnerService;
import com.group3.service.UserService;
import com.group3.util.SMSer;
import com.group3.util.SendMessage;
import com.group3.util.TestMailExist;
import com.group3.util.VerificationCode;
import com.group3.util.smtp.MailSenderOf163;
import com.group3.vo.UserForBL;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



@Controller
public class UserController {
	
	@Resource
	UserService userService;
	@Resource
	PartnerService partnerService;
	
	/**
	 * 接收用户表单数据，实现登录功能
	 * @param message 用户名称/邮箱/手机号
	 * @param password 用户密码
	 * @param session 获取session对象
	 * @return ModelAndView
	 * @throws IOException 
	 * 
	 * @HttpSession session:loginStat<br/>
	 * 0. Not logged in<br>
	 * 1. Normal logged in<br/>
	 * 2. Login way  is mismatching with password
	 */
	@RequestMapping({"/user/userLogin","/queryInfo/userLogin","[a-z/]*/userLogin"})
	public void userLogin(String message,String password,HttpSession session,HttpServletResponse response) throws IOException{
		
		System.out.println(message+"\t"+password);
		if(message!=null&&password!=null){
			User user =  userService.userLogin(new User(message,password,message, message));
			
			if(user!=null){
				//session.setAttribute("loginStat", 1);
				session.setAttribute("id", user.getId());
				session.setAttribute("userName", user.getUserName());
				//session.setAttribute("user", user);

				JSONObject jsonObject = JSONObject.fromObject(user);
				response.setContentType("application/json;charset=UTF-8");
				System.out.println(jsonObject);
				response.getWriter().print(jsonObject);
				System.out.println("login:"+user);
				
			}else{
				//session.setAttribute("loginStat", 2);
				System.out.println("message is dismatch with password!");
			}
			
		}else{
			//session.setAttribute("loginStat", 0);
			System.out.println("error???no message or password!");
		}
	}
	@RequestMapping("/queryInfo/userLogout")
	public void userLogout(HttpSession session,HttpServletResponse response) throws IOException{
		System.out.println("logout");
		session.removeAttribute("id");
		//session.removeAttribute("user");
		session.removeAttribute("loginStat");
		//session.setAttribute("loginStat", 0);
		//response.getWriter().print("asd");
	}
	
	/**
	 * 显示当前用户的个人信息
	 * @param session
	 * @return
	 */
	@RequestMapping("/userweb/showUserInfo")
	public ModelAndView userInfo(HttpSession session){
		String id =(String) session.getAttribute("id");
		System.out.println("参数"+id);
		ModelAndView modelAndView = new ModelAndView();
		User currentUser = userService.getUserInfo("2");
 		System.out.println(currentUser);
 		modelAndView.setViewName("/userweb/ChangeInfofinnal");
 		modelAndView.addObject("user", currentUser);
		return modelAndView;
		
	}
	
	/**
	 * 用户注册
	 * @param user实体接受表单数据
	 * @return ModelAndView
	 */
	@RequestMapping("/main/userRegister")
	public ModelAndView userRegister(@ModelAttribute User user){
		ModelAndView modelAndView = new ModelAndView();
		System.out.println(user);
		if(user.getId()!=null){
			boolean result = userService.userRegister(user);
			partnerService.partnerAdd2(user);
			if(result){
				modelAndView.addObject("user",user);
				modelAndView.setViewName("main/NotIndex");
				return modelAndView;
			}
		}
		modelAndView.setViewName("main/userRegister");
		return modelAndView;
	}
	
	/**
	 * 获取手机验证码
	 * @param request 存储有电话号码
	 * @param response 
	 * @param session 
	 * @throws IOException 
	 * @return void 
	 */
	@RequestMapping("/userweb/getVerificationCodeByCel")
	public void getVerificationCodeByCel(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		System.out.println(session);
		String telNum = request.getParameter("telNum");
		System.out.println("telNum:"+telNum);
		//response.setContentType("application/json");
		
		if(userService.testUserByCel(telNum)){
			String code = VerificationCode.createVerificationCode();
			System.out.println("refCode:"+code);
			
/*			String result = SMSer.submitCode(telNum, code);
			System.out.println(result);
			
			if(result!=null){*/
				session.setAttribute("code", code);
				//response.getWriter().print("{\"info\":\"Verification Code has been send!\"}");
				response.getWriter().print("Verification Code has been send!");
				//System.out.println("exist!");
			/*}else{
				response.getWriter().print("Failed to send verification code!");
			}*/
		}else{
			//response.getWriter().print("{\"info\":\"Cel Number is non-exist!\"}");
			response.getWriter().print("Cel Number is non-exist!");
			//System.out.println("non-exist!");
		}
	}
	
	/**
	 * 获取邮箱验证码
	 * @param request
	 * @param response
	 * @throws IOException
	 * @return void
	 */
	@RequestMapping("/userweb/getVerificationCodeByMail")
	public void getVerificationCodeByMail(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
		
		String mail = request.getParameter("mail");
		System.out.println("mail:" +mail);
		
		/*short r = TestMailExist.testMail(mail);
		System.out.println(r+":"+TestMailExist.getTestInfo(r));
		
		if(r==1){*/
			String code = VerificationCode.createVerificationCode(6);
			System.out.println(mail+":"+code);
			session.setAttribute("code", code);
			//MailSenderOf163.sendVerificationCode(mail, code);
			response.getWriter().print("Verification has been send, please checked in time.");
		/*}else if(r==0||r==6||r==7){
			System.out.println("error when test the mail.");
			response.getWriter().print("error when test the mail.");
		}else{
			response.getWriter().print("the mail-address isn't exist:"+TestMailExist.getTestInfo(r) );
		}*/
		
	}
	
	@RequestMapping("/userweb/retrievePasswordByCel")
	public void retirevePasswordByCel(User user,String code,HttpSession session,HttpServletResponse response) throws IOException{
		//ModelAndView modelAndView = new  ModelAndView();
		
		System.out.println("user:"+user);
		System.out.println("code:"+code);
		
		String refCode = (String)session.getAttribute("code");
		session.removeAttribute("code");
		System.out.println("refCode:"+refCode);


		//JSONObject jsonObject = JSONObject.fromObject(user);
		//response.setContentType("application/json;charset=UTF-8");
		//System.out.println(jsonObject);
		//response.getWriter().print(jsonObject);
		
		if(user.getTelNum()!=null){
			if(code.equals(refCode)){
				if(userService.getUserByCel(user)!=null){
					session.setAttribute("user", user);
					System.out.println("Prepare to set new pwd.");
					//System.out.println("user:"+user);
					response.getWriter().print("1");
					//modelAndView.setViewName("/userweb/setNewPasswordPage");
				}else{
					System.out.println("non-user");
					response.getWriter().print("2");
					//modelAndView.setViewName("userweb/retrievePasswordByCel");
				}
			}else{
				System.out.println("verification is not correct!");
				response.getWriter().print("3");
				//modelAndView.setViewName("userweb/retrievePasswordByCel");
			}
		}else{
			System.out.println("enter the page!");
			session.setAttribute("celStat", 0);
			response.getWriter().print("0");
			//modelAndView.setViewName("userweb/retrievePasswordByCel");
		}
		
		
		//return modelAndView;
	}
	
	@RequestMapping("/userweb/retrievePasswordByMail")
	public void retirevePasswordByMail(User user,String code,HttpSession session,HttpServletResponse response){
		
		//ModelAndView modelAndView = new ModelAndView();
		System.out.println("mail?"+user);
		System.out.println("response:"+response);
		//System.out.println(user);
		
		String refCode = (String)session.getAttribute("code");
		session.removeAttribute("code");
		System.out.println("refCode:"+refCode);
		
		
		//response.setContentType("application/json;charset=UTF-8");
		
		Integer res = 0;
		
		if(user.getMail()!=null){
			if(code.equals(refCode)){

				if(userService.getUserByMail(user)!=null){
					session.setAttribute("user", user);
					//System.out.println("setNewPassword");
					res = 1;
						//response.getWriter().print("1");
					//modelAndView.setViewName("/userweb/setNewPasswordPage");
				}else{
					System.out.println("non-user");
					res = 2;
						//response.getWriter().print("2");
					//modelAndView.setViewName("userweb/retrievePasswordByMail");
				}
			}else{
				System.out.println("verification is not correct!");
				res = 3;
					//response.getWriter().print("3");
			}
		}else{
			System.out.println("retrievePasswordByMail:enter the page!");
			res = 0;
				//response.getWriter().print("0");
			//modelAndView.setViewName("userweb/retrievePasswordByMail");
		}
		//JSONObject jsonObject = JSONObject.fromObject(res);
		try {
			response.getWriter().print(res.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Error:"+e.toString());
		}
		System.out.println("Response info:"+res);
		//return modelAndView;
	}
	
	@RequestMapping("/userweb/setNewPassword")
	public void setNewPassword(String pwd,String pwd_rpt,HttpSession session,HttpServletResponse response) throws IOException{
		//ModelAndView modelAndView = new ModelAndView();
		
		User user = (User) session.getAttribute("user");
		System.out.println("pwd:"+pwd+"?pwd_rpt:"+pwd_rpt);
		if(user!=null){
			if(pwd.equals(pwd_rpt)){
				user.setPassword(pwd);
				if(userService.retirevePassword(user)){
					session.setAttribute("retrieveStat", 1);
					response.getWriter().print("1");
					//modelAndView.setViewName("/user/setNewPasswordSucceed");
				}else{
					session.setAttribute("retrieveStat", 2);
					response.getWriter().print("2");
					//modelAndView.setViewName("/user/setNewPasswordFailed");
				}
			}else{
				session.setAttribute("retrieveStat", 3);
				response.getWriter().print("3");
				//modelAndView.setViewName("/user/setNewPassword");
			}
			
		}else{
			session.setAttribute("retrieveStat", 0);
			response.getWriter().print("0");
			//modelAndView.setViewName("/user/retirevePasswordByCel");
		}
		
		//return modelAndView;
	}
	
	@Deprecated	
	@RequestMapping("/userweb/retrievePassword")
	public ModelAndView retrievePassword(String code,User user,HttpSession session){
		ModelAndView modelAndView = new ModelAndView();
		
		if(code.equals(session.getAttribute("code"))){
			if(userService.retirevePassword(user)){
				session.setAttribute("retrieveStat", 1);
			}else{
				session.setAttribute("retrieveStat", 2);
				
			}
		}else{
			session.setAttribute("retrieveStat", 0);
			modelAndView.setViewName("/user/retirevePassword");
		}
		
		return modelAndView;
	}
	
	/**
	 * 帐号安全：修改密码
	 * @param userForBL
	 * @param session
	 * @return
	 */
	@RequestMapping("/userweb/modifyPassword")
	public ModelAndView modifyPassword(UserForBL userForBL,HttpSession session){
		ModelAndView modelAndView = new ModelAndView();
		String id =(String) session.getAttribute("id");
		System.out.println("参数"+id);
		//使用 用户"2" 进行测试
		User currentUser = userService.getUserInfo("2");
		String password = currentUser.getPassword();
		System.out.println(password);
		System.out.println(userForBL.getPrimaryPassword());
		if(!password.equals(userForBL.getPrimaryPassword())){
			System.out.println(1);
			modelAndView.setViewName("userweb/changePasswordsafe");
			modelAndView.addObject("modifyInfo", "fail");
		}else{
			currentUser.setPassword(userForBL.getNewPassword());
			System.out.println(userForBL.getNewPassword());
			System.out.println(currentUser.toString());
			System.out.println(userService.updateUserInfo(currentUser,"password"));
			modelAndView.addObject("modifyInfo", "success");
			modelAndView.setViewName("userweb/first");
		}
		return modelAndView;
	}
	/**
	 * 帐号安全：修改手机号
	 * @param userForBL
	 * @param response
	 * @param session
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/userweb/modifyTelNum")
	public void modifyTelNum(@ModelAttribute UserForBL userForBL,HttpServletResponse response,HttpSession session) throws IOException{
//		System.out.println(userForBL.getTelNum()+userForBL.getVerifyCode());
		String id =(String) session.getAttribute("id");
		System.out.println("参数"+id);
		//使用 用户"2" 进行测试
		User currentUser = userService.getUserInfo("2");
//		User currentUser= userService.getUserInfo(id);
		if(userForBL.getPrimaryPassword().equals(currentUser.getPassword())
				&&userForBL.getVerifyCode().equals(session.getAttribute("ModifyTelVerificationCode"))){
			System.out.println("刘宇在睡觉");
			currentUser.setTelNum(userForBL.getTelNum());
			userService.updateUserInfo(currentUser, "telNum");
			System.out.println("用户Tel修改为："+userForBL.getTelNum());
			response.getWriter().print("success");
		}else{
			response.getWriter().print("fail");
		}
	}
	/**
	 * 帐号安全：修改邮箱
	 * @param userForBL
	 * @param response
	 * @param session
	 * @throws IOException
	 */
	@RequestMapping("/userweb/modifyMail")
	public void modifyMail(@ModelAttribute UserForBL userForBL,HttpServletResponse response,HttpSession session) throws IOException{
		System.out.println("刘宇在睡觉");
		String id =(String) session.getAttribute("id");
		System.out.println("参数"+id);
		//使用 用户"2" 进行测试
		User currentUser = userService.getUserInfo("2");
//		User currentUser= userService.getUserInfo(id);
		if(userForBL.getPrimaryPassword().equals(currentUser.getPassword())
				&& userForBL.getVerifyCode().equals(session.getAttribute("ModifyMailVerificationCode"))){
			System.out.println("刘宇在睡觉");
			currentUser.setMail(userForBL.getMail());
			userService.updateUserInfo(currentUser, "mail");
			System.out.println("用户Mail修改为："+userForBL.getMail());
			response.getWriter().print("success");
		}else{
			response.getWriter().print("fail");
		}

	}
	/**
	 * 修改用户其他信息（旅客类型，车票邮寄地址）
	 * @param userForBL
	 * @param session
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/userweb/modifyOtherInfo")
	public void modifyOtherInfo(@ModelAttribute UserForBL userForBL,HttpServletResponse response,HttpSession session) throws IOException{
		boolean flag = false;
		String result="fail";
		System.out.println("???"+userForBL.getUserType()+" "+userForBL.getAddress());
		String id =(String) session.getAttribute("id");
		System.out.println("参数"+id);
		//使用 用户"2" 进行测试
		User currentUser = userService.getUserInfo("2");
//		User currentUser= userService.getUserInfo(id);
		if(userForBL.getUserType() != null){
			currentUser.setUserType(userForBL.getUserType());
			if(userService.updateUserInfo(currentUser, "userType")){
				flag=true;
			}
		}
		if(userForBL.getAddress() != null){
			currentUser.setAddress(userForBL.getAddress());
			if(userService.updateUserInfo(currentUser, "address")){
				flag=true;
			}
		}
		if(flag){
			result="success";
		}
		response.getWriter().print(result);
	}
	/**
	 * 发送手机验证码
	 * @param telNum
	 * @param response
	 * @param session
	 * @throws IOException
	 */
	@RequestMapping("/userweb/sendVerificationCodeToTel")
	public void sendVerificationCodeToTel(String telNum,HttpServletResponse response,HttpSession session) throws IOException{
		System.out.println(telNum);
		String code = VerificationCode.createVerificationCode(4);
		session.setAttribute("ModifyTelVerificationCode", code);
		SendMessage.sendMessageToPhone(telNum,code);
		/*SMSer smser = new SMSer();
		smser.submitCode(telNum, code);*/
		response.getWriter().print("success");
	}
	/**
	 * 发送邮箱验证码
	 * @param mail
	 * @param response
	 * @param session
	 * @throws IOException
	 */
	@RequestMapping("/userweb/sendVerificationCodeToMailBox")
	public void sendVerificationCodeToMailBox(String mail,HttpServletResponse response,HttpSession session) throws IOException{
		System.out.println(mail);
		if(mail==""){
			response.getWriter().print("fail");
			return;
		}else{
			String code = VerificationCode.createVerificationCode(4);
			session.setAttribute("ModifyMailVerificationCode", code);
			SendMessage.sendMessageToMailBox(mail,code);
			response.getWriter().print("success");
		}
	}

}
