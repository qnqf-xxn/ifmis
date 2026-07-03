if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfcommon){
    Ext.lt.pmkpi.perfcommon = {};
}

Ext.lt.pmkpi.perfcommon.uploadfilelist = function(config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _viewtype = config.viewtype,
        _bustype = config.bustype,
        _mainguid = config.mainguid,
        _projguid = config.projguid,
        _procode = config.pro_code,
        _subprovince = config.subprovince,  //绩效管理工作考核 - 下级区划
        _taskyear = config.taskyear,          //绩效管理工作考核 - 查看任务年度
        _taskprovince = config.taskprovince,  //绩效管理工作考核 - 查看任务区划
        _menuid = config.menuid,
        _workflow = config.workflow,
        _rectype = config.rectype,
        _rectifyType = config.rectifyType,
        _filebustype = config.filebustype,
        _tablecode,
        _defquery,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        scrWidth =document.body.clientWidth-20,
        scrHeight =document.body.clientHeight
    ;
    if(config.datas != null && config.datas != ""){
        Ext.lt.pmkpi.perfcommon.datas = config.datas[0];
    }

    $(function (){
        common.initDatatable();
        if(_SYSTEMSTYLE_ == "grey"){//附件列表 新ui去掉列表组件按钮
            $("#datatable").find(".titlename").siblings().hide();
        }
        Ext.lt.pmkpi.query();
        if (Ext.lt.pmkpi.perfcommon.datas != null) {
            editform.synchEditformByObj(Ext.lt.pmkpi.perfcommon.datas);
        }
    });

    /**
     * 保存
     */
    cmp.save = function(){
        if (!editform.check()) {
            return false;//先校验
        }
        var params = {};
        Ext.lt.ui.loadingShow();
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.pro_code = _procode;
        params.workflow = _workflow;
        params.viewtype = _viewtype;
        params.bustype = _bustype;
        params.type =_rectifyType;
        params.rectype = _rectype; //整改类型   1:整改-选项目  2：自评-整改  3：监控 - 整改
        params.rectifycontent = editform.getEditFormValues();//获取页面上编辑框的值
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        Ext.lt.ui.loadingClose();
        return rs;
    }

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        var params = {};
        params.bustype = _bustype;
        params.tablecode = _tablecode;
        params.filebustype = _filebustype;
        params.viewtype = _viewtype;
        params.mainguid = _mainguid;
        params.querySql = _defquery;
        params.subprovince = _subprovince;
        params.taskprovince = _taskprovince;
        params.taskyear = _taskyear;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;

        /*params.beanid = "pmkpi.perfcommon.UploadFileBOTX";
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });*/
        Ext.lt.RCP.call(service , "queryFiletype", params, function(rs){
            setMidSaveHidButtons({hidButtons:"暂存"});
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _defquery = uiconfig.defquery;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"||col["colcode"] == "filename"){
                col.onclick = function(td, el, l, c, d) {
                    if(d._isleaf != 1 && !d.filename){
                        return false;
                    }
                    var params = {};
                    params.filetype = d.guid;
                    params.viewtype = _viewtype;
                    params.mainguid = _mainguid;
                    params.queryYear = _queryYear!=undefined ? _queryYear : _taskyear;
                    params.queryProvince = _queryProvince!=undefined ? _queryProvince : _taskprovince;
                    if (isGreyStyle()) {
                        // Ext.lt.pmkpi.newfilePanelInit(params);
                        parent.window.Ext.lt.pmkpi.newfilePanelInit(params,Ext.lt.pmkpi.setFileName);
                    }else{
                        var url = "/pmkpi/file/index.page";
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,scrWidth*0.7,scrHeight*0.9,"附件上传");
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