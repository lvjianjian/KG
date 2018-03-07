package cn.youedata.KG.Dao;

import cn.youedata.KG.Global;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static com.mongodb.client.model.Filters.eq;

/**
 * Created by zhongjianlv on 2018/3/7
 */
@Service
public class EntityDaoImpl extends AbstractMongoDao{


    @Override
    protected String getCollectionName() {
        return Global.KG_COLLECTION_NAME_ENTITIES;
    }

}
