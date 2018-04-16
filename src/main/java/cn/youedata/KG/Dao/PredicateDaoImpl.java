package cn.youedata.KG.Dao;

import cn.youedata.KG.Global;
import org.springframework.stereotype.Service;

/**
 * Created by zhongjianlv on 2018/4/16
 *
 * 目前主要针对zhwiki的谓语到中文的转化
 */
@Service
public class PredicateDaoImpl extends AbstractMongoDao {
    @Override
    protected String getCollectionName() {
        return Global.KG_COLLECTION_NAME_Predicate;
    }
}
