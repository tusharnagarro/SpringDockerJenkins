package com.nagp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author tusharkumar01
 *
 */
@Controller
public class JenkinsController {
	/**
	 * @param model
	 * @return JSP view
	 */
	@RequestMapping(value="/jenkins", method = RequestMethod.GET)
	public String sayHelloToJenkins(Model model){
		model.addAttribute("welcome", "Dev");
		return "jenkins";
	}
	
}
