package gov.mof.fasp2.pmkpi.evaluation.financial.prjindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.cache.Fasp2DaoCacheUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaPrjIndexBO extends PmkpiBO {

    private EvaPrjIndexDAO evaPrjIndexDAO;

    public void setEvaPrjIndexDAO(EvaPrjIndexDAO evaPrjIndexDAO) {
        this.evaPrjIndexDAO = evaPrjIndexDAO;
    }

    /**
     * 查询数据方法
     *
     * @param parms --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) parms.get("mainguid");
        String tablecode = (String) parms.get("tablecode");
        StringBuffer wheresql = new StringBuffer(" and mainguid = '").append(mainguid).append("' and is_deleted = '").append(2).append("'");
        //String wheresql = " and mianguid = '" + mainguid + "' and is_deleted = '2"+"'";
        List<Map<String, Object>> data = evaPrjIndexDAO.getData(wheresql.toString(), tablecode);
        backMap.put("data", data);
        return backMap;
    }


    /**
     * 列表保存.
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String,Object> reresult = new HashMap<>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        List<String> updatecols = (List) params.get("updatecols");
        if (updatecols == null) {
            updatecols = new ArrayList<>();
            updatecols.add("guid");
        }
        List<String> delcols = (List) params.get("delcols");
        if (delcols == null) {
            delcols = new ArrayList<>();
        }
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 0;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            i = i++;
            if (map.get("ordernum") == null || "".equals(map.get("ordernum"))) {
                map.put("ordernum", i);
            }
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("create_time", StringUtil.getSysDBDate());
                map.put("update_time", StringUtil.getSysDBDate());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("mof_div_code", SecureUtil.getUserSelectProvince());
                map.put("fiscal_year", CommonUtil.getYear());
                map.put("is_deleted", "2");
                map.put("mainguid",mainguid);
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        delcols.remove("guid");
        if (addlist.size() > 0) {
            evaPrjIndexDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            evaPrjIndexDAO.updateAllByMajorPK(Fasp2DaoCacheUtil.getTableColumn(tablecode), uplist, "guid", tablecode, updatecols);
        }
        if (deldatas.size() > 0) {
            evaPrjIndexDAO.saveAll(deldatas, evaPrjIndexDAO.PMKPI_TABLE_TMP_GUIDS);
            StringBuffer delsql = new StringBuffer(" exists(select 1 from ");
            delsql.append(evaPrjIndexDAO.PMKPI_TABLE_TMP_GUIDS).append(" a where a.guid=t.guid) ");
            evaPrjIndexDAO.delDatas(tablecode, delsql.toString());
        }

        return reresult;
    }
    /*public String getMaxcode(HashMap<String,Object> params) throws AppException {
        String tablecode = (String)params.get("tablecode");
        Map<String, Object> count = evaPrjIndexDAO.getCount(tablecode);
        String code = (String) count.get("code");
        BigDecimal bd=new BigDecimal(code);
        String year = CommonUtil.getYear();
        String province = SecureUtil.getCurrentUser().getProvince();
        String initOrderOn =province + year + "00000";
        BigDecimal add = bd.add(new BigDecimal(initOrderOn+"1"));
        String procode = add.toString();
        return  procode;
    }*/
    public String getMaxcode(HashMap<String,Object> params) throws AppException {
        List<Map<String,Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String frametype = (String) params.get("frametype");
        String levelno = (String) params.get("levelno");
        String superid = (String) params.get("superid");
        String wheresql = "";
        if(levelno != null && !levelno.isEmpty()){
            wheresql += " and levelno ="+levelno;
        }
        if(superid != null && !superid.isEmpty()){
            wheresql += " and superid ='"+superid+"'";
        }
        List<Map<String, Object>> list = new ArrayList<>();
        String returncode = "";
        //根据ASCII处理,编码规则一级指标 1-9 A-Z
        int maxcode = 48;
        if(levelno != null && "1".equals(levelno)){
            list = evaPrjIndexDAO.getMaxcode(wheresql);
            list.addAll(datas);
            for (Map<String, Object> map : list ) {
                String code = (String) map.get("code");
                char[] codechar = code.toCharArray();
                int value = Integer.valueOf(codechar[0]);
                if(value > maxcode){
                    maxcode = value;
                }
            }
            if(maxcode == 57){
                maxcode = 65;
            }else{
                maxcode = maxcode + 1;
            }
            returncode = String.valueOf((char) maxcode);
        }
        if(levelno != null && "2".equals(levelno)){
            if(frametype != null &&  !frametype.isEmpty()){
                wheresql += " and frametype ='"+frametype+"'";
            }
            List<Map<String, Object>> framelist = new ArrayList<>();
            for (Map<String, Object> map : datas ) {
                if(superid != null && superid.equals(map.get("superid"))){
                    framelist.add(map);
                }
            }
            list = evaPrjIndexDAO.getMaxcode(wheresql);
            list.addAll(framelist);
            for (Map<String, Object> map : list ) {
                String code = (String) map.get("code");
                char[] codechar = code.toCharArray();
                int value = Integer.valueOf(codechar[1]);
                if(value > maxcode){
                    maxcode = value;
                }
            }
            if(maxcode == 57){
                maxcode = 65;
            }else{
                maxcode = maxcode + 1;
            }
            returncode = superid + String.valueOf((char) maxcode);
        }
        return  returncode;
    }
}

