package cn.youedata.KG.Controller;

import cn.youedata.KG.Dao.EntityDaoImpl;
import cn.youedata.KG.Dao.Ment2EntDaoImpl;
import cn.youedata.KG.Dao.TripleDaoImpl;
import cn.youedata.KG.Global;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
    TripleDaoImpl tripleDao;

    @Autowired
    EntityDaoImpl entityDao;

    @Autowired
    Ment2EntDaoImpl ment2EntDao;

    @RequestMapping("/test1.do")
    public String test1() {
        return "test1";
    }

    /**
     * 通过mention获取所有实体名字
     *
     * @param mention
     * @return
     */
    @RequestMapping("/query.do")
    @ResponseBody
    public List<String> getEntityNamesByMention(String mention) {
        List<String> l = new ArrayList<>();
        if (mention != null) {
            List<Document> documents = ment2EntDao.find(Global.KG_COLLECTION_MENT2ENT_FIELD_NAME_MENTION, mention);
            if (documents != null)
                for (Document doc : documents) {
                    l.add(doc.getString(Global.KG_COLLECTION_MENT2ENT_FIELD_NAME_ENTITY));
                }

        }
        if (l.size() == 0) {
            List<Document> documents = entityDao.find(mention);
            if (documents != null && documents.size() != 0)
                l.add(mention);
        }
        return l;
    }


    /**
     * 通过实体名字获取所有与实体有关的关系
     * @param entity
     * @return
     */
    @RequestMapping("/info.do")
    @ResponseBody
    public Map<String, Object> getAllInfosByEntity(String entity) {
        List<Document> relationsByEntity = tripleDao.find(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_SUBJECT, entity);
        if (relationsByEntity == null || relationsByEntity.size() == 0) return null;

        Map<String, Object> map = new HashMap<>();
        for (int i = 0; i < relationsByEntity.size(); i++) {
            Document document = relationsByEntity.get(i);
            String predicate = document.getString(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_PREDICATE);
            String objective = document.getString(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_OBJECT);
            if (!map.containsKey(predicate)) {
                map.put(predicate, objective);
            } else {
                Object o = map.get(predicate);
                if (o instanceof String) {
                    ArrayList<String> objects = new ArrayList<>();
                    objects.add((String) o);
                    objects.add(objective);
                    map.put(predicate, objects);
                } else {
                    ((List) o).add(objective);
                }
            }
        }

//        List<Document> nodes = new ArrayList<>();
//        List<Document> edges = new ArrayList<>();
//        Document data = new Document().append("nodes", nodes).append("edges", edges);
//        nodes.add(new Document("data", new Document("id", entity)));
//        map.forEach(new BiConsumer<String, Object>() {
//            @Override
//            public void accept(String s, Object o) {
//                if (o instanceof String) {
//                    nodes.add(new Document("data", new Document().append("id", o)));
//                    edges.add(new Document("data", new Document().append("target", o)
//                            .append("source", entity)
//                            .append("predicate", s)));
//                } else {
//                    List<String> o1 = (List<String>) o;
//                    nodes.add(new Document("data", new Document().append("id", s)));
//                    edges.add(new Document("data", new Document().append("target", s)
//                            .append("source", entity)
//                            .append("predicate", s)));
//                    for (int i = 0; i < o1.size(); i++) {
//                        String objective = o1.get(i);
//                        nodes.add(new Document("data", new Document().append("id", objective).append("parent", s)));
//
//                    }
//                }
//            }
//        });
//
//        map.put("cytoscape_json", data.toJson());
        return map;
    }




    public static void main(String[] args) {
        QueryController queryController = new QueryController();
        System.out.println(queryController.getAllInfosByEntity("乔丹（出生于1988年的美国篮球运动员）"));
    }

}
