package cn.youedata.KG;

/**
 * Created by zhongjianlv on 2018/3/5
 */
public class Global {
    /**
     * 数据库名字
     */
    public static String KG_DB_NAME = "ada_dbpedia";

    /**
     * 数据集合id字段名
     */
    public static String KG_COLLECTION_FIELD_NAME_ID = "_id";

    /**
     * ment2ent数据集合名字
     */
    public static String KG_COLLECTION_NAME_MENT2ENT = "ment2ent";

    /**
     * ment2ent数据集合mention字段名
     */
    public static String KG_COLLECTION_MENT2ENT_FIELD_NAME_MENTION = "m";

    /**
     * ment2ent数据集合entity字段名
     */
    public static String KG_COLLECTION_MENT2ENT_FIELD_NAME_ENTITY = "e";

    /**
     * entities数据集合名字
     */
    public static String KG_COLLECTION_NAME_ENTITIES = "entities";

    /**
     * triples数据集合名字
     */
    public static String KG_COLLECTION_NAME_TRIPLES = "triples";

    /**
     * triples数据集合主语subject字段名
     */
    public static String KG_COLLECTION_TRIPLES_FIELD_NAME_SUBJECT = "s";

    /**
     * triples数据集合宾语object字段名
     */
    public static String KG_COLLECTION_TRIPLES_FIELD_NAME_OBJECT = "o";

    /**
     * triples数据集合谓语predicate字段名
     */
    public static String KG_COLLECTION_TRIPLES_FIELD_NAME_PREDICATE = "p";

    /**
     * mongodb数据库 连接ip
     */
    public static String MONGODB_IP = "192.168.131.192";

    /**
     * mongodb数据库 连接端口
     */
    public static String MONGODB_PORT = "27017";

    /**
     * 连接池中的最大连接数
     */
    public static int MONGODB_MAX_CONNECTION = 50;

    /**
     * 它与上面的值相乘的结果就是线程队列最大值。如果连接线程排满了队列就会抛出“Out of semaphores to get db”错误。
     */
    public static int MONGODB_MAX_ALLOWED_CONNECTION_MULTIPLIER = 5;

    /**
     * 最大等待可用连接的时间
     */
    public static int MONGODB_MAX_WAIT_TIME = 1000 * 60 * 2;

    /**
     * 最大连接超时时间
     */
    public static int MONGODB_MAX_CONNECTION_TIMEOUT = 1000 * 60 * 1;
}
