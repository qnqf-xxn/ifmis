if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.selfopinion) {
    Ext.lt.pmkpi.selfopinion = {};
}

Ext.lt.pmkpi.selfopinion = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _mainguid = config.mainguid,
        _bustype = config.bustype,
        _viewtype = config.viewtype,
        _busguid = config.busguid,
        _filedatas = config.filedatas,//附件类型
        _pagetype = config.pagetype,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        scrWidth =document.body.clientWidth-20,
        scrHeight =document.body.clientHeight-145;//审核定义guid

    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "getDatas", params, function(data){
            editform.synchEditformByObj(data);
            setMidSaveHidButtons({hidButtons:"暂存"});
            Ext.lt.ui.loadingClose();
            if (isquery) {
                parent._isQuery = true;
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }
    /**
     * 保存.
     * @returns {*}
     */
    cmp.save = function(){
        if (!editform.check()) {
            return false;//先校验
        }
        var params = {};
        var datas = editform.getEditFormValues();
        params.datas = datas;
        params.mainguid = _mainguid;
        params.busguid = _busguid;
        params.bustype = _bustype;
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        if (rs && rs.success) {
            cmp.query();
            Ext.lt.ui.alert('保存成功！',function(){
            });
        } else {
            Ext.lt.ui.alert('保存失败！',function(){
            });
        }
        return rs;
    }

    $(function () {
        common.initDatatable();
        if (_pagetype != "audit") {
            try{
                $("div[compid='toolbutton']").hide();
            }catch (e){
                document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
        }
        if (_pagetype != "audit" && (!_viewtype || _viewtype == "query")) {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
        datatable.setDatas(_filedatas);
        cmp.query(true);
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"||col["colcode"] == "filename"){
                col.onclick = function(td, el, l, c, d) {
                    var params = {};
                    params.filetype = d.guid;
                    if (_pagetype != "audit" || toolbutton.cfg.data.buttons.length == 0) {
                        params.viewtype = "query";
                    }
                    params.mainguid = _mainguid;
                    params.queryYear = _queryYear;
                    params.queryProvince = _queryProvince;
                    if (isGreyStyle()) {
                        parent.window.Ext.lt.pmkpi.newfilePanelInit(params,Ext.lt.pmkpi.setFileName);
                    }else{
                        var url = "/pmkpi/file/index.page";
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,scrWidth*0.7,scrHeight,"附件上传");
                    }
                };
            }
        }
    });

    /**
     * 列表附件名称显示进行刷新
     * @param filenames
     * @param billguid
     */
    Ext.lt.pmkpi.setFileName = function (filenames, billguid, fileguid){
        var parent_sel_rows = datatable.getRecordset().query({guid:fileguid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["filename"] = filenames;
        datatable.reflash(_sortid);
    }

    return cmp;
}