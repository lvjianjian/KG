package cn.youedata.KG;

/**
 * Created by zhongjianlv on 2018/3/5
 */
public class Global {
    public static String KG_DB_NAME = "cndbpedia";
    public static String KG_COLLECTION_MENT2ENT_NAME = "ment2ent";
    public static String KG_COLLECTION_MENT2ENT_MENTION = "m";
    public static String KG_COLLECTION_MENT2ENT_ENTITY = "e";

    public static String KG_COLLECTION_ENTITIES_NAME = "entities";
    public static String KG_COLLECTION_ENTITIES_ID = "_id";

    public static String KG_COLLECTION_TRIPLES_NAME = "triples";
    public static String KG_COLLECTION_TRIPLES_SUBJECT = "s";
    public static String KG_COLLECTION_TRIPLES_OBJECT = "o";
    public static String KG_COLLECTION_TRIPLES_Predicate = "p";

    public static String MONGODB_IP = "192.168.131.192";
    public static String MONGODB_PORT = "27017";
    public static int MONGODB_MAX_CONNECTION = 50;
    public static int MONGODB_MAX_ALLOWED_CONNECTION_MULTIPLIER = 50;
    public static int MONGODB_MAX_WAIT_TIME = 1000 * 60 * 2;
    public static int MONGODB_MAX_CONNECTION_TIMEOUT = 1000 * 60 * 1;
}
