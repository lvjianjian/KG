package cn.youedata.KG.Controller;

import cn.youedata.KG.Dao.EntityDaoImpl;
import cn.youedata.KG.Dao.Ment2EntDaoImpl;
import cn.youedata.KG.Dao.TripleDaoImpl;
import cn.youedata.KG.Global;
import cn.youedata.KG.Service.QueryService;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @Autowired
    QueryService queryService;


    @RequestMapping("/test1.do")
    public String test1() {
        return "test1";
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
        return queryService.getEntityNamesByMention(mention);
    }


    /**
     * 通过实体名字获取所有与实体有关的关系
     * @param entity
     * @return map 谓语对应的宾语只有一个，则value为string，否则为一个list,
     */
    @RequestMapping(value = "/info.do")
    @ResponseBody
    public Map<String,Object> entityInfo(String entity) {
        return queryService.getAllInfosByEntity(entity);
    }

}
