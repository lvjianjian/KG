package cn.youedata.KG.Service;

import cn.youedata.KG.Dao.EntityDaoImpl;
import cn.youedata.KG.Dao.Ment2EntDaoImpl;
import cn.youedata.KG.Dao.StatisticsDaoImpl;
import cn.youedata.KG.Dao.TripleDaoImpl;
import cn.youedata.KG.Global;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhongjianlv on 2018/3/9
 */

@Service
public class QueryService {

    @Autowired
    TripleDaoImpl tripleDao;

    @Autowired
    EntityDaoImpl entityDao;

    @Autowired
    Ment2EntDaoImpl ment2EntDao;

    @Autowired
    StatisticsDaoImpl statisticsDao;



    /**
     * 通过mention获取所有实体名字
     *
     * @param mention
     * @return List<String></>
     */
    public List<String> getEntityNamesByMention(String mention) {
        List<String> l = new ArrayList<>();
        if(mention == null || mention.equals("")) return l;
        if (mention != null) {
            List<Document> documents = ment2EntDao.find(Global.KG_COLLECTION_MENT2ENT_FIELD_NAME_MENTION, mention);
            if (documents != null)
                for (Document doc : documents) {
                    l.add(doc.getString(Global.KG_COLLECTION_MENT2ENT_FIELD_NAME_ENTITY));
                }

        }
        return l;
    }


    /**
     * 通过实体名字获取所有与实体有关的关系
     * @param entity
     * @return map 谓语对应的宾语只有一个，则value为string，否则为一个list,
     */
    public Map<String, Object> getAllInfosByEntity(String entity) {
        Map<String, Object> map = new HashMap<>();
        if(entity == null || entity.equals("")) return map;
        List<Document> relationsByEntity = tripleDao.find(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_SUBJECT, entity);
        if (relationsByEntity == null || relationsByEntity.size() == 0) return map;


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

        return map;
    }

    /**
     * 通过集合名字获取历史统计记录
     */
    public List<Document> getAllStatistics(String colName) {
        return statisticsDao.find(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_COLNAME, colName);
    }
}
