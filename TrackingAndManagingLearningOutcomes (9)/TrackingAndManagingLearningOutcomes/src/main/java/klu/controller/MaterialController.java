package klu.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MaterialController {

    @GetMapping("/viewmaterials")
    public String viewMaterials() {
        // Logic to fetch materials (if any) can be added here
        return "viewmaterials"; // This refers to the 'viewmaterials.jsp' file located in /WEB-INF/views/
    }
}
