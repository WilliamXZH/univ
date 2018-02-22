package com.group3.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.group3.po.Partner;

import com.group3.service.PartnerService;

import oracle.net.aso.n;


@Controller
public class PartnerControllr {
	
	@Resource
	PartnerService partnerService;
	
	/**
	 * 根据主用户ID查询所有常用联系人
	 */
	
	@RequestMapping("userweb/partnerSelect")
	public ModelAndView partnerSelect(HttpSession session){
		/*String id =(String) session.getAttribute("id");*/
		/*String id =(String) session.getAttribute("name");*/
		ModelAndView modelAndView = new ModelAndView();
		String id = "9";
		String name = "aaaa";
		
		Partner partner1 = partnerService.getSelfInfo(id,name);
		modelAndView.addObject("partner1",partner1);
		List<Partner> partner = partnerService.getPartnerInfo(id);
 		System.out.println(partner);
 		modelAndView.setViewName("/userweb/commonfriend");
 		modelAndView.addObject("partner",partner);
		return modelAndView;
	}
	
	/**
	 * 编辑常用联系人信息
	 * @param partner
	 * @return 
	 */
	@RequestMapping("userweb/partnerInfoEdit1")
	public ModelAndView partnerInfoEdit(String mainUserId ,String name){
		System.out.println(mainUserId+name);
		ModelAndView modelAndView = new ModelAndView();
		Partner partner = partnerService.partnerEdit(mainUserId,name);
			modelAndView.setViewName("/userweb/ChangeFriend");
			modelAndView.addObject("partner",partner);
			return modelAndView;

	}
	/**
	 * 保存编辑过的常用联系人信息
	 * @param partner
	 * @return 
	 */
	@RequestMapping("/userweb/partnerSave")
	public ModelAndView partnerSave(Partner partner){
		ModelAndView modelAndView = new ModelAndView();
		boolean result = partnerService.partnerSave(partner);
		if(result){
			modelAndView.setView(new RedirectView("partnerSelect"));
			return modelAndView;
		}
		modelAndView.setViewName("user/partnerEdit");
		return modelAndView;
	}
	
	/**
	 * 删除常用联系人
	 * @param partner
	 * @return
	 */
	@RequestMapping("/userweb/partnerDelete1")
	public ModelAndView partnerDelete(Partner partner,HttpSession session){
		ModelAndView modelAndView = new ModelAndView();
		boolean result=partnerService.partnerDelete(partner);
		if(result){
			modelAndView.setView(new RedirectView("partnerSelect"));
			return modelAndView;
		}
		modelAndView.setViewName("user/partnerInfo");

		return modelAndView;
		
	}
	
	/**
	 * 新增常用联系人
	 * @param partner
	 * @return
	 */
	@RequestMapping("/userweb/partnerAdd")
	public ModelAndView userRegister(Partner partner,HttpSession session){
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("kan"+partner.getMainUserId());
		
		if(partner.getName()!=null){
			boolean result = partnerService.partnerAdd(partner);
			if(result){
				modelAndView.setView(new RedirectView("partnerSelect"));
				return modelAndView;
				//return partnerSelect(session);
				//modelAndView.addObject("partner",partner);
				//modelAndView.setViewName("userweb/partnerSelect");
				//return modelAndView;
			}
		}
		modelAndView.setViewName("userweb/AddFriend");
		return modelAndView;
	}
}
