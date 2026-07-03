package gov.mof.fasp2.pmkpi.dtsys.config;

import org.springframework.amqp.core.*;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;

/**
 * @description:
 * @author: timor
 * @create: 2022-05-16 20:23
 */
@Configuration
public class ConfirmConfig {

    /**
     * 财政部门交换机
     */
    public static final String MOF_AND_DEPT_DATA_EXCHANGE = "mofAndDeptDataExchange";
    /**
     * 一体化绩效队列
     */
    public static final String AH_PMKPI_QUEUE = " mofAndDeptDataExchange.pmkpi";
    /**
     * 一体化绩效路由key
     */
    public static final String AH_PMKPI_ROUTING_KEY = "mofAndDeptDataExchange.pmkpi.#";

    /**
     * 部门路由key
     */
    public static final String AH_DTSYS_ROUTING_KEY = "mofAndDeptDataExchange.dtsys.#";


    /**
     * 部门端队列
     */
    public static final String AH_DTSYS_QUEUE = " mofAndDeptDataExchange.dtsys";


    /**
     * 一体化绩效主题
     *
     * @return
     */
    @Bean("ahPmKpiTopic")
    public Exchange ahPmKpiTopic() {
        return ExchangeBuilder.topicExchange(MOF_AND_DEPT_DATA_EXCHANGE).durable(true).build();
    }

    /**
     * 一体化绩效队列
     *
     * @return
     */
    @Bean("ahPmKpiQueue")
    public Queue ahPmKpiQueue() {
        HashMap<String, Object> map = new HashMap<>(8);
        return new Queue(AH_PMKPI_QUEUE, true, false, false, map);
    }


    /**
     * 绑定一体化绩效队列和交换器
     *
     * @param queue
     * @param exchange
     * @return
     */
    @Bean
    public Binding queuePmKpiTopicBindingExchange(@Qualifier("ahPmKpiQueue") Queue queue,
                                                  @Qualifier("ahPmKpiTopic") Exchange exchange) {
        return BindingBuilder.bind(queue).to(exchange).with(AH_PMKPI_ROUTING_KEY).noargs();
    }


    /**
     * 部门端路由
     *
     * @return
     */
    @Bean("ahDtSysQueue")
    public Queue ahDtSysQueue() {
        HashMap<String, Object> map = new HashMap<>(8);
        return new Queue(AH_DTSYS_QUEUE, true, false, false, map);
    }


    /**
     * 绑定部门端交换机和队列
     *
     * @param queue    队列
     * @param exchange 交换器
     * @return
     */
    @Bean
    public Binding queueDtSysTopicBindingExchange(@Qualifier("ahDtSysQueue") Queue queue,
                                                  @Qualifier("ahPmKpiTopic") Exchange exchange) {
        return BindingBuilder.bind(queue).to(exchange).with(AH_DTSYS_ROUTING_KEY).noargs();
    }

}
