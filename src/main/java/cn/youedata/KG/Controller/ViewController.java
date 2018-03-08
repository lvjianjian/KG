package cn.youedata.KG.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/view")
public class ViewController {
    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/search")
    public String search() {
        return "search";
    }

    @RequestMapping("/api")
    public String api() {
        return "api";
    }

    @RequestMapping("/contributors")
    public String contributors() {
        return "contributors";
    }
}
