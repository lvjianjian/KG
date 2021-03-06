package cn.youedata.KG.Controller;

import cn.youedata.KG.Global;
import cn.youedata.KG.Service.QueryService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.log4j.Logger;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.JstlView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/view")
public class ViewController {
    @Autowired
    QueryService queryService;
    private static Logger logger = Logger.getLogger(ViewController.class);

    @RequestMapping("/index")
    public ModelAndView index() {
        ModelAndView view = new ModelAndView("/index");
        List<Document> entitiesStatistics = queryService.getAllStatistics(Global.KG_COLLECTION_NAME_ENTITIES);
        List<Document> triplesStatistics = queryService.getAllStatistics(Global.KG_COLLECTION_NAME_TRIPLES);
        ObjectMapper mapper = new ObjectMapper();
        try {
            view.addObject("entitiesStatistics", mapper.writeValueAsString(entitiesStatistics));
            view.addObject("triplesStatistics", mapper.writeValueAsString(triplesStatistics));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return view;
    }

    @RequestMapping("/search")
    public String search() {
        return search("");
    }

    @RequestMapping(value = "/search", params = {"mention"})
    public String search(String mention) {
        return "search_entities";
    }

    @RequestMapping(value = "/search", params = {"mention", "entity"})
    public String search(String mention, String entity) {
        return "search_result";
    }

    @RequestMapping(value = "/search", params = {"mention", "entity", "kg_base"})
    public String search(String mention, String entity, String kg_base) {
        return "search_result1";
    }

    /**
    @RequestMapping(value = "/search", params = {"mention", "entity"})
    public ModelAndView search(String mention, String entity) {
        if (entity == null || entity.length() == 0) {
//            return search(mention);
            return null;
        }
        ModelAndView modelAndView = new ModelAndView("search");
        ObjectMapper mapper = new ObjectMapper();
        List<String> entityNames = queryService.getEntityIdsByMention(mention, Global.KG_BAIDUBAIKE);
        Map<String, List> entityInfos = queryService.getAllInfosByEntity(entity, Global.KG_BAIDUBAIKE);
        try {
            Map<String, List> mentionInfos = queryService.getAllInfosByEntity(mention, Global.KG_BAIDUBAIKE);
            if (mentionInfos != null && mentionInfos.size() != 0) {
                entityNames.add(mention);
            }
            String entityNamesString = mapper.writeValueAsString(entityNames);
            String entityInfosString = mapper.writeValueAsString(entityInfos);
            modelAndView.addObject("entityNames", entityNamesString);
            modelAndView.addObject("entityInfos", entityInfosString);
            modelAndView.addObject("mention", mention);
            modelAndView.addObject("entity", entity);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return modelAndView;
    }*/

    @RequestMapping("/api")
    public String api() {
        return "api";
    }

    @RequestMapping("/contributors")
    public String contributors() {
        return "contributors";
    }
}
