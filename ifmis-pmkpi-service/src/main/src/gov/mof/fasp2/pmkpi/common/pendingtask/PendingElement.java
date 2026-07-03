package gov.mof.fasp2.pmkpi.common.pendingtask;

/**
 *
 //////////////////////////////    PendingElement    ////////////////////////////////////////////////////////////////////
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
     //////////////////////////////    PendingElement    ////////////////////////////////////////////////////////////////////
    */
public class PendingElement {
    String id;
    String title;
    String todocount;
    String menuurl;
    String button1name;
    String button2name;
    String button3name;
    String button1url;
    String button2url;
    String button3url;
    String buttonotheropin;
    String verison;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTodocount() {
        return todocount;
    }

    public void setTodocount(String todocount) {
        this.todocount = todocount;
    }

    public String getMenuurl() {
        return menuurl;
    }

    public void setMenuurl(String menuurl) {
        this.menuurl = menuurl;
    }

    public String getButton1name() {
        return button1name;
    }

    public void setButton1name(String button1name) {
        this.button1name = button1name;
    }

    public String getButton2name() {
        return button2name;
    }

    public void setButton2name(String button2name) {
        this.button2name = button2name;
    }

    public String getButton1url() {
        return button1url;
    }

    public void setButton1url(String button1url) {
        this.button1url = button1url;
    }

    public String getButton2url() {
        return button2url;
    }

    public void setButton2url(String button2url) {
        this.button2url = button2url;
    }

    public String getButtonotheropin() {
        return buttonotheropin;
    }

    public void setButtonotheropin(String buttonotheropin) {
        this.buttonotheropin = buttonotheropin;
    }

    public String getVerison() {
        return verison;
    }

    public void setVerison(String verison) {
        this.verison = verison;
    }

    public String getButton3name() {
        return button3name;
    }

    public void setButton3name(String button3name) {
        this.button3name = button3name;
    }

    public String getButton3url() {
        return button3url;
    }

    public void setButton3url(String button3url) {
        this.button3url = button3url;
    }
}
