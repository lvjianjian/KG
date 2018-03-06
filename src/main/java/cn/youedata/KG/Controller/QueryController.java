package cn.youedata.KG.Controller;

import cn.youedata.KG.Dao.MongoDBHelper;
import cn.youedata.KG.Global;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCursor;
import org.bson.Document;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.print.Doc;
import java.lang.reflect.Array;
import java.util.*;
import java.util.function.BiConsumer;

import static com.mongodb.client.model.Filters.eq;


/**
 * Created by zhongjianlv on 2018/3/5
 */

@Controller
@RequestMapping("/search")
public class QueryController {

    private MongoDBHelper mongoDBHelper = MongoDBHelper.getMongoDBDaoImplInstance();

    @RequestMapping("/test1.do")
    public String test1(){
        return "test1";
    }

    /**
     * 通过mention获取实体名字
     *
     * @param mention
     * @return
     */
    @RequestMapping("/query.do")
    @ResponseBody
    public List<String> getEntityNamesByMention(String mention) {
        MongoDatabase db = null;
        MongoCollection<Document> collection = null;
        List<String> l = new ArrayList<String>();
        if (mention != null) {
            db = mongoDBHelper.getKG_DB(); //获取数据库实例
            collection = db.getCollection(Global.KG_COLLECTION_MENT2ENT_NAME);
            FindIterable<Document> ms = collection.find(eq(Global.KG_COLLECTION_MENT2ENT_MENTION, mention));
            MongoCursor<Document> iterator = ms.iterator();
            while (iterator.hasNext()) {
                l.add(iterator.next().getString(Global.KG_COLLECTION_MENT2ENT_ENTITY));
            }

        }
        if (l.size() == 0) {
            if (db == null) {
                db = mongoDBHelper.getKG_DB();
            }
            MongoCollection<Document> collection1 = db.getCollection(Global.KG_COLLECTION_ENTITIES_NAME);
            FindIterable<Document> item = collection1.find(eq(Global.KG_COLLECTION_ENTITIES_ID, mention));
            if (item.iterator().hasNext()) l.add(mention);
        }
        return l;
    }

    @RequestMapping("/info.do")
    @ResponseBody
    public Map<String, Object> getAllInfosByEntity(String entity) {
        List<Document> relationsByEntity = getRelationsByEntity(entity);
        if (relationsByEntity == null || relationsByEntity.size() == 0) return null;
        Map<String, Object> map = new HashMap<>();

        for (int i = 0; i < relationsByEntity.size(); i++) {
            Document document = relationsByEntity.get(i);
            String predicate = document.getString(Global.KG_COLLECTION_TRIPLES_Predicate);
            String objective = document.getString(Global.KG_COLLECTION_TRIPLES_OBJECT);
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

        List<Document> nodes = new ArrayList<>();
        List<Document> edges = new ArrayList<>();
        Document data = new Document().append("nodes", nodes).append("edges", edges);
        nodes.add(new Document("id", entity));
        map.forEach(new BiConsumer<String, Object>() {
            @Override
            public void accept(String s, Object o) {
                if (o instanceof String) {
                    nodes.add(new Document().append("id", o));
                    edges.add(new Document().append("target", o)
                            .append("source", entity)
                            .append("relationship", s));
                } else {
                    List<String> o1 = (List<String>) o;
                    for (int i = 0; i < o1.size(); i++) {
                        String objective = o1.get(i);
                        nodes.add(new Document().append("id", o).append("parent", s));
                        edges.add(new Document().append("target", o)
                                .append("source", entity)
                                .append("relationship", s));
                    }
                }
            }
        });
        map.put("cytoscape_json", data.toJson());
        return map;
    }

    private List<Document> getRelationsByEntity(String entityName) {
        MongoDatabase db = null;
        MongoCollection<Document> collection = null;
        List<Document> l = new ArrayList<>();
        if (entityName != null) {
            db = mongoDBHelper.getKG_DB();
            collection = db.getCollection(Global.KG_COLLECTION_TRIPLES_NAME);
            FindIterable<Document> ms = collection.find(eq(Global.KG_COLLECTION_TRIPLES_SUBJECT, entityName));
            MongoCursor<Document> iterator = ms.iterator();
            while (iterator.hasNext()) l.add(iterator.next());
        }
        return l;
    }


    public static void main(String[] args) {
        QueryController queryController = new QueryController();
        System.out.println(queryController.getAllInfosByEntity("乔丹（出生于1988年的美国篮球运动员）"));
    }

}
