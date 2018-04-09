package cn.youedata.KG.Service;

import cn.youedata.KG.Dao.StatisticsDaoImpl;
import cn.youedata.KG.Global;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.xml.bind.annotation.XmlElementDecl;
import java.time.LocalDate;

@Service
public class StatisticsService {

    @Autowired
    StatisticsDaoImpl statisticsDao;

    /**
     * 统计数据集中的文档个数
     * @param colName   要统计的数据集
     */
    public void statisticsOfTheCol(String colName) {
        for (String kgBase : Global.KG_BASES) {
            long count = statisticsDao.count(colName, kgBase);
            Document doc = new Document().append(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_DATA, LocalDate.now().toString())
                    .append(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_COLNAME, colName)
                    .append(Global.KG_COLLECTION_STATISTICS_FIELD_NAME_COUNT, count);
            statisticsDao.insert(doc, kgBase);
        }
    }
}
