package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class PrjSumIndexBO extends PmkpiBO {
    private PrjSumIndexDAO prjSumIndexDAO;

    public void setPrjSumIndexDAO(PrjSumIndexDAO prjSumIndexDAO) {
        this.prjSumIndexDAO = prjSumIndexDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String pro_code = (String) params.get("pro_code");
        String proguid = "";
        String bustype = (String) params.get("bustype");
        //根据一级项目编码，查询所有的二级项目
        List<Map<String, Object>> proList = this.getDatas(PmkpiDAO.PMKPI_TABLE_PROJECT_INFO, "parent_pro_code=? or pro_code = ?", null, new String[]{pro_code, pro_code});
        List<String> procodes = new ArrayList<>();
        for (Map<String, Object> proMap : proList) {
            String procode = (String) proMap.get("pro_code");
            procodes.add(procode);
            if (pro_code.equals(procode)) {
                proguid = (String) proMap.get("guid");
            }
        }
        String wheresql = " t.mainguid = ? and yearflag = '1' and isapply = 1 and t.is_deleted = 2 and is_backup = 2 and t.province=?";
        String orderby = " order by agency_code,findex,sindex,ordernum";
        //查询一级指标
        List<Map<String, Object>> fixIndexList = prjSumIndexDAO.getDatas(PerfConstant.PMKPI_BACKUP_INDICATOR, wheresql, orderby, new String[]{proguid, SecureUtil.getUserSelectProvince()});
        String type = "PM001";
        List<Map<String, Object>> tempdatas = prjSumIndexDAO.getTempdatas(type);
        List<Map<String, Object>> collist = prjSumIndexDAO.getCol(PerfConstant.PMKPI_VPM_INDICATOR);
        List<Map<String, Object>> datas = new ArrayList<>();
        for (Map<String, Object> map : tempdatas) {
            map.put("indexguid", "");
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || value.isEmpty() || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("isleaf", "0");
            map.put("_isleaf", "0");
        }
        if (!procodes.isEmpty()) {
            //查询二级指标
            wheresql = prjSumIndexDAO.createInSql("pro_code", procodes);
            wheresql += " and yearflag = '0' and isapply = 1 ";
            List<Map<String, Object>> indexList = prjSumIndexDAO.getDatas(PerfConstant.PMKPI_VPM_INDICATOR, wheresql, orderby);
            //带下去的二级指标
            List<Map<String, Object>> parindexList = indexList.stream().filter(mm -> "1".equals(mm.get("isfromparent") + "")).collect(Collectors.toList());
            for (Map<String, Object> fixMap : fixIndexList) {
                String name = (String) fixMap.get("name");
                String computesign = (String) fixMap.get("computesign");
                String meterunit = (String) fixMap.get("meterunit");
                String indexval = "";
                String isallowedit = fixMap.get("isallowedit") + "";//是否可编辑,1是 2否
                String onlyself = fixMap.get("onlyself") + "";//是否只适用于一级指标 1是 2否
                List<Map<String, Object>> l = parindexList.stream().filter(mm -> name.equals(mm.get("name") + "")).collect(Collectors.toList());
                //判断一级指标是否在二级指标中适用，不适用，不展示该指标
                if (l.size() == 0 && !"1".equals(onlyself)) {
                    continue;
                }
                //可编辑、适用二级指标的进行汇总
                if (!"2".equals(isallowedit) && !"1".equals(onlyself)) {
                    if ("1".equals(computesign) || "2".equals(computesign) || "3".equals(computesign)
                            || "4".equals(computesign) || "5".equals(computesign)) {
                        BigDecimal a = new BigDecimal("0");
                        int i = 0;
                        for (Map<String, Object> indMap : indexList) {
                            if (name.equals(indMap.get("name"))) {
                                String val = (String) indMap.get("indexval");
                                BigDecimal b = new BigDecimal(val);
                                a = PerfUtil.addTwoNum(a, b);
                                if ("%".equals(meterunit) || "百分比".equals(meterunit)) {
                                    ++i;
                                }
                            }
                        }
                        if (i > 0) {
                            indexval = String.valueOf(PerfUtil.delTwoNum(a, BigDecimal.valueOf(i), 2));
                        } else {
                            indexval = String.valueOf(a);
                        }
                        fixMap.put("indexval", indexval);
                        datas.add(fixMap);
                    } else {
                        for (Map<String, Object> indMap : indexList) {
                            if (name.equals(indMap.get("name"))) {
                                String agency_code = (String) indMap.get("agency_code");
                                String pro_name = (String) indMap.get("pro_name");
                                indMap.put("name", name + "(" + agency_code + "-" + pro_name + ")");
                                datas.add(indMap);
                            }
                        }
                    }
                } else {
                    datas.add(fixMap);
                }
            }
            List<Map<String, Object>> addList = indexList.stream().filter(mm -> !"1".equals(mm.get("isfromparent") + "")).collect(Collectors.toList());
            for (Map<String, Object> indMap : addList) {
                String name = (String) indMap.get("name");
                String agency_code = (String) indMap.get("agency_code");
                String pro_name = (String) indMap.get("pro_name");
                indMap.put("name", name + "(" + agency_code + "-" + pro_name + ")");
                datas.add(indMap);
            }
        }
        if ("parentprogram".equals(bustype)) {
            backMap.put("datas", datas);
        } else {
            tempdatas.addAll(datas);
            backMap.put("datas", tempdatas);
        }
        return backMap;
    }
}
