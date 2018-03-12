package cn.youedata.KG.task;

import cn.youedata.KG.Global;
import cn.youedata.KG.Service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTask {

    @Autowired
    StatisticsService statisticsService;

    /**
     * 每天凌晨1点自动统计集合中文档数量
     */
    @Scheduled(cron = "0 0 1 * * ? ")   //每天凌晨1点执行一次
    public void statistics() {
        statisticsService.statisticsOfTheCol(Global.KG_COLLECTION_NAME_ENTITIES);
        statisticsService.statisticsOfTheCol(Global.KG_COLLECTION_NAME_TRIPLES);
    }

}
