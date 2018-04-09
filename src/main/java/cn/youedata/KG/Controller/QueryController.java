package cn.youedata.KG.Controller;

import cn.youedata.KG.Dao.EntityDaoImpl;
import cn.youedata.KG.Dao.Ment2EntDaoImpl;
import cn.youedata.KG.Dao.TripleDaoImpl;
import cn.youedata.KG.Global;
import cn.youedata.KG.Service.QueryService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.log4j.Logger;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.util.*;
import java.util.function.BiConsumer;

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
        Map<String, Object> allInfosByEntity = queryService.getAllInfosByEntity(entity, Global.KG_BAIDUBAIKE);
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
     * 通过mention获取所有实体名字
     *
     * @param mention
     * @return List<String></>
     */
    @RequestMapping(value = "/query.do")
    @ResponseBody
    public List<String> mentionToEntityNames(String mention) {
        return queryService.getEntityIdsByMention(mention, Global.KG_BAIDUBAIKE);
    }


    /**
     * 通过实体名字获取所有与实体有关的关系
     *
     * @param entity
     * @return map 谓语对应的宾语只有一个，则value为string，否则为一个list,
     */
    @RequestMapping(value = "/info.do")
    @ResponseBody
    public Map<String, Object> entityInfo(String entity) {
        return queryService.getAllInfosByEntity(entity, Global.KG_BAIDUBAIKE);
    }

    /**
     * 通过实体名字和属性名字获取返回值
     *
     * @param entity
     * @param attribute
     * @return list
     */
    @RequestMapping(value = "/attr.do")
    @ResponseBody
    public List<String> attrOfEntity(String entity, String attribute) {
        System.out.println(entity);
        return queryService.getOneInfoByEntityAndAttribute(entity, attribute, Global.KG_BAIDUBAIKE);
    }
}
