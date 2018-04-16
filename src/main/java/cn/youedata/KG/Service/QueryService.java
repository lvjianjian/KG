package cn.youedata.KG.Service;

import cn.youedata.KG.Dao.*;
import cn.youedata.KG.Global;
import org.apache.log4j.Logger;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;

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

    @Autowired
    SameAsDaoImpl sameAsDao;

    @Autowired
    PredicateDaoImpl predicateDao;

    private static Logger logger = Logger.getLogger(QueryService.class);

    /**
     * 通过id获取对应知识库的label
     *
     * @param id
     * @param kg_base
     * @return
     */
    public String getLabelByIdInEntity(String id, String kg_base) {
        //bdbaike的数据直接返回id为label
        if (kg_base.equals(Global.KG_BAIDUBAIKE)) return id;
        List<Document> documents = entityDao.find(id, kg_base);
        if (documents != null && documents.size() >= 1) {
            return documents.get(0).getString(Global.KG_COLLECTION_FIELD_NAME_LABEL);
        }
        return null;
    }

    /**
     * 通过mention获取所有实体id, 指定知识库
     *
     * @param mention
     * @param kg_base
     * @return List<String></>
     */
    public List<String> getEntityIdsByMention(String mention, String kg_base) {
        List<String> l = new ArrayList<>();
        if (mention == null || mention.equals("")) return l;
        List<Document> documents = ment2EntDao.find(Global.KG_COLLECTION_MENT2ENT_FIELD_NAME_MENTION,
                mention,
                kg_base);
        if (documents != null)
            for (Document doc : documents) {
                l.add(doc.getString(Global.KG_COLLECTION_MENT2ENT_FIELD_NAME_ENTITY));
            }

        logger.info(String.format("query %s in %s: size = %d", mention, kg_base, l.size()));
        return l;
    }

    /**
     * 获取所有知识库的mention对应的entity id, 查找所有知识库
     *
     * @param mention
     * @return
     */
    public Map<String, List<String>> getEntityIdsByMention(String mention) {
        HashMap<String, List<String>> res = new HashMap<>();
        for (String kg_base : Global.KG_BASES) {
            res.put(kg_base, getEntityIdsByMention(mention, kg_base));
        }
        return res;
    }


    /**
     * 通过实体名字获取所有与实体有关的关系，查找所有知识库
     *
     * @param entity
     * @return map key为知识库基名，value为对应知识库的该实体的所有三元组
     */
    public Map<String, Map<String, Object>> getAllInfosByEntity(String entity) {
        Map<String, Map<String, Object>> res = new HashMap<>();
        for (String kg_base : Global.KG_BASES) {
            res.put(kg_base, getAllInfosByEntity(entity, kg_base));
        }
        return res;
    }


    /**
     * 通过实体名字获取所有与实体有关的关系
     *
     * @param entity
     * @param kg_base 指定的知识库名字
     * @return map 谓语对应的宾语只有一个，则value为string，否则为一个list,
     */
    public Map<String, Object> getAllInfosByEntity(String entity, String kg_base) {
        Map<String, Object> map = new HashMap<>();
        if (entity == null || entity.equals("")) return map;
        List<Document> relationsByEntity = tripleDao.find(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_SUBJECT,
                entity, kg_base);
        if (relationsByEntity == null || relationsByEntity.size() == 0) return map;

        List<Document> predicateDocuments = null;
        Document document = null;
        String objective = null;
        for (int i = 0; i < relationsByEntity.size(); i++) {
            document = relationsByEntity.get(i);
            String predicate = document.getString(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_PREDICATE);
            //对zhwiki的谓语做转化
            if (Global.KG_ZHWIKI.equals(kg_base)) {
                predicateDocuments = predicateDao.find(Global.KG_COLLECTION_FIELD_NAME_ID, predicate, kg_base);
                if (predicateDocuments.size() == 0) {
                    logger.warn("no this predicate: " + predicate);
                } else {
                    predicate = predicateDocuments.get(0).getString(Global.KG_COLLECTION_FIELD_NAME_LABEL);
                }
            }
            objective = document.getString(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_OBJECT);
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
     * 通过实体名字和属性获取返回值，查找所有知识库
     *
     * @param entity
     * @param attribute
     * @return 返回一个Map
     */
    public Map<String, List<String>> getOneInfoByEntityAndAttribute(String entity, String attribute) {
        Map<String, List<String>> res = new HashMap<>();
        for (String kg_base : Global.KG_BASES) {
            res.put(kg_base, getOneInfoByEntityAndAttribute(entity, attribute, kg_base));
        }
        return res;
    }

    /**
     * 通过实体名字和属性获取返回值
     *
     * @param entity
     * @param attribute
     * @param kg_base   指定知识库名字
     * @return 返回一个list
     */
    public List<String> getOneInfoByEntityAndAttribute(String entity, String attribute, String kg_base) {
        Map<String, Object> allInfosByEntity = getAllInfosByEntity(entity, kg_base);
        List<String> return_values = null;
        if (allInfosByEntity.containsKey(attribute)) {
            Object o = allInfosByEntity.get(attribute);
            if (o instanceof String) {
                return_values = new ArrayList<>();
                return_values.add((String) o);
            } else {
                return_values = (List) o;
            }
        } else return_values = new ArrayList<>();
        return return_values;
    }


    /**
     * 获取主知识库关于实体的实体链接
     *
     * @param entity_name 实体名字
     * @return map key为知识库名字,value为对应知识库的链接实体名
     */
    public Map<String, List<String>> getSameAsAboutMainKGBase(String entity_name) {
        return getSameAsAboutOneKGBase(Global.KG_MAIN_BASE, entity_name);
    }


    /**
     * 获取主知识库关于实体的实体链接
     *
     * @param main_kg_base 主知识库名字
     * @param entity_name  实体名字
     * @return map key为知识库名字,value为对应知识库的链接实体名
     */
    public Map<String, List<String>> getSameAsAboutOneKGBase(String main_kg_base, String entity_name) {
        sameAsDao.setMainKGName(main_kg_base);
        Map<String, List<String>> res = new HashMap<>();
        for (String kgBase : Global.KG_BASES) {
            if (kgBase.equals(main_kg_base))
                continue;
            List<Document> documents = sameAsDao.find(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_SUBJECT, entity_name);
            List<String> r = new ArrayList<>();
            if (documents != null)
                for (Document document : documents) {
                    r.add(document.getString(Global.KG_COLLECTION_TRIPLES_FIELD_NAME_OBJECT));
                }
            res.put(kgBase, r);
        }
        return res;
    }

    /**
     * 通过集合名字获取历史统计记录
     */
    private List<Document> getAllStatistics(String colName, String kg_base) {
        List<Document> documents = statisticsDao.find(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_COLNAME, colName, kg_base);
        return documents;
    }

    public List<Document> getAllStatistics(String cloName) {
        List<Document> zhWiki = getAllStatistics(cloName, Global.KG_ZHWIKI);
        List<Document> bdBaike = getAllStatistics(cloName, Global.KG_BAIDUBAIKE);
        List<Document> documents = new ArrayList<>();
        for (int i = 0; i < zhWiki.size(); i++) {
            Document doc = new Document();
            doc.putAll(bdBaike.get(i));
            Long count = Long.sum(zhWiki.get(i).getLong(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_COUNT),
                    bdBaike.get(i).getLong(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_COUNT));
            doc.put(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_COUNT, count);
            documents.add(doc);
        }
        return documents;
    }

}
