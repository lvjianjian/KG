package cn.youedata.KG;

/**
 * Created by zhongjianlv on 2018/3/5
 */
public final class Global {
    /**
     * 数据库名字
     */
    public static String KG_DB_NAME = "ada_dbpedia";


    /**
     * 百度百科Collection的base名
     */
    public static String KG_BAIDUBAIKE = "bdbaike";

    /**
     * 主知识库名字
     */
    public static String KG_MAIN_BASE = KG_BAIDUBAIKE;

    /**
     * 维基百科的Collection的base名
     */
    public static String KG_ZHWIKI = "zhwiki";

    /**
     * 所有知识库的base名
     */
    public static String[] KG_BASES = {KG_BAIDUBAIKE, KG_ZHWIKI};

    /**
     * 数据集合id字段名
     */
    public static String KG_COLLECTION_FIELD_NAME_ID = "_id";


    /**
     * 数据集合label字段名
     */
    public static String KG_COLLECTION_FIELD_NAME_LABEL = "label";

    /**
     * ment2ent数据集合名字
     */
    public static String KG_COLLECTION_NAME_MENT2ENT = "Ment2ent";

    /**
     * Predicates数据集合名字
     */
    public static String KG_COLLECTION_NAME_Predicate = "Predicates";

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
    public static String KG_COLLECTION_NAME_ENTITIES = "Entities";

    /**
     * triples数据集合名字
     */
    public static String KG_COLLECTION_NAME_TRIPLES = "Triples";

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
     * statistics数据集合名字
     */
    public static String KG_COLLECTION_NAME_STATISTICS = "Statistics";

    /**
     * statistics数据集合进行统计的日期字段名
     */
    public static String KG_COLLECTION_STATISTICS_FIELD_NAME_DATA = "data";

    /**
     * statistics数据集合统计数量字段名
     */
    public static String KG_COLLECTION_STATISTICS_FIELD_NAME_COUNT = "count";

    /**
     * statistics数据集合所要统计集合的名字
     */
    public static String KG_COLLECTION_STATISTICS_FIELD_NAME_COLNAME = "colname";


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
