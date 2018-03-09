package cn.youedata.KG.Controller;

import cn.youedata.KG.Service.QueryService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.JstlView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/view")
public class ViewController {
    @Autowired
    QueryService queryService;

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/search")
    public String search() {
        return "search";
    }

    @RequestMapping(value = "/search", params = {"mention"})
    public ModelAndView search(String mention) {
        ModelAndView modelAndView = new ModelAndView("search");
        if (mention == null || mention.length() == 0) {
            return modelAndView;
        }
        String entity = "";
        String entityNamesString = null, entityInfosString = null;
        ObjectMapper mapper = new ObjectMapper();
        List<String> entityNames = queryService.getEntityNamesByMention(mention);
        Map<String, Object> entityInfos = queryService.getAllInfosByEntity(mention);
        try {
            if (entityInfos.size() != 0) {
                entityInfosString = mapper.writeValueAsString(entityInfos);
                entityNames.add(mention);
                entity = mention;
            } else if (entityNames.size() != 0) {
                entityInfosString = mapper.writeValueAsString(queryService.getAllInfosByEntity(entityNames.get(0)));
                entity = entityNames.get(0);
            } else {
                entityInfosString = mapper.writeValueAsString(new ArrayList<>());
            }
            entityNamesString = mapper.writeValueAsString(entityNames);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        modelAndView.addObject("mention", mention);
        modelAndView.addObject("entityNames", entityNamesString);
        modelAndView.addObject("entityInfos", entityInfosString);
        modelAndView.addObject("entity",entity);
        return modelAndView;
    }

    @RequestMapping(value = "/search", params = {"mention", "entity"})
    public ModelAndView search(String mention, String entity) {
        if (entity == null || entity.length() == 0) {
            return search(mention);
        }
        ModelAndView modelAndView = new ModelAndView("search");
        ObjectMapper mapper = new ObjectMapper();
        List<String> entityNames = queryService.getEntityNamesByMention(mention);
        Map<String, Object> entityInfos = queryService.getAllInfosByEntity(entity);
        try {
            entityNames.add(mention);
            String entityNamesString = mapper.writeValueAsString(entityNames);
            String entityInfosString = mapper.writeValueAsString(entityInfos);
            modelAndView.addObject("entityNames", entityNamesString);
            modelAndView.addObject("entityInfos", entityInfosString);
            modelAndView.addObject("mention", mention);
            modelAndView.addObject("entity",entity);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return modelAndView;
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
