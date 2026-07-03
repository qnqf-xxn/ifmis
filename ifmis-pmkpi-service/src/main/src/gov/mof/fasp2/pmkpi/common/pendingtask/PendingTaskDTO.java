package gov.mof.fasp2.pmkpi.common.pendingtask;

import java.util.List;


public class PendingTaskDTO {
    List data;
    Integer ordernum;

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }

    public int getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(Integer ordernum) {
        this.ordernum = ordernum;
    }
}
