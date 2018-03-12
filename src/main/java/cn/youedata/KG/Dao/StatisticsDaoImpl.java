package cn.youedata.KG.Dao;

import cn.youedata.KG.Global;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.springframework.stereotype.Service;

@Service
public class StatisticsDaoImpl extends AbstractMongoDao {

    @Override
    protected String getCollectionName() {
        return Global.KG_COLLECTION_NAME_STATISTICS;
    }

    /**
     * 统计集合中文档的数量
     * @param colName 要统计的集合
     * @return  文档数量
     */
    public long count(String colName) {
        long count = 0;
        if (colName == null || colName.length() == 0 || "".equals(colName)) return count;
        MongoDatabase db = mongoDBHelper.getKG_DB(); //获取数据库实例
        MongoCollection<Document> statisticsColl = db.getCollection(colName);   //获取被统计的集合
        count = statisticsColl.count();
        return count;
    }

    public static void main(String[] args) {
        StatisticsDaoImpl dao = new StatisticsDaoImpl();
        System.out.println(dao.count("entities"));
    }
}
