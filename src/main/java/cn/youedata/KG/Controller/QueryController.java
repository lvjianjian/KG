package cn.youedata.KG.Controller;

import cn.youedata.KG.Global;
import cn.youedata.KG.Service.QueryService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

import static com.mongodb.client.model.Filters.eq;


/**
 * Created by zhongjianlv on 2018/3/5
 */

@Controller
@RequestMapping("/search")
public class QueryController {

    private static Logger logger = Logger.getLogger(QueryController.class);

    @Autowired
    QueryService queryService;


    @RequestMapping("/test3.do")
    public ModelAndView test1(String entity) {
        logger.info("test3");
        ModelAndView modelAndView = new ModelAndView("test3");
        Map<String, List> allInfosByEntity = queryService.getAllInfosByEntity(entity, Global.KG_BAIDUBAIKE);
        ObjectMapper mapper = new ObjectMapper();
        modelAndView.addObject("entity", entity);
        try {
            String json = mapper.writeValueAsString(allInfosByEntity);
            modelAndView.addObject("triples", json);

        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return modelAndView;
    }


    /**
     * 通过mention获取kg_base知识库中的所有实体名字
     *
     * @param mention
     * @param kg_base
     * @return List<String></>
     */
    @RequestMapping(value = "/query.do", params = {"mention", "kg_base"})
    @ResponseBody
    public List<String> mentionToEntityNames(String mention, String kg_base) {
        return queryService.getEntityIdsByMention(mention, kg_base);
    }


    /**
     * 通过实体名字获取kg_base知识库中的所有与实体有关的关系
     *
     * @param entity
     * @param kg_base
     * @return map 谓语对应的宾语只有一个，则value为string，否则为一个list,
     */
    @RequestMapping(value = "/info.do", params = {"entity", "kg_base"})
    @ResponseBody
    public Map<String, List> entityInfo(String entity, String kg_base) {
        return queryService.getAllInfosByEntity(entity, kg_base);
    }

    /**
     * 通过实体名字和属性名字获取kg_base知识库中的返回值
     *
     * @param entity
     * @param attribute
     * @param kg_base
     * @return list
     */
    @RequestMapping(value = "/attr.do", params = {"entity", "attribute", "kg_base"})
    @ResponseBody
    public List<String> attrOfEntity(String entity, String attribute, String kg_base) {
        return queryService.getOneInfoByEntityAndAttribute(entity, attribute, kg_base);
    }

    /**
     * 通过mention获取所有实体名字
     *
     * @param mention
     * @return List<String></>
     */
    @RequestMapping(value = "/query.do", params = "mention")
    @ResponseBody
    public Map<String, List<String>> mentionToEntityNames(String mention) {
        return queryService.getEntityIdsByMention(mention);
    }


    /**
     * 通过实体名字获取所有与实体有关的关系
     *
     * @param entity
     * @return map 谓语对应的宾语只有一个，则value为string，否则为一个list,
     */
    @RequestMapping(value = "/info.do", params = {"entity"})
    @ResponseBody
    public Map<String, Map<String, List>> entityInfo(String entity) {
        return queryService.getAllInfosByEntity(entity);
    }

    /**
     * 通过实体名字和属性名字获取返回值
     *
     * @param entity
     * @param attribute
     * @return list
     */
    @RequestMapping(value = "/attr.do", params = {"entity", "attribute"})
    @ResponseBody
    public Map<String, List<String>> attrOfEntity(String entity, String attribute) {
        return queryService.getOneInfoByEntityAndAttribute(entity, attribute);
    }
}
