if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.berforeviewservice = function(config, service) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var _busguid = config.busguid;//审核定义guid
    var _prolev = config["prolev"]; //项目等级123级项目
    var _saveAgency = config["saveAgency"];
    var _selectbillguid = config.selectbillguid;//调整前项目guid
    var _adjadd = config.adjadd;//是否调整
    var _pdmsave = config.pdmsave;//保存、查询类型
    var _procode = config.procode;
    var _editinfo = config.editinfo;
    var _cmp = {};
    var iframeurl = config.iframeurl;//嵌套url
    //是否显示编辑区，1不显示、2显示
    var hideIframeHtml = "";
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//"+ document.location.host +"/"+ iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    var isFirst = true;

    //页面加载完成后执行
    $(function() {
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#editform").append(hideIframeHtml);
        }
        if (_viewtype == "query") {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
        editform.synchEditformByObj(_editinfo);
        parent._isQuery = true;
        isFirst = false;
    });

    /**
     * 保存方法
     * @param obj
     */
    _cmp.save = function(obj){
        var params = {};
        if (!editform.check()) return false;//先校验
        params.edifinfo =  editform.getEditFormValues();
        params.proguid = _proguid;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.pro_code = _procode;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        return rs;
    }

    return _cmp;
}