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

    public void statisticsOfTheCol(String colName) {
        long count = statisticsDao.count(colName);
        Document doc = new Document().append("data", LocalDate.now().toString())
                .append("colname", colName)
                .append("count", count);
        statisticsDao.insert(doc, Global.KG_BAIDUBAIKE);
    }
}
