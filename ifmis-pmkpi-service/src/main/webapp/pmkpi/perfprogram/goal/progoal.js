if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _proguid;
var _prolev;
var _saveAgency;
var showtab;
var _isedittotal;
Ext.lt.pmkpi.progoal = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var _saveAgency = config["saveAgency"]; //项目单位
    _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _busguid = config.busguid;//审核定义guid
    var _prolev = config["prolev"]; //项目等级123级项目
    showtab = config.showtab; //页签展示
    var editinfo = config.goalinfo;
    var tabnum = 0; //页签点击次数
    var _cmp = {};
    tabcomps = config["goaldata"]; //目标数据.
    var iframeurl = config.iframeurl;//嵌套url
    var tabname = "";
    var hideIframeHtml = "";
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//" + document.location.host + "/" + iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    } else {
        var _procode = "";
        if (parent.editform) {
            if (parent.editform.getCol("pro_code")) {
                _procode = parent.editform.getCol("pro_code").getvalue();
            }
        }
    }



    //页面加载完成后执行
    $(function() {
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#editform").append(hideIframeHtml);
        }
/*        if (_viewtype == "query" || _isedittotal == '1') {
            editform.setdisabled({kpi_target:true});
        }*/
/*        if (showtab == "3"){ //处理年度显示的时候
            editform.setdisabled({zqgoal:false,kpi_target:true});
        }else if (showtab == "2"){
            editform.setdisabled({zqgoal:true,kpi_target:false});
        }else if (showtab == "1"){
            editform.setdisabled({zqgoal:true,kpi_target:true});
        }*/
        if (_isedittotal == "1"){
            editform.setdisabled({zqgoal:true,kpi_target:false});
        }else if(_isedittotal == "0"){
            editform.setdisabled({zqgoal:false,kpi_target:false});
        }
        if (showtab == "2"){
            editform.hide(['kpi_target'],false);
        }else if(showtab == "3"){
            editform.hide(['zqgoal'],false);
        }
        if (editinfo && editinfo.length > 0){
            editform.synchEditformByObj(editinfo[0]);
        }
    });


    /**
     * 项目指标保存方法
     * @param obj
     */
    _cmp.save = function (obj) {
        if (!editform.check()) {
            return false;
        }
        if (!editform.haschange() && editinfo && editinfo.length != 0){ //数据没有变化,不进行后台保存
            var obj = {};
            obj.success = true;
            return obj;
        }
        var editinfo = editform.getEditFormValues();
        if (!perfcommon.checkSpaceValue(editinfo,null,"editform")) return;//校验空格
        editinfo.kpi_target = convertStr(editinfo.kpi_target);
        var params = {};
        params.editinfo = editinfo;
        params.projguid = _proguid;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        var _procode = "";
        if (parent.editform) {
            if (parent.editform.getCol("pro_code")) {
                _procode = parent.editform.getCol("pro_code").getvalue();
            }
        }
        params.procode = _procode; //项目编码
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "savePrjIndex", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            //_cmp.init();
        }
        return rs;
    }

    return _cmp;
}