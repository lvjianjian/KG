package cn.youedata.KG.Dao;

import cn.youedata.KG.Global;
import com.mongodb.*;
import com.mongodb.client.MongoDatabase;


/**
 * Created by zhongjianlv on 2018/3/5
 */
public class MongoDBHelper {
    /**
     * MongoClient的实例代表数据库连接池，是线程安全的，可以被多线程共享，客户端在多线程条件下仅维持一个实例即可
     * Mongo是非线程安全的，目前mongodb API中已经建议用MongoClient替代Mongo
     */
    private MongoClient mongoClient = null;


    private MongoDBHelper() {
        if (mongoClient == null) {
            MongoClientOptions.Builder build = new MongoClientOptions.Builder();
            build.connectionsPerHost(Global.MONGODB_MAX_CONNECTION);   //与目标数据库能够建立的最大connection数量为50
//            build.autoConnectRetry(true);   //自动重连数据库启动
            build.threadsAllowedToBlockForConnectionMultiplier(Global.MONGODB_MAX_ALLOWED_CONNECTION_MULTIPLIER); //如果当前所有的connection都在使用中，则每个connection上可以有50个线程排队等待
            /*
             * 一个线程访问数据库的时候，在成功获取到一个可用数据库连接之前的最长等待时间为2分钟
             * 这里比较危险，如果超过maxWaitTime都没有获取到这个连接的话，该线程就会抛出Exception
             * 故这里设置的maxWaitTime应该足够大，以免由于排队线程过多造成的数据库访问失败
             */
            build.maxWaitTime(Global.MONGODB_MAX_WAIT_TIME);
            build.connectTimeout(Global.MONGODB_MAX_CONNECTION_TIMEOUT);    //与数据库建立连接的timeout设置为1分钟

            MongoClientOptions myOptions = build.build();
            try {
                //数据库连接实例
                mongoClient = new MongoClient(Global.MONGODB_IP+":"+Global.MONGODB_PORT, myOptions);
            } catch (MongoException e) {
                e.printStackTrace();
            }

        }
    }

    //类初始化时
    private static final MongoDBHelper mongoDBHelper = new MongoDBHelper();


    public static MongoDBHelper getMongoDBDaoImplInstance(){
        return mongoDBHelper;
    }

    public MongoDatabase getDB(String dbName){
        return mongoClient.getDatabase(dbName);
    }

    public MongoDatabase getKG_DB(){
        return getDB(Global.KG_DB_NAME);
    }

    public void close(){
        mongoClient.close();
        mongoClient = null;
    }
}
