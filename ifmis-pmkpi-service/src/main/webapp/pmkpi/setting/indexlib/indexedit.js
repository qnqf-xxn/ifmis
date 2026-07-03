if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexinfoedit)
    Ext.lt.pmkpi.indexinfoedit = {};

Ext.lt.pmkpi.indexinfoedit = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _treeid = config.treeid,
        _indextype = config.indextype,//财政还是部门
        _pagetype = config.pagetype,//修改/新增
        _viewtype = config.viewtype,//查看
        _sindexdata = [],//指标数据
        _tabtype = config.tabtype, //左侧树数据源页签类型
        _superid = config.superid,
        _indexframe = config.indexframe,//指标层次分类
        _workflow = config["workflow"],
        _treename = config.treename,//左侧树名称
        _agency = config.agency,////湖北，浙江环境左侧树为项目(所选项目的agency)
        _isSX = config.isSX,
        _findex;//一级指标
        window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            computesign:{
                change: function(param){
                    var ecomputesignstr = param._value.value;
                    if(ecomputesignstr != "6"){
                        editform.show(['meterunit'],false);
                    } else { //隐藏计量单位
                        editform.clear("meterunit");
                        editform.hide(['meterunit'],false);
                    }
                }
            },
            sindex:{
                change: function(param){
                    if (param.sels && param.sels.length == 1) {
                        _findex = param.sels[0].superitemid;
                    } else {
                        _findex = "";
                    }
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    $(function () {
        if (_pagetype == "mod") {
            editform.synchEditformByObj(config.indexdata);
            var sindex = config.indexdata.sindex;
            for (var i=0; i<_indexframe.length; i++) {
                if (_indexframe[i].guid == sindex) {
                    editform.synchEditform({sindex:{text:_indexframe[i].name, value:sindex}});
                    break;
                }
            }
        } else { //新增根据传过来的额类型处理类型
            var tempobj = {};
            if (_tabtype=="PMKPIDEPT" || "PMKPIAGENCYALLPAY" == _tabtype){
                tempobj.framesystem = "DEPT";
            } else {
                tempobj.framesystem = "PM001";
            }
            editform.synchEditformByObj(tempobj);
        }
        editform.setdisabled({framesystem:true});
        if (_viewtype == "query") {
            common.editSetdisabled(editform);
            $("div[compid='toolbutton']").hide();
            $(".winfooter").hide();
        }
    })

    cmp.checkindexstandardsval = function (){
        var editdata = editform.getEditFormValues();
        var indexstandards = editdata.indexstandards;
        var indexstandardsArr = indexstandards.split(",");
        var checktips = "";
        for(var i=0;i<indexstandardsArr.length;i++){
            var indexstandard = indexstandardsArr[i];
            if(indexstandard == "indexstandards001" && editdata.indexstandardsval1 == ""){
                checktips +="计划标准指标值";
                checktips +=",";
            } else if(indexstandard == "indexstandards002" && editdata.indexstandardsval2 == ""){
                checktips +="历史标准指标值";
                checktips +=",";
            } else if(indexstandard == "indexstandards003" && editdata.indexstandardsval3 == ""){
                checktips +="行业标准指标值";
                checktips +=",";
            } else if(indexstandard == "indexstandards004" && editdata.indexstandardsval4 == ""){
                checktips +="国际标准指标值";
                checktips +=",";
            } else if(indexstandard == "indexstandards005" && editdata.indexstandardsval5 == ""){
                checktips +="其他标准指标值";
                checktips +=",";
            }
        }
        if(checktips!=""){
            Ext.lt.ui.alert("根据已选择绩效标准："+checktips.substring(0,checktips.length-1)+" 必填！",function(){});
            return false;
        }
        return true;
    }

    cmp.save = function () {
        if (!editform.check()) return;//先校验
        if (_isSX && _indextype =="dept" && !cmp.checkindexstandardsval()) return;//山西校验绩效标准指标值必填
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.pagetype = _pagetype;
        params.tabtype = _tabtype;
        params.agency = _agency;
        var editdata = editform.getEditFormValues();
        if (!common.checkSpaceValue(editdata,null,"editform")) return;//校验空格
        editdata.name = convertStr(editdata.name);
        editdata.perf_ind_name = convertStr(editdata.perf_ind_name);
        editdata.indexval = convertStr(editdata.indexval);
        editdata.kpi_val = convertStr(editdata.kpi_val);
        if (_pagetype != "mod") {
            if (_indextype =="finance" && _tabtype =="IDEXCOMCLS"){ //共性
                editdata.projtype = _treeid;
                editdata.is_common_ind ="1";
            } else if (_indextype =="finance" && _tabtype =="INDEXCOMFUNC"){ //个性
                editdata.indexcategories = _superid;
                editdata.industrycategory =_treeid;
                editdata.is_common_ind ="2";
            } else if (_indextype =="finance" && _tabtype =="INDEXTRANPAY"){ //转移支付
                editdata.indextranpay =_treeid;
                editdata.is_common_ind ="2";
            } else if (_indextype =="finance" && _tabtype =="INDEXCOMFUNC_JiangXi"){ //江西财政个性
                editdata.occupation =_treeid; //活动
                editdata.is_common_ind ="2";
            }  else { //部门：包含：项目，一级部门
                if (_tabtype =="PMKPIDEPT" || "PMKPIAGENCYALLPAY" == _tabtype){ //部门整体绩效
                    editdata.agencyguid = _treeid;
                    editdata.agency_code =_treeid;
                    editdata.agency_name = _treename;
                } else if (_tabtype =="INDEXCOMFUNC_JiangXi") {
                    editdata.occupation =_treeid; //活动
                } else if (_tabtype =="INDEXCOMFUNC_HuBei") {
                    editdata.pro_name =_treeid; //项目id
                    editdata.pro_type =_superid; //项目类型
                } else {
                    editdata.indexcategories = _superid;
                    editdata.industrycategory =_treeid;
                }
                editdata.is_common_ind ="2";
            }
        }
        editdata.findex = _findex;
        params.data = editdata;
        params.workflow = _workflow;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    parent.Ext.lt.pmkpi.query();
                    Ext.lt.ui.closeModalWindow();
                });
            } else {
                if (rs["message"] && rs["message"] != ""){
                    Ext.lt.ui.alert(rs.message,function(){
                    });
                } else {
                    Ext.lt.ui.alert('保存失败！',function(){
                    });
                }
            }
            Ext.lt.ui.loadingClose();
        },function(rs){
            Ext.lt.ui.loadingClose();
            if (rs["message"] && rs["message"] != ""){
                Ext.lt.ui.alert(rs.message,function(){
                });
            } else {
                Ext.lt.ui.alert('保存失败！',function(){
                });
            }
        });
    }
    return cmp;
}