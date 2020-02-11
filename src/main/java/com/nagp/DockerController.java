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
public class DockerController {
	/**
	 * @param model
	 * @return JSP view
	 */
	@RequestMapping(value="/docker", method = RequestMethod.GET)
	public String sayHelloToDocker(Model model){
		model.addAttribute("welcome", "Prod");		
		return "docker";
	}
}
