package cn.youedata.KG.Dao;

import org.springframework.stereotype.Service;

/**
 * Created by zhongjianlv on 2018/4/9
 */
@Service
public class SameAsDaoImpl extends AbstractMongoDao {

    private String mainKGName;
    private String collection_name;

    public void setMainKGName(String main_kg_name) {
        this.mainKGName = main_kg_name;
        this.collection_name = "_" + main_kg_name + "SameAs";
    }

    @Override
    protected String getCollectionName() {
        return this.collection_name;
    }
}
