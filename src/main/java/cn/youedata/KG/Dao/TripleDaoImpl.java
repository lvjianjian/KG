package cn.youedata.KG.Dao;

import cn.youedata.KG.Global;
import org.springframework.stereotype.Service;

/**
 * Created by zhongjianlv on 2018/3/7
 */
@Service
public class TripleDaoImpl extends AbstractMongoDao{

    @Override
    protected String getCollectionName() {
        return Global.KG_COLLECTION_NAME_TRIPLES;
    }
}
