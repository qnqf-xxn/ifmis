package gov.mof.fasp2.pmkpi.common.pendingtask;

import java.util.List;

/**
 {
     "return_msg": "查询成功",
     "return_code": "0000",
     "count_all": "5",
     "type_data": [
        /////////////////////////////////////////    PendingTaskDTO    /////////////////////////////////////////////////////////////////////////////
         {
             "data": [
                 {
                 "id": "202719",
                 "title ": "转移支付信息待审核",,
                 "todocount": "145",
                 "menuurl": "/bdg/commonmanage/audit.page?mouldid=50BA2350F9AD4563BJDKCJ39A6A98765&vchtypeid=283F43F0D5B6317931488F5BF5D981AA&mainmenu=BDG000&submenu=458237FDC27E6C2EC8ABCF8D0B5A4436&appid=bdg&mainmenu=BDGTZTJ120&submenu=458237FDC27E6C2EC8ABCF8D0B5A4436&appid=bdg&param1=0&param2=50BA2350F9AD4563BJDKCJ39A6A98765&param3=283F43F0D5B6317931488F5BF5D981AA&param4=null&param5=BA_BGT_MAIN&tabcode=4000200001&year=2021",
                 下面这些感觉不需要，就不返回了。
                 "button1name": "",
                 "button2name": "",
                 "button1url": " /page/fundsMgr/voucherMgr/voucherAudit/voucherAuditList.html",
                 "button2url": " /page/fundsMgr/voucherMgr/voucherAudit/voucherAuditList.html",
                 "buttonotheropin":"{operations:[{'funcname':'audit','title':'审核通过', 'url': ''},{'funcname':'back','title':'退回修改', 'url': ''},{'funcname':'obsolete','title':'不予安排',  'url': ''}],isrequired: true, historopinion :XXXXXXX} "
                 }
             ]
         }
        ////////////////////////////////////////  PendingTaskDTO   //////////////////////////////////////////////////////////////////////////////
     ]
 }
 */

/**
 *
 */
public class ResultDTO {
    String return_msg;
    String return_code;
    String count_all;
    List<PendingTaskDTO> type_data;

    public String getReturn_msg() {
        return return_msg;
    }

    public void setReturn_msg(String return_msg) {
        this.return_msg = return_msg;
    }

    public String getReturn_code() {
        return return_code;
    }

    public void setReturn_code(String return_code) {
        this.return_code = return_code;
    }

    public String getCount_all() {
        return count_all;
    }

    public void setCount_all(String count_all) {
        this.count_all = count_all;
    }

    public List<PendingTaskDTO> getType_data() {
        return type_data;
    }

    public void setType_data(List<PendingTaskDTO> type_data) {
        this.type_data = type_data;
    }
}
