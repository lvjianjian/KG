package cn.youedata.KG.Dao;

import cn.youedata.KG.Global;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;

import static com.mongodb.client.model.Filters.eq;

/**
 * Created by zhongjianlv on 2018/3/7
 */
public abstract class AbstractMongoDao {
    protected MongoDBHelper mongoDBHelper = MongoDBHelper.getMongoDBDaoImplInstance();

    /**
     * 获取集合名
     *
     * @return
     */
    protected abstract String getCollectionName();

    /**
     * 判断集合中_id是否存在
     *
     * @param id
     * @param kg_base
     * @return
     */
    public boolean exist(String id, String kg_base) {
        if (id == null) return false;
        MongoDatabase db = null;
        MongoCollection<Document> collection = null;
        db = mongoDBHelper.getKG_DB(); //获取数据库实例
        collection = db.getCollection(kg_base + getCollectionName());
        FindIterable<Document> ms = collection.find(eq(Global.KG_COLLECTION_FIELD_NAME_ID, id));
        MongoCursor<Document> iterator = ms.iterator();
        if (iterator.hasNext()) {
            return true;
        }
        return false;
    }

    /**
     * 找到集合中_id为id的数据
     *
     * @param id
     * @param kg_base
     * @return
     */
    public List<Document> find(String id, String kg_base) {
        return find(Global.KG_COLLECTION_FIELD_NAME_ID, id, kg_base);
    }


    /**
     * 找到集合中key为value的数据
     *
     * @param key
     * @param value
     * @param kg_base
     * @return
     */
    public List<Document> find(String key, String value, String kg_base) {
        if (key == null || value == null) return null;
        List<Document> r = new ArrayList<>();
        MongoDatabase db = null;
        MongoCollection<Document> collection = null;
        db = mongoDBHelper.getKG_DB(); //获取数据库实例
        collection = db.getCollection(kg_base + getCollectionName());
        FindIterable<Document> ms = collection.find(eq(key, value));
        MongoCursor<Document> iterator = ms.iterator();
        while (iterator.hasNext()) {
            r.add(iterator.next());
        }
        return r;
    }

    /**
     * 向集合中插入文档
     *
     * @param doc 被插入的文档
     * @param kg_base
     */
    public void insert(Document doc, String kg_base) {
        MongoDatabase db = null;
        MongoCollection<Document> collection = null;
        db = mongoDBHelper.getKG_DB(); //获取数据库实例
        collection = db.getCollection(kg_base + getCollectionName());
        collection.insertOne(doc);
    }

    public static void main(String[] args) {
        EntityDaoImpl entityDao = new EntityDaoImpl();
        System.out.println(entityDao.find(Global.KG_COLLECTION_MENT2ENT_FIELD_NAME_MENTION,
                "乔丹",Global.KG_BAIDUBAIKE));
    }

}
