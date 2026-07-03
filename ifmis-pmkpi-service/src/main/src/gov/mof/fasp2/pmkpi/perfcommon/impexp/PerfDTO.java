package gov.mof.fasp2.pmkpi.perfcommon.impexp;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class PerfDTO extends HashMap implements Map, Serializable {
    private static final long serialVersionUID = -1080809606167478891L;

    public String getGuid() {
        return (String)this.get("guid");
    }

    public void setGuid(String guid) {
        this.put("guid", guid);
    }

    public String getCode() {
        return (String)this.get("code");
    }

    public void setCode(String code) {
        this.put("code", code);
    }

    public String getName() {
        return (String)this.get("name");
    }

    public void setName(String name) {
        this.put("name", name);
    }

    public String getSuperguid() {
        return (String)this.get("superguid");
    }

    public void setSuperguid(String superguid) {
        this.put("superguid", superguid);
    }

    public int getLevelno() {
        return ((Number)this.get("levelno")).intValue();
    }

    public void setLevelno(int levelno) {
        this.put("levelno", levelno);
    }

    public int getIsleaf() {
        return ((Number)this.get("isleaf")).intValue();
    }

    public void setIsleaf(int isleaf) {
        this.put("isleaf", isleaf);
    }

    public int getOrdernum() {
        return ((Number)this.get("ordernum")).intValue();
    }

    public void setOrdernum(int ordernum) {
        this.put("ordernum", ordernum);
    }

    public String getCreatetime() {
        return (String)this.get("createtime");
    }

    public void setCreatetime(String createtime) {
        this.put("createtime", createtime);
    }

    public String getUpdatetime() {
        return (String)this.get("updatetime");
    }

    public void setUpdatetime(String updatetime) {
        this.put("updatetime", updatetime);
    }

    public int getStatus() {
        Number n = (Number)this.get("status");
        return n == null ? 0 : ((Number)this.get("status")).intValue();
    }

    public void setStatus(int status) {
        this.put("status", status);
    }

    public int getYear() {
        return ((Number)this.get("year")).intValue();
    }

    public void setYear(int year) {
        this.put("year", year);
    }

    public String getProvince() {
        return (String)this.get("province");
    }

    public void setProvince(String province) {
        this.put("province", province);
    }

    public String getGuid1() {
        return (String)this.get("guid1");
    }

    public void setGuid1(String guid1) {
        this.put("guid1", guid1);
    }

    public String getGuid2() {
        return (String)this.get("guid2");
    }

    public void setGuid2(String guid2) {
        this.put("guid2", guid2);
    }

    public String getGuid3() {
        return (String)this.get("guid3");
    }

    public void setGuid3(String guid3) {
        this.put("guid3", guid3);
    }

    public String getGuid4() {
        return (String)this.get("guid4");
    }

    public void setGuid4(String guid4) {
        this.put("guid4", guid4);
    }

    public String getGuid5() {
        return (String)this.get("guid5");
    }

    public void setGuid5(String guid5) {
        this.put("guid5", guid5);
    }

    public String getGuid6() {
        return (String)this.get("guid6");
    }

    public void setGuid6(String guid6) {
        this.put("guid6", guid6);
    }

    public String getGuid7() {
        return (String)this.get("guid7");
    }

    public void setGuid7(String guid7) {
        this.put("guid7", guid7);
    }

    public String getGuid8() {
        return (String)this.get("guid8");
    }

    public void setGuid8(String guid8) {
        this.put("guid8", guid8);
    }

    public String getGuid9() {
        return (String)this.get("guid9");
    }

    public void setGuid9(String guid9) {
        this.put("guid9", guid9);
    }

    public String getGuid10() {
        return (String)this.get("guid10");
    }

    public void setGuid10(String guid10) {
        this.put("guid10", guid10);
    }

    public PerfDTO(Map m) {
        this.putAll(m);
    }

    public PerfDTO() {
    }

    public String getString(String key) {
        return (String)this.get(key);
    }

    public Object get(Object key) {
        return super.get(key);
    }

    public Object put(Object key, Object value) {
        if (key instanceof String) {
            key = ((String)key).toLowerCase();
        }

        return super.put(key, value);
    }

    public Object remove(Object key) {
        if (key instanceof String) {
            key = ((String)key).toLowerCase();
        }

        return super.remove(key);
    }
}
